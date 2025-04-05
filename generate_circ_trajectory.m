num_points = 3000; 
radius = 1.5; 

theta = linspace(0,2*pi, num_points); 

x = radius * cos(theta) - 1.5; 
y = radius * sin(theta); 

z = radius * ones(1, num_points); 

ref = [x;y;z]; 

save('circulartrajectory.mat', 'ref'); 
