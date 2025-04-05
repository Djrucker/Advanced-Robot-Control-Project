
squared_error_position = (out.u_position - out.y_position).^2; 
squared_error_angle = (out.u_angle - out.y_angle).^2; 

mse_x_position = mean(squared_error_position(1,:)); 
mse_y_position = mean(squared_error_position(2,:)); 
mse_z_position = mean(squared_error_position(3,:)); 

mse_total_position = mean([mse_x_position, mse_y_position, mse_z_position]); 

mse_x_angle = mean(squared_error_angle(1,:)); 
mse_y_angle = mean(squared_error_angle(2,:)); 
mse_z_angle = mean(squared_error_angle(3,:)); 

mse_total_angle = mean([mse_x_angle, mse_y_angle, mse_z_angle]); 
fprintf('--------------------------------------------\n'); 
fprintf('Position MSE\n'); 
fprintf('MSE X: %.6f\n', mse_x_position); 
fprintf('MSE Y: %.6f\n', mse_y_position); 
fprintf('MSE Z: %.6f\n', mse_z_position);
fprintf('Total MSE: %.6f\n', mse_total_position); 
fprintf('--------------------------------------------\n'); 
% fprintf('Angle MSE\n'); 
% fprintf('MSE X: %.6f\n', mse_x_angle); 
% fprintf('MSE Y: %.6f\n', mse_y_angle); 
% fprintf('MSE Z: %.6f\n', mse_z_angle); 
% fprintf('Total MSE: %.6f\n', mse_total_angle); 

error_position = out.u_position - out.y_position; 

var_x_position = var(error_position(1,:)); 
var_y_position = var(error_position(2,:)); 
var_z_position = var(error_position(3,:)); 

var_total_position = mean([var_x_position, var_y_position, var_z_position]); 

error_angle = out.u_angle - out.y_angle; 

var_x_angle = var(error_angle(1,:)); 
var_y_angle = var(error_angle(2,:)); 
var_z_angle = var(error_angle(3,:)); 

var_total_angle = mean([var_x_angle, var_y_angle, var_z_angle]); 
fprintf('----------------------------------------\n'); 
fprintf('Position Variance\n'); 
fprintf('Variance X: %.6f\n', var_x_position); 
fprintf('Variance Y: %.6f\n', var_y_position); 
fprintf('Variance Z: %.6f\n', var_z_position); 
fprintf('Total Variance: %.6f\n', var_total_position); 
fprintf('----------------------------------------\n'); 
% 
% fprintf('Angle Variance\n');
% fprintf('Variance X: %.6f\n', var_x_angle); 
% fprintf('Variance Y: %.6f\n', var_y_angle); 
% fprintf('Variance Z: %.6f\n', var_z_angle); 
% fprintf('Total Variance: %.6f\n', var_total_angle); 


