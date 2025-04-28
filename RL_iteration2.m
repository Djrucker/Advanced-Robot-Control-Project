clear; clc; close all; 

if isfile('Qpos_lastiter.mat') && isfile('Qang_lastiter.mat')'
    load('Qpos_lastiter.mat', 'Q_pos'); 
    load('Qang_lastiter.mat', 'Q_ang'); 
else 
    Q_pos = zeros(50,50,3,5,5,5); 
    Q_ang = zeros(50,50,3,3,3,3);

end 

gamma = 0.9; 
alpha = 0.5; 
total_episodes = 100; 

load('squaretrajectory.mat'); 
assignin('base', 'ref', ref);

for episode = 1:total_episodes
    disp(['Starting episode', num2str(episode)]); 

    assignin('base', 'Qpos_lastiter', Q_pos); 
    assignin('base', 'Qang_lastiter', Q_ang); 
    assignin('base', 'gamma', gamma); 
    assignin('base', 'alpha', alpha); 

    simOut = sim('RL_Project.slx', 'StopTime', '75'); 

    Q_pos = evalin('base', 'Qpos_matrix'); 
    Q_ang = evalin('base', 'Qang_matrix');

    save('Qpos_lastiter.mat', 'Q_pos'); 
    save('Qang_lastiter.mat', 'Q_ang'); 

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