% === Full Q-Matrix Debugging for Qpos_lastiter ===

disp('--- Full Qpos_lastiter Debugging (X, Y, Z space) ---');

% 1. Global min and max
maxQ = max(Qpos_lastiter(:));
minQ = min(Qpos_lastiter(:));
disp(['Global Max Qpos_lastiter value: ', num2str(maxQ)]);
disp(['Global Min Qpos_lastiter value: ', num2str(minQ)]);

% Assume bins for x and y movement
bins_pos = [-0.02, -0.01, 0, 0.01, 0.02];

% 2. Loop over positional states
[x_dim, y_dim, z_dim, ~, ~, ~] = size(Qpos_lastiter);

for x_bin = 1:x_dim
    for y_bin = 1:y_dim
        for z_bin = 1:z_dim

            pos_qvals = zeros(5,5);
            for a1 = 1:5
                for a2 = 1:5
                    pos_qvals(a1,a2) = Qpos_lastiter(x_bin, y_bin, z_bin, a1, a2, 3);
                end
            end

            if all(pos_qvals(:) == 0)
                continue;
            end

            disp('------------------------');
            disp(['State (X bin=', num2str(x_bin), ', Y bin=', num2str(y_bin), ', Z bin=', num2str(z_bin), ')']);
            for a1 = 1:5
                for a2 = 1:5
                    disp(['Action (x=', num2str(bins_pos(a1)), ', y=', num2str(bins_pos(a2)), ') Q-value: ', num2str(pos_qvals(a1,a2))]);
                end
            end

            [max_val, ind] = max(pos_qvals(:));
            [best_a1, best_a2] = ind2sub(size(pos_qvals), ind);
            disp(['Best x movement: ', num2str(bins_pos(best_a1)), ', Best y movement: ', num2str(bins_pos(best_a2))]);
        end
    end
end
