% Parameters
a = 0;        
b = 3;       
N = 5;                
h = (b - a) / (N - 1);  

% Function definition
f = @(x) x .* exp(-x) ;

% Discretize the interval
x = linspace(a, b, N);   % N points from a to b
fx = f(x);               % Evaluate f(x) at all points

% Apply Simpson's 1/3 rule
I = (h / 3) * (fx(1) + 4 * sum(fx(2:2:end-1)) + 2 * sum(fx(3:2:end-2)) + fx(end));

% Display the result
fprintf('The integral using Simpson’s 1/3 Rule over [%f, %f] is: %.6f\n', a, b, I);


% Parameters
a = 0;        
b = 3;       
N = 20;                
h = (b - a) / (N - 1);

% Function definition
f = @(x) x .* exp(-x) ;

% Discretize the interval
x = linspace(a, b, N);   % N points from a to b
fx = f(x);               % Evaluate f(x) at all points

% Apply Trapezoidal Rule
I = (h / 2) * (fx(1) + 2 * sum(fx(2:end-1)) + fx(end));

% Display the result
fprintf('The integral using the Trapezoidal Rule over [%f, %f] is: %.6f\n', a, b, I);

