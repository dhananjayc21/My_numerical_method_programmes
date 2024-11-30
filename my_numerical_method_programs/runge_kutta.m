% f = @(x,y) y; % Define the function
% ana_f = @(x) exp(x);
% 
% 
% h = 0.5;
% x_val = 0;
% y_val = 1;
% X = 2;
% n = X/h;
% x_array = zeros(1,n);
% y_array = zeros(1,n);
% x_array(1) = 0;
% y_array(1) = 1;
% 
% for i = 1:n
%     k1 = f(x_val,y_val);
%     k2 = f(x_val + h/2, y_val + (h/2)*k1);
%     k3 = f(x_val + h/2, y_val + (h/2)*k2);
%     k4 = f(x_val + h, y_val + h*k3);
%     y_val = y_val + h * (k1 + 2 * k2 + 2 * k3 + k4)/6;
%     x_val = x_val + h;
%     x_array(i+1) = x_val;
%     y_array(i+1) = y_val;
% end
% 
% val_ana = ana_f(X);


s = -2;
epsilon = 0.001;

h = 0.5;
X = 2;
n = X/h + 1;
x1_array = zeros(1,n+1);
Y1_array = zeros(1,n+1);
T1_array = zeros(1,n+1);
x1_array(1) = 0;
Y1_array(1) = s + epsilon;   % s -----> guess
T1_array(1) = 1;
x1_val = 0;
T1_val = 1;
Y1_val = s + epsilon; % s ----> guess

x2_array = zeros(1,n+1);
Y2_array = zeros(1,n+1);
T2_array = zeros(1,n+1);
x2_array(1) = 0;
Y2_array(1) = s - epsilon;   % s -----> guess
T2_array(1) = 1;
x2_val = 0;
T2_val = 1;
Y2_val = s - epsilon; % s ----> guess


f1 = @(T, Y, x) Y;
f2 = @(T, Y, x) 2 * (T ^ 4);


flag = 1;

while flag == 1
s
   

    for i = 1:n
    
        k1 = f1(x1_val,T1_val,Y1_val);
        l1 = f2(x1_val,T1_val,Y1_val);
    
        k2 = f1(x1_val + h/2, T1_val + (h/2)*k1, Y1_val + (h/2)*l1);
        l2 = f2(x1_val + h/2, T1_val + (h/2)*k1, Y1_val + (h/2)*l1);
    
        k3 = f1(x1_val + h/2, T1_val + (h/2)*k2, Y1_val + (h/2)*l2);
        l3 = f2(x1_val + h/2, T1_val + (h/2)*k2, Y1_val + (h/2)*l2);
    
        k4 = f1(x1_val + h, T1_val + h*k3, Y1_val + h*l3);
        l4 = f2(x1_val + h, T1_val + h*k3, Y1_val + h*l3);
    
        T1_val = T1_val + h * (k1 + 2 * k2 + 2 * k3 + k4)/6;
        Y1_val = Y1_val + h * (l1 + 2 * l2 + 2 * l3 + l4)/6;
        x1_val = x1_val + h;
    
        x1_array(i+1) = x1_val;
        Y1_array(i+1) = Y1_val;
        T1_array(i+1) = T1_val;
    end





    for i = 1:n
    
        k1 = f1(x2_val,T2_val,Y2_val);
        l1 = f2(x2_val,T2_val,Y2_val);
    
        k2 = f1(x2_val + h/2, T2_val + (h/2)*k1, Y2_val + (h/2)*l1);
        l2 = f2(x2_val + h/2, T2_val + (h/2)*k1, Y2_val + (h/2)*l1);
    
        k3 = f1(x2_val + h/2, T2_val + (h/2)*k2, Y2_val + (h/2)*l2);
        l3 = f2(x2_val + h/2, T2_val + (h/2)*k2, Y2_val + (h/2)*l2);
    
        k4 = f1(x2_val + h, T2_val + h*k3, Y2_val + h*l3);
        l4 = f2(x2_val + h, T2_val + h*k3, Y2_val + h*l3);
    
        T2_val = T2_val + h * (k1 + 2 * k2 + 2 * k3 + k4)/6;
        Y2_val = Y2_val + h * (l1 + 2 * l2 + 2 * l3 + l4)/6;
        x2_val = x2_val + h;
    
        x2_array(i+1) = x2_val;
        Y2_array(i+1) = Y2_val;
        T2_array(i+1) = T2_val;
    end
    break;

    if abs(T2_array(n+1) - 0) < 10 ^ -4 && abs(T1_array(n+1) - 0) < 10 ^ -4
        break;
    else
       dE_ds = (T1_array(n+1) - T2_array(n+1))/(2 * epsilon);
       s = s - (T2_array(n+1) + T1_array(n+1))/(2 * dE_ds);
    end    

    x1_array = zeros(1,n+1);
    Y1_array = zeros(1,n+1);
    T1_array = zeros(1,n+1);
    x1_array(1) = 0;
    Y1_array(1) = s + epsilon;   % s -----> guess
    T1_array(1) = 1;
    x1_val = 0;
    T1_val = 1;
    Y1_val = s + epsilon; % s ----> guess
    
    x2_array = zeros(1,n+1);
    Y2_array = zeros(1,n+1);
    T2_array = zeros(1,n+1);
    x2_array(1) = 0;
    Y2_array(1) = s - epsilon;   % s -----> guess
    T2_array(1) = 1;
    x2_val = 0;
    T2_val = 1;
    Y2_val = s - epsilon; % s ----> guess
    

 end    


