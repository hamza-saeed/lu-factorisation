function[L, U] = stage3(A)

%Get the number of rows and number of columns
[rowSizeA, columnSizeA] = size(A);

%throw error if column/row size is less than two
if ((rowSizeA < 2) || (columnSizeA < 2))
    error('Matrix (A) must have at least 2 columns and 2 rows')
end

%if row and column count not the same, display error
if (rowSizeA ~= columnSizeA)
    error('Matrix (A) must be a square matrix!')
end

%display error if A is a zero matrix
if (isequal(A,zeros(rowSizeA,columnSizeA)))
    error('Matrix (A) must not be a zero matrix');
end

%if rank is not equal to number of rows or columns, throw error
%if ((rank(A) ~= rowSizeA) && (rank(A) ~=columnSizeA))
%   error('Matrix (A) should be full rank.')
%end

if ((istriu(A) ~= 0)|| (istril(A) ~= 0))
    error('Matrix (A) must not be an upper triangular or lower triangular matrix')
end

%initialise L to an identity matrix (diagonals are 1s) 
L=eye(rowSizeA,columnSizeA);
%initialise size for U
U=zeros(rowSizeA,columnSizeA);

%loop to factorise A into L and U. This implements a row and column-wise
%approach. First, any unknowns in the first column of U will be solved.
%Then, unknowns in the 1st row of L will be solved, followed by the second
%column of U and so on...
for i=1:rowSizeA
    for j=1:columnSizeA
        %if statement so only unknowns are solved
        if (i<=j)
            %display("Setting U. Row " + i + " Column " +j)
            %Calculate the unknown value for U row i, column j
            U(i,j) = A(i,j) - L(i,1:(i-1))*U(1:(i-1),j);
            %throw error if any calculated value is NaN
            if (isnan(U(j,i)) == 1)
               error('NaN value. Matrix is not factorizable.') 
            end
        end
    end
    for j=1:columnSizeA
        %if statement so only unknowns are solved
        if (j>i)
            %display("Setting L. Row " + j + " Column " +i)
            %Calculate the unknown value for L row j, column i
            L(j,i) = (A(j,i) - L(j,1:(i-1))*U(1:(i-1),i)) / U(i,i);
            %throw error if any calculated value is NaN
            if (isnan(L(j,i)) == 1)
               error('NaN value/s. Matrix is not factorizable.') 
            end
        end
    end
end
end

