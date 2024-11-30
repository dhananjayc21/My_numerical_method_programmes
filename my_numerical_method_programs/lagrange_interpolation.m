n = 5;
data_points_x = [1, 4, 5, 8, 20];
data_points_y = [0, 1.38628, 1.60943, 2.0794, 2.9957];
x_given = 2;

syms x y
L = sym(zeros(1, n));

for i = 1:n
    L(i) = 1;
    for j = 1:i-1
        L(i) = simplifyFraction(L(i) * ((x - data_points_x(j))/(data_points_x(i) - data_points_x(j))));
    end
    for j = i+1:n
        L(i) = simplifyFraction(L(i) * ((x - data_points_x(j))/(data_points_x(i) - data_points_x(j))));
    end

end

y = 0;
for i = 1:n
    y = y + L(i) * data_points_y(i); 
end

y = simplifyFraction(y);

y_at_x = double(subs(y,x,x_given));
disp(y_at_x);