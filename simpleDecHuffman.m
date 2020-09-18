function decoding = simpleDecHuffman(code, dict)
% Here we just decode the matrix having the code and the associated
% dictionary. If we receive the dummy matrix instead, we just give back the
% same input matrix without any probabilistic construction
if (size(code, 2) ~= 1)
    decoding = huffmandeco(code, dict);
    decoding = reshape(decoding, 8, 8);
else
    decoding = dict(1)*ones(8, 8);
end
end