function decodedZigZag = invzigzag(inputVector)
%We just compute the inverse zigzag scan; of course the procedure is
%slightly similar to the zigzag one. In this first part we pad the array
%with zeros (considering that in the previous part we've cut this portion
%with the EOB); having an 8x8 matrix, we just pad the vector with (8x8 -
%the current dimension of the reconstructed vector).
prepad = size(inputVector, 2);
pad = 64 - prepad;
paddedVector = [inputVector zeros(1, pad)];
dim = size(paddedVector, 2);
numRows = 8;
numCols = 8;

invzigzagScan = zeros(numRows, numCols);
invzigzagScan(numRows, numCols) = paddedVector(dim);

curRow = numRows; 
curCol = numCols - 1; 
i = dim - 1;

%While we're not at the beginning of the vector
while ((curRow ~= 0) && (curCol ~= 0))
    %For the bottom triangle of the matrix:
    %Rows: in the even positions you must go horizontally left, 
    %in the odd position you must go diagonally right (up)
    %Cols: in the even position you must go diagonally left (down), while 
    %in the right one you must move up
    %Inside the matrix: in the even position you must go diagonally left 
    %(down), otherwise diagonally right (up)
    if (curRow == numRows && mod(curRow + curCol, 2) == 0 && curCol ~= 1)
        invzigzagScan(curRow, curCol) = paddedVector(i);
        curCol = curCol - 1;
        i = i - 1;
        
    elseif (curRow == numRows && mod(curRow + curCol, 2) ~= 0 && curCol ~= 1)
        invzigzagScan(curRow, curCol) = paddedVector(i);
        curRow = curRow - 1;
        curCol = curCol + 1;
        i = i - 1;
        
    elseif (curCol == numCols && mod(curRow + curCol, 2) ~= 0 && curRow ~= 1)
        invzigzagScan(curRow, curCol) = paddedVector(i);
        curRow = curRow - 1;
        i = i - 1;
        
    elseif (curCol == numCols && mod(curRow + curCol, 2) == 0 && curRow ~= 1)
        invzigzagScan(curRow, curCol) = paddedVector(i);
        curRow = curRow + 1;
        curCol = curCol - 1;
        i = i - 1;
    
    elseif (curCol ~= 1 && curCol ~= numCols && curRow ~= 1 && curRow ~= numRows && mod(curRow + curCol, 2) == 0)
        invzigzagScan(curRow, curCol) = paddedVector(i);
        curRow = curRow + 1;
        curCol = curCol - 1;
        i = i - 1;
        
    elseif (curCol ~= 1 && curCol ~= numCols && curRow ~= 1 && curRow ~= numRows && mod(curRow + curCol, 2) ~= 0)
        invzigzagScan(curRow, curCol) = paddedVector(i);
        curRow = curRow - 1;
        curCol = curCol + 1;
        i = i - 1;
        
    %In the upper triangle, instead:
    %Rows: in the odd one you must go left, whereas in the even one you
    %must go diagonally left (down)
    %Cols: in the even one you must move up, while in the odd one you must
    %go diagonally right (up)
    elseif (curCol == 1 && mod(curRow + curCol, 2) == 0)
        invzigzagScan(curRow, curCol) = paddedVector(i);
        curRow = curRow - 1;
        i = i - 1;
        
    elseif (curCol == 1 && mod(curRow + curCol, 2) ~= 0)
        invzigzagScan(curRow, curCol) = paddedVector(i);
        curRow = curRow - 1;
        curCol = curCol + 1;
        i = i - 1;
    
    elseif (curRow == 1 && mod(curRow + curCol, 2) ~= 0)
        invzigzagScan(curRow, curCol) = paddedVector(i);
        curCol = curCol - 1;
        i = i - 1;
        
    elseif (curRow == 1 && mod(curRow + curCol, 2) == 0)
        invzigzagScan(curRow, curCol) = paddedVector(i);
        curRow = curRow + 1;
        curCol = curCol - 1;
        i = i - 1;
        
    elseif (curRow == 1 && curCol == 1)
        invzigzagScan(1, 1) = paddedVector(1);
    end
end
decodedZigZag = invzigzagScan;
end