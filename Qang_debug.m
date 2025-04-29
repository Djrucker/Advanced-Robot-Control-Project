% === Corrected Full Q-Matrix Debugging for Angular Q-matrix ===

disp('--- Full Q_ang Debugging (Pitch, Yaw, Roll space) ---');

% 1. Global min and max
maxQ = max(Q_ang(:));
minQ = min(Q_ang(:));
disp(['Global Max Q_ang value: ', num2str(maxQ)]);
disp(['Global Min Q_ang value: ', num2str(minQ)]);

% Assume bins for yaw
bins_ang = [-0.02, 0, 0.02];

% 2. Loop over all angular states (pitch_bin, yaw_bin, roll_bin)
[pitch_dim, yaw_dim, roll_dim, ~, ~, ~] = size(Q_ang);

for pitch_bin = 1:pitch_dim
    for yaw_bin = 1:yaw_dim
        for roll_bin = 1:roll_dim

            % Extract yaw Q-values at this angular state
            yaw_qvals = zeros(1,3);
            for a3 = 1:3  % Only yaw actions, fix roll and pitch action to "zero index" 2
                yaw_qvals(a3) = Q_ang(pitch_bin, yaw_bin, roll_bin, 2, 2, a3);
            end

            % Skip boring states where yaw qvals are all zero
            if all(yaw_qvals == 0)
                continue;
            end

            % Display
            disp('------------------------');
            disp(['Angular State (Pitch bin=', num2str(pitch_bin), ', Yaw bin=', num2str(yaw_bin), ', Roll bin=', num2str(roll_bin), ')']);
            for a3 = 1:3
                disp(['Yaw action ', num2str(bins_ang(a3)), ' rad has Q-value: ', num2str(yaw_qvals(a3))]);
            end

            [~, best_idx] = max(yaw_qvals);
            disp(['Best yaw action: ', num2str(bins_ang(best_idx)), ' rad']);
        end
    end
end
