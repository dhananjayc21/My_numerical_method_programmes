% Case --->  dT/dt = alpha * d2T/dX2
% Control Parameters
% Lets take n nodal points including the T_h and T_c point

T_h = 300;
T_c = 100;
n = 15;
delta_t = 0.005;
delta_x = 0.125;
fo = delta_t/(delta_x * delta_x);


% Creating the A matrix ---> No need to create this matrix for the explicit case
A_matrix = zeros(n,n);
A_matrix(1,1) = 1;
A_matrix(n,n) = 1;
for i = 2:n-1
    for j = 1:n
        if i==j
            A_matrix(i,j-1) = -fo;
            A_matrix(i,j) = 1 + 2 * fo;
            A_matrix(i,j+1) = -fo;
        end
    end
end

% Creating and Initialising the Temperature Matrix ---> answer matrix ---> Here this matrix will keep on changing as we march in time

T_matrix = repmat(130, n, 1); % initialization of the matrix
T_matrix(1,1) = T_h;
T_matrix(n,1) = T_c; 

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
        T_matrix(i) = T_matrix(i) + fo * (T_matrix(i-1) - 2 * T_matrix(i) + T_matrix(i+1));
    end
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


