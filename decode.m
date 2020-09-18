function funcDecoded = decode(R, S, NZ)
% Here we just reunite the code (still in zigzag) using the informations
% provided by (R,S) and NZ; to compute the dimension, evaluate the
% dimension of the range vector and add the number of consecutive
% zeros (R(i) when R(i) ~= 0)
dim = size(R, 2);
dimZZ = size(NZ, 2) - 1;
for i = 1:1:dim
    if (R(i) ~= 0)
        dimZZ = dimZZ + R(i);
    end
end

dec = zeros(1, dimZZ - 1);
j = 1;
for i = 1:1:dim
    if (R(i) ~= 0)
        j = j + R(i);
        dec(j) = NZ(i);
        j = j + 1;
    elseif (R(i) == 0)
        dec(j) = NZ(i);
        j = j + 1;
    end
end
funcDecoded = invzigzag(dec);
end