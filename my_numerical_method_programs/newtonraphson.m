% % NEWTON-RAPHSON TO FIND ROOTS OF A EQUATION WITH SINGLE VARIABLE. 
% f = @(Q) (Q-2)^3;
% initialguess = 2; 
% q = initialguess;
% epsilon = 0.001;
% flag = 0;
% it = 0;
% 
% while flag == 0
% 
%     it = it + 1;
%     derivativeq = (f(q+epsilon)-f(q-epsilon))/(2 * epsilon);
%     if derivativeq == 0
%         flag = -1;
%         break;
%     end    
%     qcopy = q;
%     q = q - (f(q)/derivativeq);
%     if abs(q - qcopy) < 0.001
%         flag = 1;
% 
%     end
% end


% % NEWTON-RAPHSON TO FIND ROOTS OF A EQUATION WITH MANY VARIABLES.

n = 3; % ----> TOTAL NO. OF VARIABLES
initial_guess = [2,2,2]; % initial guess values
syms x [1 n]
f = sym(zeros(n, 1));
% Write the symbolic functions 
f(1,1) = x(1) - x(2) - x(3);
f(2,1) = x(3)^2 - 4 * x(2)^2; 
f(3,1) = 2 * x(1)^2 + x(3)^2 - 66; 
% f(7,1) = x1 - x2 - x3;


dev_f = sym(zeros(n, n));
for i = 1:n
    for j = 1:n
        dev_f(i,j) = simplify(diff(f(i,1),x(j))); 
    end
end


delta = zeros(n,1); % matrix containing the error for each variable.


ct = 0;
it = 0;

rmssquaresumdelta = 100 ;
rmssquaresumfunc = 100;

while rmssquaresumdelta > 0.00001
    
    it = it + 1;
    ct = 0;
    matrix_A = double(subs(dev_f, x, initial_guess));
    matrix_B = -1 * double(subs(f,x,initial_guess));
   
    delta = matrix_A \ matrix_B;
    squaresumdelta = 0;
    squaresumfunc = 0;
    for i = 1:n
        squaresumdelta = squaresumdelta + abs(delta(i,1)) ^ 2;
        squaresumfunc = squaresumfunc + abs(matrix_B(i,1)) ^ 2;
    end 
    rmssquaresumdelta = (squaresumdelta/n) ^ 0.5 ;
    rmssquaresumfunc = (squaresumfunc/n) ^ 0.5;

    for i = 1:n
        initial_guess(1,i) = initial_guess(1,i) + delta(i,1);
        delta_transpose = transpose(delta);
        % delta
    end   
     % initial_guess
     delta_transpose
end






