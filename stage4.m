function [x] = stage4(A, b)

%Inputs do not need to be validated here since they are validated in the
%functions they are used in.

%LU factorisation to get L & U from A
[L,U] = stage3(A);

%calculate determinant of L and U
detL = prod(diag(L));
detU = prod(diag(U));

%Throw error if solution does not exist (0 determinant).
if ((detL * detU)==0)
   error('No solution exists. Determinant is 0'); 
end

%stage1 performs forward substitution to get y
y = stage1(L,b);

%stage2 performs backwards substitution to get x
x = stage2(U,y);

end