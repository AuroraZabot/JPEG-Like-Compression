function [coding, dict, bits] = simpleHuffman(inputMatrix)
% In order to obtain the symbol frequency to construct the dictionary, we've
% use the method "hist", that return the number associated of each bin
% given in input in a certain vector; in our specific case, we've obtained
% the symbols of the input matrix through "unique", that cancels
% repetitions, and we've use it as "bin" in hist. After this, we've
% calculated the probability associated to each symbol as the common
% probability formula (p(a) = a / sum) and then we've use the "huffmandict"
% and "huffmanenco" methods offered by Matlab. The only issue we've found
% was when we've just one bin (normally a zero matrix), so in this case
% we've just use a dummy element to differentiate the encoding process.
matrix = reshape(inputMatrix, 1, []);
symbols = unique(matrix);
dim = size(symbols, 2);
if (dim ~= 1)
    counts = hist(matrix, symbols);
    p = double(counts) ./ sum(counts);
    dict = huffmandict(symbols, p);
    coding = huffmanenco(matrix, dict);
else
    dict = symbols(1);
    coding = 0;
end

%We compute the number of bits used after the encoding procedure in order
%to output the compression ratio
imageCompressedBitstream = de2bi(coding);
imageCompressedBits = numel(imageCompressedBitstream);
bits = imageCompressedBits;
end