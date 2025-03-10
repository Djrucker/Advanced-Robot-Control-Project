net = narxnet(1:2,1:2, 10); 
% net = configure(net, uanglecell, yanglecell); 
disp(net.outputs{end}.size); 

disp(['Expected outputs per time step:', num2str(size(yanglecell{1}, 1))]); 
disp(['Configured network output size: ', num2str(net.outputs{end}.size)]); 

view(net); 
% this code is not working yet, will fix it later - Deandre

[Xs, Xi, Ai, Ts] = preparets(net,uanglecell, {}, yanglecell);
[net,tr] = train(net,Xs, Ts, Xi, Ai); 
netnodelay = removedelay(net); 
% gensim(net); 
gensim(netnodelay); 
figure
plotperform(tr); 
hold off; 
Y = net(Xs, Xi, Ai); 
perf = mse(net, Ts, Y); 
figure
plotresponse(Ts, Y); 
hold off; 
E = gsubtract(Ts, Y); 
ploterrcorr(E);
plotinerrcorr(Xs,E);
net2 = closeloop(net); 
view(net2); 
[Xs, Xi, Ai, Ts] = preparets(net2, uanglecell, {}, yanglecell); 
Y = net2(Xs, Xi, Ai); 
plotresponse(Ts,Y); 
net3 = removedelay(net); 
view(net3); 
[Xs,Xi, Ai, Ts] = preparets(net3, uanglecell, {}, yanglecell); 
Y = net3(Xs, Xi, Ai); 
plotresponse(Ts,Y); 