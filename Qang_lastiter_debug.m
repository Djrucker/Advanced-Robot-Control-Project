% === Full Q-Matrix Debugging for Qang_lastiter ===

disp('--- Full Qang_lastiter Debugging (Pitch, Yaw, Roll space) ---');

% 1. Global min and max
maxQ = max(Qang_lastiter(:));
minQ = min(Qang_lastiter(:));
disp(['Global Max Qang_lastiter value: ', num2str(maxQ)]);
disp(['Global Min Qang_lastiter value: ', num2str(minQ)]);

% Assume bins for yaw
bins_ang = [-0.02, 0, 0.02];

% 2. Loop over angular states
[pitch_dim, yaw_dim, roll_dim, ~, ~, ~] = size(Qang_lastiter);

for pitch_bin = 1:pitch_dim
    for yaw_bin = 1:yaw_dim
        for roll_bin = 1:roll_dim

            yaw_qvals = zeros(1,3);
            for a3 = 1:3
                yaw_qvals(a3) = Qang_lastiter(pitch_bin, yaw_bin, roll_bin, 2, 2, a3);
            end

            if all(yaw_qvals == 0)
                continue;
            end

            disp('------------------------');
            disp(['Angular State (Pitch bin=', num2str(pitch_bin), ', Yaw bin=', num2str(yaw_bin), ', Roll bin=', num2str(roll_bin), ')']);
            for a3 = 1:3
                disp(['Yaw action ', num2str(bins_ang(a3)), ' rad Q-value: ', num2str(yaw_qvals(a3))]);
            end

            [~, best_idx] = max(yaw_qvals);
            disp(['Best yaw action: ', num2str(bins_ang(best_idx)), ' rad']);
        end
    end
end
