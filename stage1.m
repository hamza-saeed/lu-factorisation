function [x] =stage1(L,b)

%Get the number of rows and number of columns of matrix
[rowSizeL, columnSizeL] = size(L);

%Get size of right hand size vector
[rowSizeB, columnSizeB] = size(b);

%throw error if column/row size less than two
if ((rowSizeL < 2) || (columnSizeL < 2))
    error('Matrix (L) must have at least 2 columns and 2 rows')
end

%if number of rows and columns is not the same, throw error
if (rowSizeL ~= columnSizeL)
    error('Matrix (L) must be a square matrix!');
end

%if matrix is not a lower triangular matrix, throw error
if (istril(L) == 0)
    error('Matrix (L) must be lower triangular!');
end

%throw error if matrix is not a unit lower triangular (all diagonals are 1)
for i=1:rowSizeL
    for j=1:columnSizeL
        if (i==j)
            if (L(i,j) ~= 1)
                error("Matrix (L) must be lower unit triangular (all diagonals must be 1)");
            end
        end
    end
end

%throw error if RHS vector has more rows than L
if (rowSizeB ~= rowSizeL)
    error('RHS vector (b) must have same number of rows as matrix (L)');
end

%throw error if RHS vector is more than one column
if (columnSizeB ~=1)
    error('RHS vector (b) must have one column');
end

%throw error if RHS vector is a zero vector
if (isequal(b,zeros(rowSizeL,1)))
   error('RHS vector (b) must not be a zero vector'); 
end

%initialising size for x
x=zeros(rowSizeL,1);

for i=1:rowSizeL
    if (i==1)
        %always the case for x(1,1) because L is lower triangular (others in row are 0)
        x(1,1) = b(1)/L(1,1);
    else
        %performs forward substitution for x(2,1)-x(n,1)
        x(i,1) = (b(i) - L(i,1:i-1) * x(1:i-1,1)) / L(i,i);
    end
end
end



