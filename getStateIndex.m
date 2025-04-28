function idx = getStateIndex(state)
    pos_bins = 10; 
    z_bins = 5; 
    angle_bins = 5; 
    state_min = [-1, -1, 0, -30, -30, -30]; 
    state_max = [2, 2, 2, 30, 30, 30]; 

    idx = zeros(1,6); 

    idx(1) = floor((state(1) - state_min(1)) / (state_max(1) - state_min(1)) * (pos_bins-1)) + 1; 
    idx(2) = floor((state(2) - state_min(2)) / (state_max(2) - state_min(2)) * (pos_bins-1)) + 1; 
    idx(3) = floor((state(3) - state_min(3)) / (state_max(3) - state_min(3)) * (pos_bins-1)) + 1; 

    for i = 4:6
        idx(i) = floor((state(i) - state_min(i)) / (state_max(i) - state_min(i)) * (angle_bins -1)) +1; 
    end 


    idx = max(min(idx, [pos_bins, pos_bins, z_bins, angle_bins, angle_bins, angle_bins]), 1); 
end 
