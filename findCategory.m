function category = findCategory(value)
% In this portion we just create a matching table to find categories
% associated to each input value (= range); we just stopped at the 10-th
% category
if (abs(value) > 1023)
    error("Category not found");
end
if (abs(value) == 0)
    category = 0;
elseif (abs(value) == 1)
    category = 1;
elseif (abs(value) == 2 || abs(value) == 3)
    category = 2;
elseif (4 <= abs(value) && abs(value) <= 7)
    category = 3;
elseif (8 <= abs(value) && abs(value) <= 15)
    category = 4;
elseif (16 <= abs(value) && abs(value) <= 31)
 category = 5;
elseif (32 <= abs(value) && abs(value) <= 63)
    category = 6;
elseif (64 <= abs(value) && abs(value) <= 127)
    category = 7;
elseif (128 <= abs(value) && abs(value) <= 255)
    category = 8;
elseif (256 <= abs(value) && abs(value) <= 511)
    category = 9;
elseif (512 <= abs(value) && abs(value) <= 1023)
    category = 10;
end
end
