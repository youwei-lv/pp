
% demo of DP mixture model
dd = 2;
KK = 1;
trueK = 3;
NN = 10000;
aa = 1;
s0 = 30;
ss = 10;
numiter = 100;

% hh.dd       = (1x1) dimensionality
% hh.ss       = (1x1) relative variance of mm versus data (cluster separability)
% hh.VV       = (dxd) mean covariance matrix of clusters.
% hh.vv       = (1x1) degrees of freedom of inverse Wishart covariance prior.
% hh.uu       = (dx1) prior mean vector

hh.dd = dd;
hh.ss = s0^2/ss^2;
hh.vv = 5;
hh.VV = ss^2*eye(dd);
hh.uu = zeros(dd,1);

% % % construct data
%  truez = ceil((1:NN)/NN*trueK);
%  mu = randn(dd,trueK)*s0;
%  yy = mu(:,truez) + randn(dd,NN)*ss;
data_2014 = data(data(:,1)==2014,:);
data_2014 = data_2014(data_2014(:,2)==4,:);
data_2014 = data_2014';

data_2014(4,:)=data_2014(4,:)/1000 + 0.01*rand;
data_2014(5,:)=data_2014(5,:)+0.02*rand;
xx = num2cell(data_2014([5,4],:),1);

NN = size(xx,2);
% initialize component assignment
zz = ceil(rand(1,NN)*KK);

% initialize DP mixture
dpm = dpm_init(KK,aa,Gaussian(hh),xx,zz);

% initialize records
record.KK = zeros(1,numiter);

% initialize colors to be used for plotting
cc = colormap;
cc = cc(randperm(size(cc,1)),:);
cc = cc(rem(1:NN,size(cc,1))+1,:);

axis([0 max(data_2014(5,:))+1  0 max(data_2014(4,:))+1]);

% run
figure(1); 
tic; lasttime = toc;
for iter = 1:numiter
  % pretty pictures
  if toc>lasttime+1, 
    dpm_demo2d_plot(dpm,cc); 
    drawnow; 
    lasttime = toc;
    title(['DP mixture: iter# ' num2str(iter)]);
  end

  % gibbs iteration 
  dpm = dpm_gibbs(dpm,1);

  % record keeping
  record.KK(iter) = sum(dpm.nn>0);
end

