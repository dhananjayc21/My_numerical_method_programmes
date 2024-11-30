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



dx = 0.25;
matrix_A = [1 0 0 0 0; 1 -(2 + 2 * (dx)^2) 1 0 0;0 1 -(2 + 2 * (dx)^2) 1 0;0 0 1 -(2 + 2 * (dx)^2) 1;0 0 0 0 1];
matrix_B = [1; 0; 0; 0; 0];

n = size(matrix_A, 1);
result = gauss_elimination_inv(matrix_A,matrix_B);
matrix_C = zeros(n,n);
if matrix_C == result
    disp('Your matrix is non-invertible.');
end    
display(result);