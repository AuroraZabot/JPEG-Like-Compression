function encodedZigZag = zigzag(inputMatrix)
[numRows, numCols] = size(inputMatrix);

%We actually needen't this error control but we've used it in the testing
%part
if (numRows ~= numCols)
    error("The matrix must be square");
end

zigzagSize = numRows*numCols;
zigzagScan = zeros(1, zigzagSize);
zigzagScan(1) = inputMatrix(1);

curRow = 1; 
curCol = 2; 
i = 2;

%While we're not at the end of the matrix
while ((curRow <= numRows) && (curCol <= numCols))
    %For per upper triangle of the matrix
    %If we're in the first row in a even column position (the sum would be 
    %odd), we need to move in the bottom left position diagonally
    if (curRow == 1 && mod(curRow + curCol, 2) ~= 0 && curCol ~= numCols)
        zigzagScan(i) = inputMatrix(curRow, curCol);
        curRow = curRow + 1;
        curCol = curCol - 1;
        i = i + 1;
    %if we're in the first column in a even row position, we need to move
    %vertically of one step
    elseif (curCol == 1 && mod(curRow + curCol, 2) ~= 0 && curRow ~= numRows)
        zigzagScan(i) = inputMatrix(curRow, curCol);
        curRow = curRow + 1;
        i = i + 1;
    %if we're in the first column in a odd row position, we need to move
    %diagonally to the upper right side
    elseif (curCol == 1 && mod(curRow + curCol, 2) == 0 && curRow ~= numRows)
        zigzagScan(i) = inputMatrix(curRow, curCol);
        curRow = curRow - 1;
        curCol = curCol + 1;
        i = i + 1;
    %if we're inside the matrix and the sum is even, we need to
    %move to the upper right position diagonally until row 1
    elseif (curCol ~= 1 && curCol ~= numCols && curRow ~= 1 && curRow ~= numRows && mod(curRow + curCol, 2) == 0)
        zigzagScan(i) = inputMatrix(curRow, curCol);
        curRow = curRow - 1;
        curCol = curCol + 1;
        i = i + 1;
    %If we're in the first row in an odd column position, we need to shift to the
    %right of one step
    elseif (curRow == 1 && mod(curRow + curCol, 2) == 0 && curCol ~= numCols)
        zigzagScan(i) = inputMatrix(curRow, curCol);
        curCol = curCol + 1;
        i = i + 1;
    %if we're inside the matrix after an horizontal transition, we need to
    %move to the bottom left position diagonally until column 1
    elseif (curCol ~= 1 && curCol ~= numCols && curRow ~= 1 && curRow ~= numRows && mod(curRow + curCol, 2) ~= 0)
        zigzagScan(i) = inputMatrix(curRow, curCol);
        curRow = curRow + 1;
        curCol = curCol - 1;
        i = i + 1;
    %For the bottom triangle
    %If we're in the last row, if the sum is odd we need to shift on the
    %right side
    elseif (curRow == numRows && mod(curRow + curCol, 2) ~= 0)
        zigzagScan(i) = inputMatrix(curRow, curCol);
        curCol = curCol + 1;
        i = i + 1;
    %Otherwise, we need to translate diagonally to the upper right
    %direction
    elseif (curRow == numRows && mod(curRow + curCol, 2) == 0)
        zigzagScan(i) = inputMatrix(curRow, curCol);
        curCol = curCol + 1;
        curRow = curRow - 1;
        i = i + 1;
    %If we're in the last column and the sum is even, we need to translate
    %vertically
    elseif (curCol == numCols && mod(curRow + curCol, 2) == 0)
        zigzagScan(i) = inputMatrix(curRow, curCol);
        curRow = curRow + 1;
        i = i + 1;
    %Otherwise we need to shift diagonally to the bottom left direction
    elseif (curCol == numCols && mod(curRow + curCol, 2) ~= 0)
        zigzagScan(i) = inputMatrix(curRow, curCol);
        curRow = curRow + 1;
        curCol = curCol - 1;
        i = i + 1;
    %If we reach the end of block (EOB), stop the process
    elseif (curRow == numRows && curCol == numCols)
        zigzagScan(end) = matrixInput(numRows, numCols);
    end    
end

% We want to find the EOB in order to code it with a key value (1010),
% cutting off all the remaining zero elements; we save the index in the
% variable EOB
EOB = 1;
for i = zigzagSize:-1:1
    if (zigzagScan(i) ~= 0)
        EOB = i;
        break;
    end
end
zigzagScan = zigzagScan(1:EOB);

encodedZigZag = zigzagScan;
end