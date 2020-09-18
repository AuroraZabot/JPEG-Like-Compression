function [output, ratio] = simpleJPEGcomp(imagePix, compressionFactor)
%-----------
%First of all we need to check the validity of the input parameters; in
%particular if the first input parameter is a 8 bit image and if the second
%one is a positive number; all the quality parameters exceeding 100 would 
%be counted as the maximum, so we don't need an report an error. 
%-----------
if (nargin < 2)
    error("Not enough parameters");
end
if (~isa(imagePix, 'uint8'))
    error("The input must be a 8 bit image");
end
if (nargin == 2 && compressionFactor <= 0)
    error("Compression factor must be greater than zero");
end
%-----------
%Here we need to zero-pad the image if the dimension of rows and columns is not
%a integer multiple of 8. This portion would be removed at the end of the
%computation
%-----------
[height, width, ~] = size(imagePix);
rows = height;
cols = width;

if (mod(rows, 8)~= 0)
    pad = 8 - rem(rows, 8);
    matrixPad = zeros(pad, cols, 3);
    imagePix = [imagePix; matrixPad];
    rows = size(imagePix, 1);
end
if (mod(cols, 8)~= 0)
    pad = 8 - rem(cols, 8);
    matrixPad = zeros(rows, pad, 3);
    imagePix = [imagePix matrixPad];
    cols = size(imagePix, 2);
end
%-----------
% As we've seen from the theory, the first step of the algorithm is to 
% convert the RGB components into the YUV/YCbCr ones. There's a method in 
% Matlab to do so, otherwise I would implement the conversion manually 
%(since is just a linear conversion). We also need to subtract the value
%128 in order to "normalize" the levels.
%Normally, we should include a check on the number of channels in order to
%understand if the image is colored of B&W; in the second case of course
%there's no need of the YUV conversion. By the way, the assignment
%specified to develope a JPEG like approach with colored images, and for
%this reason we don't check anything.
%We also calculate the number of bits in the original image in order to
%compute the compression ratio
%-----------
if (size(imagePix) ~= 3)
    error("You must use a RGB image");
end

imagePix = uint8(imagePix);

imageBitstream = de2bi(imagePix);
uncompressedBitstream = numel(imageBitstream);

YCbCrConv = rgb2ycbcr(imagePix);
Y = YCbCrConv(:,:,1);
Cb = YCbCrConv(:,:,2);
Cr = YCbCrConv(:,:,3);

Y = double(Y) - 128;
Cb = double(Cb) - 128;
Cr = double(Cr) - 128;
%-----------
%We need to manually insert Quantization Tables for the luminance and the
%chrominance components. We would use the recommended ones for JPEG
%standard
%-----------
Qchroma = [...
    17 18 24 47 99 99 99 99;
    18 21 26 66 99 99 99 99;
    24 26 56 99 99 99 99 99;
    47 66 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99];

Qlum = [...
    16 11 10 16 24 40 51 61;
    12 12 14 19 26 58 60 55;
    14 13 16 24 40 57 69 56;
    14 17 22 29 51 87 80 62;
    18 22 37 56 68 109 103 77;
    24 36 55 64 81 104 113 92;
    49 64 78 87 103 121 120 101;
    72 92 95 98 112 100 103 99];
