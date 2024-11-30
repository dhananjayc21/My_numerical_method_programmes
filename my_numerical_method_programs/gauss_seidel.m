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
    iterations = 0;

     while error > 0.01 
       error = 0;  
       iterations = iterations + 1;
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

     display(iterations);
     result = phi_new;
     
end


A_matrix = [4 1;1 4];
B_matrix = [5;5];

X_matrix = gauss_sdl(A_matrix,B_matrix);
display(X_matrix);


