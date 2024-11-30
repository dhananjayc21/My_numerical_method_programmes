% Case --->  d2T/dX2 = 0

% Control Parameters

T_h = 1;
T_c = 0;
n = 5;

% Lets take n nodal points including the T_h and T_c point.

A_matrix = zeros(n,n);
A_matrix(1,1) = 1;
A_matrix(n,n) = 1;

for i = 2:n-1
    for j = 1:n

        if i==j
            A_matrix(i,j) = -2;
        elseif (i-j) == 1
            A_matrix(i,j) = 1;
        elseif (i-j) == -1
            A_matrix(i,j) = 1;  
        end

    end
end

% CREATING THE MATRIX B

B_matrix = zeros(n,1);
B_matrix(1,1) = T_h;
B_matrix(n,1) = T_c;

% Solution matrix --> X_matrix

X_matrix = A_matrix \ B_matrix;

X_matrix

