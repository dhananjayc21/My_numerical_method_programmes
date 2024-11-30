% Case --->  dT/dt = d/dX(alpha(T)*dT/dX)
% Control Parameters
% Lets take n nodal points including the T_h and T_c point

T_h = 300;
T_c = 100;
n = 15;
alpha = @(T) 0.004 * T + 0.5;
delta_t = 0.005;
delta_x = 0.125;
fo = delta_t/(delta_x * delta_x);


% Creating and Initialising the Temperature Matrix ---> answer matrix ---> Here this matrix will keep on changing as we march in time

T_matrix = repmat(130, n, 1); % initialization of the matrix
T_matrix(1,1) = T_h;
T_matrix(n,1) = T_c; 

T_matrix_new = repmat(130, n, 1); % initialization of the matrix
T_matrix_new(1,1) = T_h;
T_matrix_new(n,1) = T_c; 


% Creating the A matrix ---> No need to create this matrix for the explicit case

A_matrix = zeros(n,n);
A_matrix(1,1) = 1;
A_matrix(n,n) = 1;
for i = 2:n-1
    for j = 1:n
        if i==j
            alpha_w = (alpha(T_matrix(i-1)) + alpha(T_matrix(i)))/2;
            alpha_e = (alpha(T_matrix(i)) + alpha(T_matrix(i+1)))/2;
            fo_e = alpha_e * fo;
            fo_w = alpha_w * fo;
            A_matrix(i,j-1) = -fo_w;
            A_matrix(i,j) = 1 + fo_e + fo_w;
            A_matrix(i,j+1) = -fo_e;
        end
    end
end



ct = 0;
it = 0;

% plotting T_matrix vs x

x = 0.125 *(1:1:n);
Temp_data = T_matrix(x/0.125);
h = plot(x,Temp_data);
ylabel('Temperature (T)');    % Label for the x-axis
xlabel('x');                  % Label for the y-axis


while ct < n

    T_matrix_copy = T_matrix;
    for i = 2:n-1
        alpha_w = (alpha(T_matrix(i-1)) + alpha(T_matrix(i)))/2;
        alpha_e = (alpha(T_matrix(i)) + alpha(T_matrix(i+1)))/2;
        fo_e = alpha_e * fo;
        fo_w = alpha_w * fo;
        T_matrix_new(i) = T_matrix(i) + fo_e * T_matrix(i+1) + fo_w * T_matrix(i-1) - (fo_e + fo_w) * T_matrix(i);
    end
    T_matrix = T_matrix_new;
    ct = 0;
    for i = 1:n
        if abs(T_matrix_copy(i) - T_matrix(i)) < 0.01
            ct = ct + 1;
        end    
    end

    % Update the plot
    Temp_data = T_matrix(x/0.125);
    set(h, 'YData', Temp_data);
    
    % Pause to create the animation effect
    pause(0.1); % Adjust this value for desired animation speed

    it = it + 1;

end    




% Solution matrix --> T_matrix

T_matrix


