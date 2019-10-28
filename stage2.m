function [x] =stage2(U,b)

%Get the number of rows and number of columns of matrix
[rowSizeU, columnSizeU] = size(U);

%Get size of right hand size vector
[rowSizeB, columnSizeB] = size(b);

%throw error if column/row size less than two
if ((rowSizeU < 2) || (columnSizeU < 2))
    error('Matrix (U) must have at least 2 columns and 2 rows')
end

%if row and column count not the same, throw error
if (rowSizeU ~= columnSizeU)
    error('Matrix (U) must be a square matrix!');
end

%if matrix is now a upper triangular matrix, throw error
if (istriu(U) == 0)
    error('Matrix (U) must be upper triangular!');
end

%throw error if RHS vector has more rows than U
if (rowSizeB ~= rowSizeU)
    error('RHS vector (b) must have same number of rows as matrix (L)');
end

%throw error if RHS vector is more than one column
if (columnSizeB ~=1)
    error('RHS vector (b) must have only one column');
end

%throw error if RHS vector is a zero vector
if (isequal(b,zeros(rowSizeB,1)))
   error('RHS vector (b) must not be a zero vector'); 
end

%initialising size for x
x=zeros(rowSizeU,1);

for i=rowSizeU:-1:1
    if (i==rowSizeU)
        %always the case for x(1,1) because U is upper triangular (others in row are 0)
        x(rowSizeU,1) = b(rowSizeU) / U(rowSizeU,rowSizeU);
    else
        x(i,1) = (b(i) - U(i,i+1:rowSizeU) * x(i+1:rowSizeU,1)) / U(i,i);
    end
end
end

