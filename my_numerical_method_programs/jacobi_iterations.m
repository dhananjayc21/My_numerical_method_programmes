function result = gauss_sdl(A, B)
    % This function takes two matrices A and B as input and returns their sum.
    
    n = size(A, 1); % Returns the number of rows
    phi_old = zeros(n,1);
    phi_new = zeros(n,1);
    for i = 1:n
        phi_old(i,1) = B(i,1)/A(i,i); % Initial guess
        phi_new(i,1) = B(i,1)/A(i,i); % Initial guess
    end
    error = 100;
    iterations_sdl = 0;

     while error > 0.01 
       error = 0;  
       iterations_sdl = iterations_sdl + 1;
       for i = 1:n
            sum = 0;
            for j = 1:(i-1)
                sum = sum + A(i,j) * phi_new(j,1); % phi_old replaced by phi_new
            end
            for j = (i+1):n
                sum = sum + A(i,j) * phi_old(j,1);
            end
            phi_new(i,1) = ((B(i,1) - sum) / A(i,i));
       end
       for i = 1:n
           error = error +  abs(phi_new(i,1) - phi_old(i,1));
       end
    
       phi_old = phi_new;
     end

     display(iterations_sdl);
     result = phi_new;

end
function result = jacobi(A, B)
    % This function takes two matrices A and B as input and returns their sum.
    
    n = size(A, 1); % Returns the number of rows
    phi_old = zeros(n,1);
    phi_new = zeros(n,1);
    for i = 1:n
        phi_old(i,1) = B(i,1)/A(i,i); % Initial guess
        phi_new(i,1) = B(i,1)/A(i,i); % Initial guess
    end
    error = 100;
    iterations_jacobi = 0;

     while error > 0.01 
       error = 0;  
       iterations_jacobi = iterations_jacobi + 1;
       for i = 1:n
            sum = 0;
            for j = 1:(i-1)
                sum = sum + A(i,j) * phi_old(j,1);
            end
            for j = (i+1):n
                sum = sum + A(i,j) * phi_old(j,1);
            end
            phi_new(i,1) = ((B(i,1) - sum) / A(i,i));
       end
       for i = 1:n
           error = error +  abs(phi_new(i,1) - phi_old(i,1));
       end
    
       phi_old = phi_new;
     end

     display(iterations_jacobi);
     result = phi_new;
     
end
function result = sor(A, B)
    % This function takes two matrices A and B as input and returns their sum.
    
    n = size(A, 1); % Returns the number of rows
    phi_old = zeros(n,1);
    phi_new = zeros(n,1);
    for i = 1:n
        phi_old(i,1) = B(i,1)/A(i,i); % Initial guess
        phi_new(i,1) = B(i,1)/A(i,i); % Initial guess
    end
    error = 100;
    iterations_sor = 0;
    alpha_sor = 0.5; % It is generally kept between 1 and 2.

     while error > 0.01 
       error = 0;  
       iterations_sor = iterations_sor + 1;
       for i = 1:n
            sum = 0;
            for j = 1:(i-1)
                sum = sum + A(i,j) * phi_old(j,1);
            end
            for j = (i+1):n
                sum = sum + A(i,j) * phi_old(j,1);
            end

            phi_new(i,1) = alpha_sor * ((B(i,1) - sum) / A(i,i)) + (1 - alpha_sor) * phi_old(i,1); % SUCCESSIVE OVERELAXATION STEP

       end
       for i = 1:n
           error = error +  abs(phi_new(i,1) - phi_old(i,1));
       end
    
       phi_old = phi_new;
     end

     display(iterations_sor);
     result = phi_new;
     
end


A_matrix = [1 0 0 0 0;1 -2 1 0 0;0 1 -2 1 0;0 0 1 -2 1; 0 0 0 0 1];
B_matrix = [1;0;0;0;0;0];

X_jacobi = jacobi(A_matrix,B_matrix);
X_sdl = gauss_sdl(A_matrix,B_matrix);
X_sor = sor(A_matrix,B_matrix);


display(X_jacobi);
display(X_sdl);
display(X_sor);


