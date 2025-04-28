function idx = getActionIndex(action)
    action_bins = [-0.0627, -0.0427, -0.0227, 0, 0.0227, 0.0427, 0.0627];
    % angle_bins = [-0.0777, -0.0577, -0.0377, 0, 0.0377, 0.0577, 0.0777];
    
    idx = zeros(1,3); 
    for i = 1:3
        [~, idx(i)] = min(abs(action(i)-action_bins)); 

    end 
end
