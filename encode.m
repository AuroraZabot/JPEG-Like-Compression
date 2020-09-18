function [R, S, NZ] = encode(zigzagvector)
tot = size(zigzagvector, 2);

%In this part we develop the runlength code; we also take into account
%the portion realated to the range element, mentioned in the report.
R = 0;
j = 1;
i = 1;
nonzero = zeros(1, tot);
category = zeros(1, tot);
runlength = zeros(1, tot);
while(i <= tot)
    if (zigzagvector(i) == 0)
        R = R + 1;
        i = i + 1;
        if (R == 15)
            runlength(j) = R;
            category(j) = 0;
            R = 0;
            j = j + 1;
            i = i + 1;
        end
    elseif (zigzagvector(i) ~= 0)
        S = findCategory(zigzagvector(i));
        category(j) = S;
        runlength(j) = R;
        nonzero(j) = zigzagvector(i);
        R = 0;
        j = j + 1;
        i = i + 1;
    elseif (i == tot)
        runlength(j) = 0;
        category(j) = 0;
    end    
end

%We cut off the portion of vector not in use looking at the range element
for i = tot:-1:1
    if (nonzero(i) == 0 && size(nonzero, 2) == 1)
        index = 1;
    elseif (nonzero(i) ~= 0)
        index = i;
        break;
    end
end

%In this way we obtain: R as the number of zeros in a run, S containing the
%category of each NZ element (= range)
if (nonzero(1) == 0 && size(nonzero, 2) == 1)
    R = runlength(1:index);
    S = category(1:index);
    NZ = nonzero(1:index);
else
    R = [runlength(1:index) zeros(1, 1)];
    S = [category(1:index) zeros(1, 1)];
    NZ = [nonzero(1:index) zeros(1, 1)];
end
end