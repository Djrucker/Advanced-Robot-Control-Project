%%% Approximate Q-learning Training Script
% for simulink model: AQLRL.slx

clear; clc; close all; 

%% ----------------------
% Training Parameters
%% ----------------------
load('squaretrajectory.mat');

N_episodes = 50; % number of training episodes
alpha = 0.6; % learning rate (used in Qupdate)
gamma = 0.5; % discount factor (used in Qupdate)
epsilon = 0.6; % initial exploration rate
epsilon_decay = 0.99; % epsilon decay per episode
epsilon_min = 0.05; % minimum epsilon 
alpha_min = 0.02; 
alpha_decay = 0.98;



%% --------------------------
% Define Discrete Action set
%% --------------------------
% Each row = [ux, uy, uz, roll, pitch, yaw]

actions = [
    0,    0,  0,  0,  0,  0; % Hover
    0.02, 0,  0,  0,  0,  0; % move +x
   -0.02, 0,  0,  0,  0,  0; % move -x
    0,  0.02, 0,  0,  0,  0; % move +y
    0, -0.02, 0,  0,  0,  0; % move -y
    % 0,   0, 0, 0,  0,  0; % move +z
    % 0,   0, 0,0,  0,  0; % move -z 
    ]; 

nFeatures = 9; % must match the FeatureBuilder block output length
nActions = size(actions, 1); % number of discrete actions

% Initialize weights: [nFeatures x nActions]
weights = zeros(nFeatures, nActions); 

%% ----------------------
% Logs for analysis
%% ----------------------

episodeRewards = zeros(N_episodes, 1); 

%% ----------------------
% Training Loop
%% ----------------------

for ep = 1:N_episodes
    fprintf('Starting episode %d / %d (epsilon=%.3f)\n', ep, N_episodes, epsilon); 

    % Push variables into base workspace for simulink
    assignin('base', 'weights', weights); 
    assignin('base', 'actions', actions); 
    assignin('base', 'epsilon', epsilon); 

    % Run Simulink model 
    simOut = sim('AQLRL.slx', 'SaveOutput', 'on'); 

    % Pullupdated weights back from workspace
    weights = evalin('base', 'weights'); 

    % Log episode reward (assuming RewardFcn is ummed inside model)
    if isfield(simOut, 'yout')
        try
            R_total = simOut.yout.getElement('Reward').Values.Data; 
            episodeRewards(ep) = sum(R_total); 
        catch 
            % if not logged, skip
            episodeRewards(ep) = NaN; 
        end 
    end 

    % Decay epsilon
    epsilon = max(epsilon*epsilon_decay, epsilon_min); 
    alpha = max(alpha * alpha_decay, alpha_min); 

    % save progress
    save('weights.mat', 'weights'); 
end 

%% -------------------------
% Plot Learning Curve
%% -------------------------

figure; 
plot(1:N_episodes, episodeRewards, '-o'); 
xlabel('Episode'); 
ylabel('Cumulative Reward'); 
title('Approximate Q-Learning Training Progress'); 
grid on; 


