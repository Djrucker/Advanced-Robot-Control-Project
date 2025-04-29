% === Script to Analyze Debug Values from simOut ===

% Load the debug_values from simOut
% Assuming 'simOut' is your simulation output
debug_values = simOut.debug_values;  % <-- CHANGED this line

% Check dimensions
size_debug = size(debug_values);
disp(['Size of debug_values: ', num2str(size_debug(1)), ' x ', num2str(size_debug(2))]);

% Extract signals
Qpos_current = debug_values(:,1);
Reward_pos = debug_values(:,2);
Qpos_max_next = debug_values(:,3);
Qpos_updated = debug_values(:,4);

Qang_current = debug_values(:,5);
Reward_ang = debug_values(:,6);
Qang_max_next = debug_values(:,7);
Qang_updated = debug_values(:,8);

% Plot position-related Q-values
figure;
subplot(2,1,1);
plot(Qpos_current, 'LineWidth', 1.5); hold on;
plot(Qpos_max_next, 'LineWidth', 1.5);
plot(Qpos_updated, 'LineWidth', 1.5);
legend('Qpos\_current','Qpos\_max\_next','Qpos\_updated');
title('Position-related Q-Values');
xlabel('Timestep');
ylabel('Q Value');
grid on;

% Plot position reward
subplot(2,1,2);
plot(Reward_pos, 'LineWidth', 1.5);
legend('Reward\_pos');
title('Position Reward Over Time');
xlabel('Timestep');
ylabel('Reward');
grid on;

% Plot angle-related Q-values
figure;
subplot(2,1,1);
plot(Qang_current, 'LineWidth', 1.5); hold on;
plot(Qang_max_next, 'LineWidth', 1.5);
plot(Qang_updated, 'LineWidth', 1.5);
legend('Qang\_current','Qang\_max\_next','Qang\_updated');
title('Angle-related Q-Values');
xlabel('Timestep');
ylabel('Q Value');
grid on;

% Plot angular reward
subplot(2,1,2);
plot(Reward_ang, 'LineWidth', 1.5);
legend('Reward\_ang');
title('Angular Reward Over Time');
xlabel('Timestep');
ylabel('Reward');
grid on;

disp('--- Finished plotting debug values ---');




