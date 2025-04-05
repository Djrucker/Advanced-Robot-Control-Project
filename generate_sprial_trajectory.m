num_points = 3000; 
radius = 1.5; 
num_turns = 3; 
z_start = 1.5; 
z_end = 3; 

theta = linspace(0,2*pi*num_turns, num_points); 

x = radius * cos(theta) - radius; 
y = radius * sin(theta); 

z = linspace(z_start, z_end, num_points); 

ref = [x;y;z]; 

save('spiralTrajectory.mat', 'ref'); 