function [huffEncoded, bits] = huffman(R, S, NZ)
%We've chosen to develop this part using the provided Huffman Tables for
%JPEG encoding; we just make a match in the table and compute the code
dim = size(R, 2);
R = dec2hex(R);
S = dec2hex(S);
huff = strings(dim, 1);
range = strings(dim, 1);
h = strings(dim, 1);

if (S(1) == '0')
    huff(1) = '00';
elseif (S(1) == '1')
    huff(1) = '010';
elseif (S(1) == '2')
    huff(1) = '011';
elseif (S(1) == '3')
    huff(1) = '100';
elseif (S(1) == '4')
    huff(1) = '101';
elseif (S(1) == '5')
    huff(1) = '110';
elseif (S(1) == '6')
    huff(1) = '1110';
elseif (S(1) == '7')
    huff(1) = '11110';
elseif (S(1) == '8')
    huff(1) = '111110';
elseif (S(1) == '9')
    huff(1) = '1111110';
elseif (S(1) == 'A')
    huff(1) = '11111110';
elseif (S(1) == 'B')
    huff(1) = '111111110';
end
category = findCategory(NZ(1));

if (NZ(1) > 0)
    range(1) = dec2bin(NZ(1), category);
elseif (NZ(1) == 0)
    range(1) = dec2bin(NZ(1));
elseif (NZ(1) < 0)
    absValue = dec2bin(abs(NZ(1)), category);
    oneComplement = not(absValue - '0');
    range(1) = char(oneComplement + '0');
end

h(1) = strcat(huff(1), " ", range(1));

