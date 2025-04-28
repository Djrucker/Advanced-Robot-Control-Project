clear; clc; close all; 

if isfile('Q_lastiter.mat')
    load('Q_lastiter.mat', 'Q'); 
else 
    Q = zeros(5, 5, 5, 5, 5, 5, 7, 7, 7); 
end 

gamma = 0.9; 
alpha = 0.5; 
total_episodes = 100; 

load('squaretrajectory.mat'); 
assignin('base', 'ref', ref);

for episode = 1:total_episodes
    disp(['Starting episode', num2str(episode)]); 

    assignin('base', 'Q_lastiter', Q); 
    assignin('base', 'gamma', gamma); 
    assignin('base', 'alpha', alpha); 

    simOut = sim('RL_Project.slx', 'StopTime', '75'); 

    Q = evalin('base', 'Q_matrix'); 

    save('Q_lastiter.mat', 'Q'); 
end

disp('Training completed')

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