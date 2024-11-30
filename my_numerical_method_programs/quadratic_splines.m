function [result] = swaprow(A_matrix, i, j)
    % Store the i-th row temporarily
    temp_row = A_matrix(i, :); 
    
    % Swap the rows
    A_matrix(i, :) = A_matrix(j, :);
    A_matrix(j, :) = temp_row;
    
    % Return the modified matrix
    result = A_matrix;
end


function [result] = gauss_elimination_inv(A_matrix,B_matrix)

    n = size(A_matrix, 1);

    % Step - 1

    flagval2 = 0;    
    for i = 1 : n-1
        for j = i+1 : n

            % A_matrix
            if A_matrix(i,i) == 0
                flagval = 0;
                for l = i+1 : n
                    if A_matrix(l,i) ~= 0
                        A_matrix = swaprow(A_matrix,i,l);
                        B_matrix = swaprow(B_matrix,i,l);
                        flagval = 1;
                        break;
                    end    
                end
                if flagval == 0
                    flagval2 = 1;
                    break;
                end    
            end 
            if A_matrix(j,i) ~= 0
                val = A_matrix(j,i)/A_matrix(i,i);
                for k = i : n
                    A_matrix(j,k) = A_matrix(j,k) - val * A_matrix(i,k);
                end   
                B_matrix(j,1) = B_matrix(j,1) - val * B_matrix(i,1);
            end
        end 
        if flagval2 == 1
            break;
        end    
    end

    if flagval2 == 1
        result = zeros(n);
        return;
    end 


    % Step - 2 ----> Back Substitution
   
    ans_matrix = zeros(n,1);
    ans_matrix(n,1) = B_matrix(n)/A_matrix(n,n);
    for i = n-1 : -1 : 1
        sumval = 0;
        for j = n : -1 : i+1
            sumval = sumval + A_matrix(i,j) * ans_matrix(j);
        end
        ans_matrix(i) = (B_matrix(i) - sumval)/A_matrix(i,i);
    end    

    result = ans_matrix;
end


x_data_pts = [1, 1.5, 2.0, 2.5];
y_data_pts = [5, 9.75, 19, 34.25];
n = 4; % Number of points

% Create symbolic variables
syms x
syms a [1 n-1] 
syms b [1 n-1] 
syms c [1 n-1] % a1, a2, ..., an-1; b1, b2, ..., bn-1; c1, c2, ..., cn-1

B = zeros(3*n-4,1);

% Initialize symbolic functions
f = sym(zeros(1, n-1));
for i = 1:n-1
    if i == 1
        f(i) = b(i) * x + c(i); % First segment: linear
    else    
        f(i) = a(i) * x^2 + b(i) * x + c(i); % Other segments: quadratic
    end
end 

% Initialize g
g = sym(zeros(1, 3 * (n-1) - 1));
idx = 1;

% Step 1: Constraints for interior points
for i = 2:n-1
    g(idx) = subs(f(i-1), x, x_data_pts(i)) - y_data_pts(i); % Left side
    B(idx) = y_data_pts(i);
    idx = idx + 1;
    g(idx) = subs(f(i), x, x_data_pts(i)) - y_data_pts(i);   % Right side
    B(idx) = y_data_pts(i);
    idx = idx + 1;
end

% Step 2: Constraints for exterior points
g(idx) = subs(f(1), x, x_data_pts(1)) - y_data_pts(1);       % First point
B(idx) = y_data_pts(1);
idx = idx + 1;
g(idx) = subs(f(n-1), x, x_data_pts(n)) - y_data_pts(n);     % Last point
B(idx) = y_data_pts(n);
idx = idx + 1;

% Step 3: Derivatives at the interior points
f_diff = diff(f, x); % Derivative of f with respect to x
for i = 2:n-1
    g(idx) = subs(f_diff(i-1), x, x_data_pts(i)) - subs(f_diff(i), x, x_data_pts(i));
    B(idx) = 0;
    idx = idx + 1;
end

% Initialize Jacobian matrix h
h = sym(zeros(3 * (n-1)-1, 3 * (n-1)-1)); % Correct dimensions
m = 3 * (n-1)-1;

% Fill in the Jacobian matrix
for i = 1:m
    for j = 2:n-1
        h(i, j-1) = diff(g(i), a(j)); % Partial derivatives with respect to a
    end
    for j = 1:n-1
        h(i, n-2 + j) = diff(g(i), b(j)); % Partial derivatives with respect to b
    end
    for j = 1:n-1
        h(i, 2*(n-1)-1 + j) = diff(g(i), c(j)); % Partial derivatives with respect to c
    end
end

A = double(h);

C1 = A\B;
C2 = gauss_elimination_inv(A,B);
residual = 0;

    for j = 1 : 3 * n - 4
        residual = residual + abs(C1(j) - C2(j));
    end

if residual < 10 ^ -6
    disp('WELL DONE !! C1 AND C2 MATCH')
end
