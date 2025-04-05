num_points = 3000; 
points_per_side = num_points /3; 
z_value = 1.5; 

p1 = [0,0]; 
p2 = [1.5, sqrt(3)*1.5];
p3 = [3,0]; 

x1 = linspace(p1(1), p2(1), points_per_side); 
y1 = linspace(p1(2), p2(2), points_per_side); 

x2 = linspace(p2(1), p3(1), points_per_side); 
y2 = linspace(p2(2), p3(2), points_per_side);

x3 = linspace(p3(1), p1(1), points_per_side); 
y3 = linspace(p3(2), p1(2), points_per_side); 

x = [x1, x2, x3]; 
y = [y1, y2, y3]; 

z = z_value * ones(1,num_points); 

ref = [x;y;z]; 

save('triangulartrajectory.mat'); 