%-----------
%We need to rescale proportionally to the compression factor given in input; 
%as we've mentioned in the theory part of the report, we need to strengthen the two
%quantization matrices. Searching on the web the percentage associated to a
%the qualities (not the compressions), I've found that: >90% is considered max quality, from 80 to 
%90% is high quality, 45-60% is medium quality and <45% typically low and 
%very low quality image. In any case, we just put a cup on the compression
%factor (when it's over 100%) and we just converted the compression factor
%in order to fit it with the JPEG standard
%-----------
if compressionFactor > 100
    compressionFactor = 100;
end

quality = 1/compressionFactor;

Qchroma = round(Qchroma .* (quality*100));
Qlum = round(Qlum .* (quality*100));
%-----------
%The next step is to apply DCT after the 8x8 sub-block split. In order to
%do so, we would use the method blockproc offeded by Matlab; by definition,
%this method processes the input by applying a specific function to each 
%distinct block of size [m n] and concatenating the results into the output.
%The function in our case wuold be "dct2", 2-D cosine transform, offered as
%well by Matlab. 
%-----------
dct = @(block_struct) dct2(block_struct.data);

YDct = blockproc(Y, [8,8], dct);
CbDct = blockproc(Cb, [8,8], dct);
CrDct = blockproc(Cr, [8,8], dct);
%-----------
%Now we need to quantize the blocks thorugh the quantization tables. We
%would use the first approach described in the theory part of the report,
%so we take the division through the obtained DCT coefficient, add 0.5 and
%floor the result. As it was already mention, another approach consists in
%just round the first division.
%-----------
coeffY = @(block_struct) floor((block_struct.data ./ Qlum) + 0.5);
coeffC = @(block_struct) floor((block_struct.data ./ Qchroma) + 0.5);

quantY = blockproc(YDct, [8 8], coeffY);
quantCb = blockproc(CbDct, [8 8], coeffC);
quantCr = blockproc(CrDct, [8 8], coeffC);

[rowsQY, colsQY, ~] = size(quantY);
[rowsQCb, colsQCb, ~] = size(quantCb);
[rowsQCr, colsQCr, ~] = size(quantCr);
%-----------
%Now we need to encode our function using the Huffman coding procedure.
%We need to create the dictionary first, then to encode our blocks; we've
%used the method "hist" offered by Matlab, that allow us to calculate the
%symbol percentage in order to create the dictionary necessary to the
%huffman decoding procedure. We just code and decode each block without
%using blockproc (that give us many errors in this part (probably due to
%the implementation technique not offered by matlab) but just using rows
%and columns.
%We also calculate the number of bits used at the end of the encoding
%procedure in order to compute the compression ratio
%-----------
decodedY = zeros(rowsQY, colsQY);
decodedCb = zeros(rowsQCr, colsQCr);
decodedCr = zeros(rowsQCb, colsQCb);

bitstreamY = 0;
bitstreamCb = 0;
bitstreamCr = 0;

for i = 1:8:rowsQY
    for j = 1:8:colsQY
        block = quantY(i:i+7, j:j+7);
        [codeY, dictY, bitsY] = simpleHuffman(block);
        bitstreamY = bitsY + bitstreamY; 
        decodedY(i:i+7, j:j+7) = simpleDecHuffman(codeY, dictY);
    end
end

for i = 1:8:rowsQCb
    for j = 1:8:colsQCb
        block = quantCb(i:i+7, j:j+7);
        [codeCb, dictCb, bitsCb] = simpleHuffman(block);
        bitstreamCb = bitstreamCb + bitsCb;
        decodedCb(i:i+7, j:j+7) = simpleDecHuffman(codeCb, dictCb);
    end
end

for i = 1:8:rowsQCr
    for j = 1:8:colsQCr
        block = quantCr(i:i+7, j:j+7);
        [codeCr, dictCr, bitsCr] = simpleHuffman(block);
        bitstreamCr = bitstreamCr + bitsCr;
        decodedCr(i:i+7, j:j+7) = simpleDecHuffman(codeCr, dictCr);
    end
end

compressedBitstream = bitstreamY + bitstreamCb + bitstreamCr;
%-----------
%After the Huffman coding and decoding procedure, we need to dequantize our
%blocks; we just need to re-multiply the decoded matrix by the two initial
%matrix of luminance e chrominance.
%-----------
decoeffY = @(block_struct) (block_struct.data .* Qlum);
decoeffC = @(block_struct) (block_struct.data .* Qchroma);

dequantY = blockproc(decodedY,[8 8], decoeffY);
dequantCb = blockproc(decodedCb,[8 8], decoeffC);
dequantCr = blockproc(decodedCr,[8 8], decoeffC);
%-----------
%The second to last step is to perform the inverse DCT on each block using
%blocproc once again.
%-----------
idct = @(block_struct) idct2(block_struct.data);

idctY = blockproc(dequantY, [8 8], idct);
idctCb = blockproc(dequantCb, [8 8], idct);
idctCr = blockproc(dequantCr, [8 8], idct);
%-----------
%The very last step of our work are the shift level and the color space 
%conversion, with the suitable adjustment on the size; we also output the
%final compression ratio of the image
%-----------
idctY = idctY + 128;
idctCb = idctCb + 128;
idctCr = idctCr + 128;

image(:, :, 1) = idctY;
image(:, :, 2) = idctCb;
image(:, :, 3) = idctCr;
image = uint8(image);
output = ycbcr2rgb(image);

ratio = compressionRatio(uncompressedBitstream, compressedBitstream);

if (rows ~= height || cols ~= width)
    output = output(1:height, 1:width, :);
end
end