for i = 2:1:dim
    if (R(i) == '0')
        if (S(i) == '0')
            huff(i) = '1010';
            elseif (S(i) == '1')
                huff(i) = '00';
            elseif (S(i) == '2')
                huff(i) = '01';
            elseif (S(i) == '3')
                huff(i) = '100';
            elseif (S(i) == '4')
                huff(i) = '1011';
            elseif (S(i) == '5')
                huff(i) = '11010';
            elseif (S(i) == '6')
                huff(i) = '1111000';
            elseif (S(i) == '7')
                huff(i) = '11111000';
            elseif (S(i) == '8')
                huff(i) = '1111110110';
            elseif (S(i) == '9')
                huff(i) = '1111111110000010';
            elseif (S(i) == 'A')
                huff(i) = '1111111110000011';
        end
    elseif (R(i) == '1')
        if (S(i) == '1')
            huff(i) = '1100';
        elseif (S(i) == '2')
            huff(i) = '11011';
        elseif (S(i) == '3')
            huff(i) = '1111001';
        elseif (S(i) == '4')
            huff(i) = '111110110';
        elseif (S(i) == '5')
            huff(i) = '11111110110';
        elseif (S(i) == '6')
            huff(i) = '1111111110000100';
        elseif (S(i) == '7')
            huff(i) = '1111111110000101';
        elseif (S(i) == '8')
            huff(i) = '1111111110000110';
        elseif (S(i) == '9')
            huff(i) = '1111111110000111';
        elseif (S(i) == 'A')
            huff(i) = '1111111110001000';
        end
    elseif (R(i) == '2')
        if (S(i) == '1')
            huff(i) = '11100';
        elseif (S(i) == '2')
            huff(i) = '11111001';
        elseif (S(i) == '3')
            huff(i) = '1111110111';
        elseif (S(i) == '4')
            huff(i) = '111111110100';
        elseif (S(i) == '5')
            huff(i) = '1111111110001001';
        elseif (S(i) == '6')
            huff(i) = '1111111110001010';
        elseif (S(i) == '7')
            huff(i) = '1111111110001011';
        elseif (S(i) == '8')
            huff(i) = '1111111110001100';
        elseif (S(i) == '9')
            huff(i) = '1111111110001101';
        elseif (S(i) == 'A')
            huff(i) = '1111111110001110';
        end
    elseif (R(i) == '3')    
        if (S(i) == '1')
            huff(i) = '111010';
        elseif (S(i) == '2')
            huff(i) = '111110111';
        elseif (S(i) == '3')
            huff(i) = '111111110101';
        elseif (S(i) == '4')
            huff(i) = '1111111110001111';
        elseif (S(i) == '5')
            huff(i) = '1111111110010000';
        elseif (S(i) == '6')
            huff(i) = '1111111110010001';
        elseif (S(i) == '7')
            huff(i) = '1111111110010010';
        elseif (S(i) == '8')
            huff(i) = '1111111110010011';
        elseif (S(i) == '9')
            huff(i) = '1111111110010100';
        elseif (S(i) == 'A')
            huff(i) = '1111111110010101';
        end
    elseif (R(i) == '4')
        if (S(i) == '1')
            huff(i) = '111011';
        elseif (S(i) == '2')
            huff(i) = '1111111000';
        elseif (S(i) == '3')
            huff(i) = '1111111110010110';
        elseif (S(i) == '4')
            huff(i) = '1111111110010111';
        elseif (S(i) == '5')
            huff(i) = '1111111110011000';
        elseif (S(i) == '6')
            huff(i) = '1111111110011001';
        elseif (S(i) == '7')
            huff(i) = '1111111110011010';
        elseif (S(i) == '8')
            huff(i) = '1111111110011011';
        elseif (S(i) == '9')
            huff(i) = '1111111110011100';
        elseif (S(i) == 'A')
            huff(i) = '1111111110011101';
        end
    elseif (R(i) == '5')
        if (S(i) == '1')
            huff(i) = '1111010';
        elseif (S(i) == '2')
            huff(i) = '11111110111';
        elseif (S(i) == '3')
            huff(i) = '1111111110011110';
        elseif (S(i) == '4')
            huff(i) = '1111111110011111';
        elseif (S(i) == '5')
            huff(i) = '1111111110100000';
        elseif (S(i) == '6')
            huff(i) = '1111111110100001';
        elseif (S(i) == '7')
            huff(i) = '1111111110100010';
        elseif (S(i) == '8')
            huff(i) = '1111111110100011';
        elseif (S(i) == '9')
            huff(i) = '1111111110100100';
        elseif (S(i) == 'A')
            huff(i) = '1111111110100101';
        end
    elseif (R(i) == '6')
        if (S(i) == '1')
            huff(i) = '1111011';
        elseif (S(i) == '2')
            huff(i) = '111111110110';
        elseif (S(i) == '3')
            huff(i) = '1111111110100110';
        elseif (S(i) == '4')
            huff(i) = '1111111110100111';
        elseif (S(i) == '5')
            huff(i) = '1111111110101000';
        elseif (S(i) == '6')
            huff(i) = '1111111110101001';
        elseif (S(i) == '7')
            huff(i) = '1111111110101010';
        elseif (S(i) == '8')
            huff(i) = '1111111110101011';
        elseif (S(i) == '9')
            huff(i) = '1111111110101100';
        elseif (S(i) == 'A')
            huff(i) = '1111111110101101';
        end
    elseif (R(i) == '7')
        if (S(i) == '1')
            huff(i) = '11111010';
        elseif (S(i) == '2')
            huff(i) = '111111110111';
        elseif (S(i) == '3')
            huff(i) = '1111111110101110';
        elseif (S(i) == '4')
            huff(i) = '1111111110101111';
        elseif (S(i) == '5')
            huff(i) = '1111111110110000';
        elseif (S(i) == '6')
            huff(i) = '1111111110110001';
        elseif (S(i) == '7')
            huff(i) = '1111111110110010';
        elseif (S(i) == '8')
            huff(i) = '1111111110110011';
        elseif (S(i) == '9')
            huff(i) = '1111111110110100';
        elseif (S(i) == 'A')
            huff(i) = '1111111110110101';
        end
    elseif (R(i) == '8')    
        if (S(i) == '1')
            huff(i) = '111111000';
        elseif (S(i) == '2')
            huff(i) = '111111111000000';
        elseif (S(i) == '3')
            huff(i) = '1111111110110110';
        elseif (S(i) == '4')
            huff(i) = '1111111110110111';
        elseif (S(i) == '5')
            huff(i) = '1111111110111000';
        elseif (S(i) == '6')
            huff(i) = '1111111110111001';
        elseif (S(i) == '7')
            huff(i) = '1111111110111010';
        elseif (S(i) == '8')
            huff(i) = '1111111110111011';
        elseif (S(i) == '9')
            huff(i) = '1111111110111100';
        elseif (S(i) == 'A')
            huff(i) = '1111111110111101';
        end
    elseif (R(i) == '9')
        if (S(i) == '1')
            huff(i) = '111111001';
        elseif (S(i) == '2')
            huff(i) = '1111111110111110';
        elseif (S(i) == '3')
            huff(i) = '1111111110111111';
        elseif (S(i) == '4')
            huff(i) = '1111111111000000';
        elseif (S(i) == '5')
            huff(i) = '1111111111000001';
        elseif (S(i) == '6')
            huff(i) = '1111111111000010';
        elseif (S(i) == '7')
            huff(i) = '1111111111000011';
        elseif (S(i) == '8')
            huff(i) = '1111111111000100';
        elseif (S(i) == '9')
            huff(i) = '1111111111000101';
        elseif (S(i) == 'A')
            huff(i) = '1111111111000110';
        end
    elseif (R(i) == 'A')    
        if (S(i) == '1')
            huff(i) = '111111010';
        elseif (S(i) == '2')
            huff(i) = '1111111111000111';
        elseif (S(i) == '3')
            huff(i) = '1111111111001000';
        elseif (S(i) == '4')
            huff(i) = '1111111111001001';
        elseif (S(i) == '5')
            huff(i) = '1111111111001010';
        elseif (S(i) == '6')
            huff(i) = '1111111111001011';
        elseif (S(i) == '7')
            huff(i) = '1111111111001100';
        elseif (S(i) == '8')
            huff(i) = '1111111111001101';
        elseif (S(i) == '9')
            huff(i) = '1111111111001110';
        elseif (S(i) == 'A')
            huff(i) = '1111111111001111';
        end
    elseif (R(i) == 'B')    
        if (S(i) == '1')
            huff(i) = '1111111001';
        elseif (S(i) == '2')
            huff(i) = '1111111111010000';
        elseif (S(i) == '3')
            huff(i) = '1111111111010001';
        elseif (S(i) == '4')
            huff(i) = '1111111111010010';
        elseif (S(i) == '5')
            huff(i) = '1111111111010011';
        elseif (S(i) == '6')
            huff(i) = '1111111111010100';
        elseif (S(i) == '7')
            huff(i) = '1111111111010101';
        elseif (S(i) == '8')
            huff(i) = '1111111111010110';
        elseif (S(i) == '9')
            huff(i) = '1111111111010111';
        elseif (S(i) == 'A')
            huff(i) = '1111111111011000';
        end
    elseif (R(i) == 'C')    
        if (S(i) == '1')
            huff(i) = '1111111010';
        elseif (S(i) == '2')
            huff(i) = '1111111111011001';
        elseif (S(i) == '3')
            huff(i) = '1111111111011010';
        elseif (S(i) == '4')
            huff(i) = '1111111111011011';
        elseif (S(i) == '5')
            huff(i) = '1111111111011100';
        elseif (S(i) == '6')
            huff(i) = '1111111111011101';
        elseif (S(i) == '7')
            huff(i) = '1111111111011110';
        elseif (S(i) == '8')
            huff(i) = '1111111111011111';
        elseif (S(i) == '9')
            huff(i) = '1111111111100000';
        elseif (S(i) == 'A')
            huff(i) = '1111111111100001';
        end
    elseif(R(i) == 'D')
        if (S(i) == '1')
            huff(i) = '11111111000';
        elseif (S(i) == '2')
            huff(i) = '1111111111100010';
        elseif (S(i) == '3')
            huff(i) = '1111111111100011';
        elseif (S(i) == '4')
            huff(i) = '1111111111100100';
        elseif (S(i) == '5')
            huff(i) = '1111111111100101';
        elseif (S(i) == '6')
            huff(i) = '1111111111100110';
        elseif (S(i) == '7')
            huff(i) = '1111111111100111';
        elseif (S(i) == '8')
            huff(i) = '1111111111101000';
        elseif (S(i) == '9')
            huff(i) = '1111111111101001';
        elseif (S(i) == 'A')
            huff(i) = '1111111111101010';
        end
    elseif(R(i) == 'E')
        if (S(i) == '1')
            huff(i) = '1111111111101011';
        elseif (S(i) == '2')
            huff(i) = '1111111111101100';
        elseif (S(i) == '3')
            huff(i) = '1111111111101101';
        elseif (S(i) == '4')
            huff(i) = '1111111111101110';
        elseif (S(i) == '5')
            huff(i) = '1111111111101111';
        elseif (S(i) == '6')
            huff(i) = '1111111111110000';
        elseif (S(i) == '7')
            huff(i) = '1111111111110001';
        elseif (S(i) == '8')
            huff(i) = '1111111111110010';
        elseif (S(i) == '9')
            huff(i) = '1111111111110011';
        elseif (S(i) == 'A')
            huff(i) = '1111111111110100';
        end
    elseif (R(i) == 'F')
        if (S(i) == '0')
            huff(i) = '11111111001';
        elseif (S(i) == '1')
            huff(i) = '1111111111110101';
        elseif (S(i) == '2')
            huff(i) = '1111111111110110';
        elseif (S(i) == '3')
            huff(i) = '1111111111110111';  
        elseif (S(i) == '4')
            huff(i) = '1111111111111000';
        elseif (S(i) == '5')
            huff(i) = '1111111111111001';
        elseif (S(i) == '6')
            huff(i) = '1111111111111010';
        elseif (S(i) == '7')
            huff(i) = '1111111111111011';
        elseif (S(i) == '8')
            huff(i) = '1111111111111100';
        elseif (S(i) == '9')
            huff(i) = '1111111111111101';
        elseif (S(i) == 'A')
            huff(i) = '1111111111111110';
        end
    end
    category = findCategory(NZ(i));

    if (NZ(i) > 0)
        range(i) = dec2bin(NZ(i), category);
    elseif (NZ(i) == 0)
        range(i) = dec2bin(NZ(i));
    elseif (NZ(i) < 0)
        absValue = dec2bin(abs(NZ(i)), category);
        oneComplement = not(absValue - '0');
        range(i) = char(oneComplement + '0');
    end

    h(i) = strcat(huff(i), " ", range(i));
end
huffEncoded = h;

%We compute the number of bits used after the encoding procedure in order
%to output the compression ratio
bits = 0;
for i = 1:1:dim
    imageCompressedBitstream = convertStringsToChars(h(i));
    imageCompressedBits = numel(imageCompressedBitstream) - 1;
    bits = bits + imageCompressedBits;
end
end