close all;
clear;
clc;
%-----------
%Here we just run our program making a comparison with the two
%implementations; note that just giving a compression factor equal to 5 we
%seriously compromise the image quality, in particular with the second
%image. After 30, we've seriuos difficulties to understand what the image
%is. After 50 is almost impossible.
%Notice that having a "zero" compression doesn't mean we're having a
%lossless procedure
%-----------
image = imread('Images/bird.bmp');
%-----------
[simpleCompressedImage, simplecompressionRatio] = simpleJPEGcomp(image, 20);
imwrite(simpleCompressedImage, 'hCompression.bmp');

disp('Simple Huffman compression Ratio:');
disp(simplecompressionRatio);
%-----------
[compressedImage, RLcompressionRatio] = JPEGcomp(image, 20);
imwrite(compressedImage, 'rlCompression.bmp');

disp('Runlength Huffman compression Ratio:');
disp(RLcompressionRatio);
%-----------
figure(1)
subplot(1, 3, 1)
imshow(image);
subplot(1, 3, 2)
imshow(simpleCompressedImage);
subplot(1, 3, 3)
imshow(compressedImage);