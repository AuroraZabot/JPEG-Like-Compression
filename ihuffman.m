function invHuffman = ihuffman(encodedFunc) 
%Here we just need to match the provided Huffman code to the associated
%runlength, category and range
dim = size(encodedFunc, 1);
R = zeros(1, dim);
S = zeros(1, dim);
NZ = zeros(1, dim);
[RL, value] = strtok(encodedFunc, " ");
value = strip(value, 'left', " ");
for i = 1:1:dim
    if (RL(i) == "1010")
        R(i) = 0;
        S(i) = 0;
    elseif (RL(i) == "00")
        R(i) = 0;
        S(i) = 1;
    elseif (RL(i) == "01")
        R(i) = 0;
        S(i) = 2;
    elseif (RL(i) == "100")
        R(i) = 0;
        S(i) = 3;
    elseif (RL(i) == "1011")
        R(i) = 0;
        S(i) = 4;
    elseif (RL(i) == "11010")
        R(i) = 0;
        S(i) = 5;
    elseif (RL(i) == "1111000")
        R(i) = 0;
        S(i) = 6;
    elseif (RL(i) == "11111000")
        R(i) = 0;
        S(i) = 7;
    elseif (RL(i) == "1111110110")
        R(i) = 0;
        S(i) = 8;
    elseif (RL(i) == "1111111110000010")
        R(i) = 0;
        S(i) = 9;
    elseif (RL(i) == "1111111110000011")
        R(i) = 0;
        S(i) = 10;
    elseif (RL(i) == "1100")
        R(i) = 1;
        S(i) = 1;
    elseif (RL(i) == "11011")
        R(i) = 1;
        S(i) = 2;
    elseif (RL(i) == "1111001")
        R(i) = 1;
        S(i) = 3;
    elseif (RL(i) == "111110110")
        R(i) = 1;
        S(i) = 4;
    elseif (RL(i) == "11111110110")
        R(i) = 1;
        S(i) = 5;
    elseif (RL(i) == "1111111110000100")
        R(i) = 1;
        S(i) = 6;
    elseif (RL(i) == "1111111110000101")
        R(i) = 1;
        S(i) = 7;
    elseif (RL(i) == "1111111110000110")
        R(i) = 1;
        S(i) = 8;
    elseif (RL(i) == "1111111110000111")
        R(i) = 1;
        S(i) = 9;
    elseif (RL(i) == "1111111110001000")
        R(i) = 1;
        S(i) = 10;
    elseif (RL(i) == "11100")
        R(i) = 2;
        S(i) = 1;
    elseif (RL(i) == "11111001")
        R(i) = 2;
        S(i) = 2;
    elseif (RL(i) == "1111110111")
        R(i) = 2;
        S(i) = 3;
    elseif (RL(i) == "111111110100")
        R(i) = 2;
        S(i) = 4;
    elseif (RL(i) == "1111111110001001")
        R(i) = 2;
        S(i) = 5;
    elseif (RL(i) == "1111111110001010")
        R(i) = 2;
        S(i) = 6;
    elseif (RL(i) == "1111111110001011")
        R(i) = 2;
        S(i) = 7;
    elseif (RL(i) == "1111111110001100")
        R(i) = 2;
        S(i) = 8;
    elseif (RL(i) == "1111111110001101")
        R(i) = 2;
        S(i) = 9;
    elseif (RL(i) == "1111111110001110")
        R(i) = 2;
        S(i) = 10;
    elseif (RL(i) == "111010")
        R(i) = 3;
        S(i) = 1;
    elseif (RL(i) == "111110111")
        R(i) = 3;
        S(i) = 2;
    elseif (RL(i) == "111111110101")
        R(i) = 3;
        S(i) = 3;
    elseif (RL(i) == "1111111110001111")
        R(i) = 3;
        S(i) = 4;
    elseif (RL(i) == "1111111110010000")
        R(i) = 3;
        S(i) = 5;
    elseif (RL(i) == "1111111110010001")
        R(i) = 3;
        S(i) = 6;
    elseif (RL(i) == "1111111110010010")
        R(i) = 3;
        S(i) = 7;
    elseif (RL(i) == "1111111110010011")
        R(i) = 3;
        S(i) = 8;
    elseif (RL(i) == "1111111110010100")
        R(i) = 3;
        S(i) = 9;
    elseif (RL(i) == "1111111110010101")
        R(i) = 3;
        S(i) = 10;
    elseif (RL(i) == "111011")
        R(i) = 4;
        S(i) = 1;
    elseif (RL(i) == "1111111000")
        R(i) = 4;
        S(i) = 2;
    elseif (RL(i) == "1111111110010110")
        R(i) = 4;
        S(i) = 3;
    elseif (RL(i) == "1111111110010111")
        R(i) = 4;
        S(i) = 4;
    elseif (RL(i) == "1111111110011000")
        R(i) = 4;
        S(i) = 5;
    elseif (RL(i) == "1111111110011001")
        R(i) = 4;
        S(i) = 6;
    elseif (RL(i) == "1111111110011010")
        R(i) = 4;
        S(i) = 7;
    elseif (RL(i) == "1111111110011011")
        R(i) = 4;
        S(i) = 8;
    elseif (RL(i) == "1111111110011100")
        R(i) = 4;
        S(i) = 9;
    elseif (RL(i) == "1111111110011101")
        R(i) = 4;
        S(i) = 10;
    elseif (RL(i) == "1111010")
        R(i) = 5;
        S(i) = 1;
    elseif (RL(i) == "11111110111 ")
        R(i) = 5;
        S(i) = 2;
    elseif (RL(i) == "1111111110011110")
        R(i) = 5;
        S(i) = 3;
    elseif (RL(i) == "1111111110011111")
        R(i) = 5;
        S(i) = 4;
    elseif (RL(i) == "1111111110100000")
        R(i) = 5;
        S(i) = 5;
    elseif (RL(i) == "1111111110100001")
        R(i) = 5;
        S(i) = 6;
    elseif (RL(i) == "1111111110100010")
        R(i) = 5;
        S(i) = 7;
    elseif (RL(i) == "1111111110100011")
        R(i) = 5;
        S(i) = 8;
    elseif (RL(i) == "1111111110100100")
        R(i) = 5;
        S(i) = 9;
    elseif (RL(i) == "1111111110100101")
        R(i) = 5;
        S(i) = 10;
    elseif (RL(i) == "1111011")
        R(i) = 6;
        S(i) = 1;
    elseif (RL(i) == "111111110110")
        R(i) = 6;
        S(i) = 2;
    elseif (RL(i) == "1111111110100110")
        R(i) = 6;
        S(i) = 3;
    elseif (RL(i) == "1111111110100111")
        R(i) = 6;
        S(i) = 4;
    elseif (RL(i) == "1111111110101000")
        R(i) = 6;
        S(i) = 5;
    elseif (RL(i) == "1111111110101001")
        R(i) = 6;
        S(i) = 6;
    elseif (RL(i) == "1111111110101010")
        R(i) = 6;
        S(i) = 7;
    elseif (RL(i) == "1111111110101011")
        R(i) = 6;
        S(i) = 8;
    elseif (RL(i) == "1111111110101100")
        R(i) = 6;
        S(i) = 9;
    elseif (RL(i) == "1111111110101101")
        R(i) = 6;
        S(i) = 10;
    elseif (RL(i) == "11111010")
        R(i) = 7;
        S(i) = 1;
    elseif (RL(i) == "111111110111")
        R(i) = 7;
        S(i) = 2;
    elseif (RL(i) == "1111111110101110")
        R(i) = 7;
        S(i) = 3;
    elseif (RL(i) == "1111111110101111")
        R(i) = 7;
        S(i) = 4;
    elseif (RL(i) == "1111111110110000")
        R(i) = 7;
        S(i) = 5;
    elseif (RL(i) == "1111111110110001")
        R(i) = 7;
        S(i) = 6;
    elseif (RL(i) == "1111111110110010")
        R(i) = 7;
        S(i) = 7;
    elseif (RL(i) == "1111111110110011")
        R(i) = 7;
        S(i) = 8;
    elseif (RL(i) == "1111111110110100")
        R(i) = 7;
        S(i) = 9;
    elseif (RL(i) == "1111111110110101")
        R(i) = 7;
        S(i) = 10;
    elseif (RL(i) == "111111000")
        R(i) = 8;
        S(i) = 1;
    elseif (RL(i) == "111111111000000")
        R(i) = 8;
        S(i) = 2;
    elseif (RL(i) == "1111111110110110")
        R(i) = 8;
        S(i) = 3;
    elseif (RL(i) == "1111111110110111")
        R(i) = 8;
        S(i) = 4;
    elseif (RL(i) == "1111111110111000")
        R(i) = 8;
        S(i) = 5;
    elseif (RL(i) == "1111111110111001")
        R(i) = 8;
        S(i) = 6;
    elseif (RL(i) == "1111111110111010")
        R(i) = 8;
        S(i) = 7;
    elseif (RL(i) == "1111111110111011")
        R(i) = 8;
        S(i) = 8;
    elseif (RL(i) == "1111111110111100")
        R(i) = 8;
        S(i) = 9;
    elseif (RL(i) == "1111111110111101")
        R(i) = 8;
        S(i) = 10;
    elseif (RL(i) == "111111001")
        R(i) = 9;
        S(i) = 1;
    elseif (RL(i) == "1111111110111110")
        R(i) = 9;
        S(i) = 2;
    elseif (RL(i) == "1111111110111111")
        R(i) = 9;
        S(i) = 3;
    elseif (RL(i) == "1111111111000000")
        R(i) = 9;
        S(i) = 4;
    elseif (RL(i) == "1111111111000001")
        R(i) = 9;
        S(i) = 5;
    elseif (RL(i) == "1111111111000010")
        R(i) = 9;
        S(i) = 6;
    elseif (RL(i) == "1111111111000011")
        R(i) = 9;
        S(i) = 7;
    elseif (RL(i) == "1111111111000100")
        R(i) = 9;
        S(i) = 8;
    elseif (RL(i) == "1111111111000101")
        R(i) = 9;
        S(i) = 9;
    elseif (RL(i) == "1111111111000110")
        R(i) = 9;
        S(i) = 10;
    elseif (RL(i) == "111111010")
        R(i) = 10;
        S(i) = 1;
    elseif (RL(i) == "1111111111000111")
        R(i) = 10;
        S(i) = 2;
    elseif (RL(i) == "1111111111001000")
        R(i) = 10;
        S(i) = 3;
    elseif (RL(i) == "1111111111001001")
        R(i) = 10;
        S(i) = 4;
    elseif (RL(i) == "1111111111001010")
        R(i) = 10;
        S(i) = 5;
    elseif (RL(i) == "1111111111001011")
        R(i) = 10;
        S(i) = 6;
    elseif (RL(i) == "1111111111001100")
        R(i) = 10;
        S(i) = 7;
    elseif (RL(i) == "1111111111001101")
        R(i) = 10;
        S(i) = 8;
    elseif (RL(i) == "1111111111001110")
        R(i) = 10;
        S(i) = 9;
    elseif (RL(i) == "1111111111001111")
        R(i) = 10;
        S(i) = 10;
    elseif (RL(i) == "1111111001")
        R(i) = 11;
        S(i) = 1;
    elseif (RL(i) == "1111111111010000")
        R(i) = 11;
        S(i) = 2;
    elseif (RL(i) == "1111111111010001")
        R(i) = 11;
        S(i) = 3;
    elseif (RL(i) == "1111111111010010")
        R(i) = 11;
        S(i) = 4;
    elseif (RL(i) == "1111111111010011")
        R(i) = 11;
        S(i) = 5;
    elseif (RL(i) == "1111111111010100")
        R(i) = 11;
        S(i) = 6;
    elseif (RL(i) == "1111111111010101")
        R(i) = 11;
        S(i) = 7;
    elseif (RL(i) == "1111111111010110")
        R(i) = 11;
        S(i) = 8;
    elseif (RL(i) == "1111111111010111")
        R(i) = 11;
        S(i) = 9;
    elseif (RL(i) == "1111111111011000")
        R(i) = 11;
        S(i) = 10;
    elseif (RL(i) == "1111111010")
        R(i) = 12;
        S(i) = 1;
    elseif (RL(i) == "1111111111011001")
        R(i) = 12;
        S(i) = 2;
    elseif (RL(i) == "1111111111011010")
        R(i) = 12;
        S(i) = 3;
    elseif (RL(i) == "1111111111011011")
        R(i) = 12;
        S(i) = 4;
    elseif (RL(i) == "1111111111011100")
        R(i) = 12;
        S(i) = 5;
    elseif (RL(i) == "1111111111011101")
        R(i) = 12;
        S(i) = 6;
    elseif (RL(i) == "1111111111011110")
        R(i) = 12;
        S(i) = 7;
    elseif (RL(i) == "1111111111011111")
        R(i) = 12;
        S(i) = 8;
    elseif (RL(i) == "1111111111100000")
        R(i) = 12;
        S(i) = 9;
    elseif (RL(i) == "1111111111100001")
        R(i) = 12;
        S(i) = 10;
    elseif (RL(i) == "11111111000")
        R(i) = 13;
        S(i) = 1;
    elseif (RL(i) == "1111111111100010")
        R(i) = 13;
        S(i) = 2;
    elseif (RL(i) == "1111111111100011")
        R(i) = 13;
        S(i) = 3;
    elseif (RL(i) == "1111111111100100")
        R(i) = 13;
        S(i) = 4;
    elseif (RL(i) == "1111111111100101")
        R(i) = 13;
        S(i) = 5;
    elseif (RL(i) == "1111111111100110")
        R(i) = 13;
        S(i) = 6;
    elseif (RL(i) == "1111111111100111")
        R(i) = 13;
        S(i) = 7;
    elseif (RL(i) == "1111111111101000")
        R(i) = 13;
        S(i) = 8;
    elseif (RL(i) == "1111111111101001")
        R(i) = 13;
        S(i) = 9;
    elseif (RL(i) == "1111111111101010")
        R(i) = 13;
        S(i) = 10;
    elseif (RL(i) == "1111111111101011")
        R(i) = 14;
        S(i) = 1;
    elseif (RL(i) == "1111111111101100")
        R(i) = 14;
        S(i) = 2;
    elseif (RL(i) == "1111111111101101")
        R(i) = 14;
        S(i) = 3;
    elseif (RL(i) == "1111111111101110")
        R(i) = 14;
        S(i) = 4;
    elseif (RL(i) == "1111111111101111")
        R(i) = 14;
        S(i) = 5;
    elseif (RL(i) == "1111111111110000")
        R(i) = 14;
        S(i) = 6;
    elseif (RL(i) == "1111111111110001")
        R(i) = 14;
        S(i) = 7;
    elseif (RL(i) == "1111111111110010")
        R(i) = 14;
        S(i) = 8;
    elseif (RL(i) == "1111111111110011")
        R(i) = 14;
        S(i) = 9;
    elseif (RL(i) == "1111111111110100")
        R(i) = 14;
        S(i) = 10;
    elseif (RL(i) == "1111111111110101")
        R(i) = 15;
        S(i) = 1;
    elseif (RL(i) == "1111111111110110")
        R(i) = 15;
        S(i) = 2;
    elseif (RL(i) == "1111111111110111")
        R(i) = 15;
        S(i) = 3;
    elseif (RL(i) == "1111111111111000")
        R(i) = 15;
        S(i) = 4;
    elseif (RL(i) == "1111111111111001")
        R(i) = 15;
        S(i) = 5;
    elseif (RL(i) == "1111111111111010")
        R(i) = 15;
        S(i) = 6;
    elseif (RL(i) == "1111111111111011")
        R(i) = 15;
        S(i) = 7;
    elseif (RL(i) == "1111111111111100")
        R(i) = 15;
        S(i) = 8;
    elseif (RL(i) == "1111111111111101")
        R(i) = 15;
        S(i) = 9;
    elseif (RL(i) == "1111111111111110")
        R(i) = 15;
        S(i) = 10;  
    elseif (RL(i) == "11111111001")
        R(i) = 15;
        S(i) = 0;
    end
end

for i = 1:1:dim-1
    sign = convertStringsToChars(value(i));
    dim = size(sign, 2);
    if (sign(1) == '0' && dim ~= 1)
        oneComplement = not(sign - '0');
        NZ(i) = -bin2dec(char(oneComplement + '0'));
    elseif (sign(1) == '0' && dim == 1)
        NZ(i) = 0;
    elseif (sign(1) == '1')
        NZ(i) = bin2dec(char(value(i)));
    end
end
invHuffman = decode(R, S, NZ);
end