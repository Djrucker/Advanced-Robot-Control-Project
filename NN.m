net = narxnet(1:2,1:2, 10); 
net = configure(net, uanglecell, yanglecell); 
disp(net.outputs{end}.size); 
net.outputs{end}.size = size(yanglecell{1},1); 

disp(['Expected outputs per time step:', num2str(size(yanglecell{1}, 1))]); 
disp(['Configured network output size: ', num2str(net.outputs{end}.size)]); 

view(net); 
% this code is not working yet, will fix it later - Deandre

[Xs, Xi, Ai, Ts] = preparets(net,uanglecell, yanglecell);
[net,tr] = train(net,Xs, Ts, Xi, Ai); 

