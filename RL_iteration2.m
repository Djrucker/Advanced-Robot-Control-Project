clear; clc; close all; 

if isfile('Qx_lastiter.mat')  && isfile('Qy_lastiter.mat')
    load('Qx_lastiter.mat', 'Q_x'); 
    load('Qy_lastiter.mat', 'Q_y'); 
else 
    Q_x = zeros(50,50,3,3,3,3); 
    Q_y = zeros(50,50,3,3,3,3);

end 

gamma = 0.9; 
alpha = 0.05; 
total_episodes = 10; 
load('squaretrajectory.mat'); 
assignin('base', 'ref', ref);
running_avg_Rx = zeros(total_episodes,1); 
running_avg_Ry = zeros( total_episodes,1); 
episode_reward_x = zeros(total_episodes, 1); 
episode_reward_y = zeros(total_episodes, 1); 
total_reward_x = zeros(1, total_episodes); 
total_reward_y = zeros(1, total_episodes); 
cumulative_x = 0; 
cumulative_y = 0; 
reward_snapshots_x = cell(total_episodes, 1); 
reward_snapshots_y = cell(total_episodes, 1); 



for episode = 1:total_episodes
    disp(['Starting episode', num2str(episode)]); 

    assignin('base', 'Qx_lastiter', Q_x); 
    assignin('base', 'Qy_lastiter', Q_y); 
    assignin('base', 'gamma', gamma); 
    assignin('base', 'alpha', alpha); 
    % epsilon_start = 0.5;
    % epsilon_end = 0.05;
    % epsilon_decay_steps = total_episodes;  % Decay over all episodes
    % epsilon = max(epsilon_end, epsilon_start - (episode/epsilon_decay_steps)*(epsilon_start - epsilon_end));
    epsilon = 0.4; 
    assignin('base', 'epsilon', epsilon); 

    simOut = sim('RL_Project.slx', 'StopTime', '74.975'); 

    Q_x = simOut.Qx_matrix; 
    Q_y = simOut.Qy_matrix; 
    assignin('base', 'Qx_lastiter', Q_x); 
    assignin('base', 'Qy_lastiter', Q_y); 
    % total_reward(episode) = sum(reward_y) + sum(reward_x); 
    cumulative_x = cumulative_x + sum(simOut.reward_x); 
    cumulative_y = cumulative_y + sum(simOut.reward_y); 
    total_reward_x(episode) = cumulative_x; 
    total_reward_y(episode) = cumulative_y; 

    episode_reward_x(episode) = sum(simOut.reward_x); test the model to see how it performs with its default parameters 
    episode_reward_y(episode) = sum(simOut.reward_y); 

    if episode > 1
        running_avg_Rx(episode) = sum(episode_reward_x(1:n-1)) / (n-1); 
        running_avg_Ry(episode) = sum(episode_reward_y(1:n-1)) / (n-1); 
    else 
        running_avg_Rx(episode) = 0; 
        running_avg_Ry(episode) = 0; 
    end 

    if ismember(episode, [1, 13, 25])
        reward_snapshots_x{n} = simOut.reward_x; 
        reward_snapshots_y{n} = simOut.reward_y; 
    end 


    save('Qx_lastiter.mat', 'Q_x'); 
    save('Qy_lastiter.mat', 'Q_y'); 

end
disp('Training completed')


figure; 
plot(1:total_episodes, total_reward_x, 'b', 'LineWidth', 1.5); 
hold on; 
plot(1:total_episodes, total_reward_y, 'r', 'LineWidth', 1.5); 
xlabel('Episode Number'); 
ylabel('Cumulative Reward'); 
legend('X Direction', 'Y Direction'); 
title('Episode Reward During Training'); 
grid on; 
hold off; 

figure; 
plot(1:total_episodes, running_avg_Rx, 'r', 'DisplayName', 'Running Avg X'); 
hold on; 
plot(1:total_episodes, running_avg_y,'b', 'DisplayName', 'Running Avg Y'); 
xlabel('Episode'); 
ylabel('Running Average Reward'); 
legend; 
grid on; 
title('Running Average of Episode Rewards (X and Y)'); 
save('Total_reward', 'Q_x'); 
hold off; 

figure; 
subplot(3,1,1); 
plot(reward_snapshots_x{1}, 'r', 'DisplayName', 'X Reward');
hold on; 
plot(reward_snapshosts_y{1}, 'b', 'DisplayName', 'Y Reward'); 
title('Early Training (Episode 1)'); 
xlabel('Time step'); 
ylabel('Reward'); 

subplot(3,1,2); 
plot(reward_snapshots_x{13}, 'r', 'DisplayName', 'X Reward');
hold on; 
plot(reward_snapshosts_y{13}, 'b', 'DisplayName', 'Y Reward'); 
title('Mid Training (Episode 13)'); 
xlabel('Time step'); 
ylabel('Reward'); 

subplot(3,1,3); 
plot(reward_snapshots_x{25}, 'r', 'DisplayName', 'X Reward');
hold on; 
plot(reward_snapshosts_y{25}, 'b', 'DisplayName', 'Y Reward'); 
title('Late Training (Episode 25)'); 
xlabel('Time step'); 
ylabel('Reward'); 


% 
% Q = zeros(50,50,50,50,50,50,7,7,7);  % adjust size if needed
% save('Q_lastiter.mat', 'Q');         % initialize
% 
% for t = 1:100  % training episodes
%     load('Q_lastiter.mat', 'Q');
%     assignin('base', 'Q_lastiter', Q);
%     SimOut = sim('yourmodel.slx');  % simulate
%     Q = evalin('base', 'Q_matrix'); % updated Q
%     save('Q_lastiter.mat', 'Q');
% end