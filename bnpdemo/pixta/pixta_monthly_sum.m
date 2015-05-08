% demo of DP mixture model in 1D
dd = 1;
KK = 4;
NN = 10;
xx = [-2+.5*randn(1,5) 2+.5*randn(1,5)];
aa = 1;
s0 = 2;
ss = 2;
numiter = 400;


xx = data(1:500,4)'/1000;
NN = length(xx);
hh.dd = dd;
hh.ss = s0^2/ss^2;
%hh.ss = 10;
hh.vv = 5;
hh.VV = ss^2*eye(dd);
%hh.uu = zeros(dd,1);
hh.uu = 3;

% set range over which to evaluate density
yy = 0:.01:max(xx);

% initialize records
record.KK = zeros(1,numiter);
record.p0 = zeros(numiter,length(yy)); % densities
record.pp = zeros(numiter,length(yy)); % densities

% construct DP mixture with no data items to get prior samples of densities
dpm0 = dpm_init(0,aa,Gaussian(hh),{},[]);

% initialize DP mixture with data items.
xx = num2cell(xx); % data
zz = ceil(rand(1,NN)*KK); % initialize component assignment
dpm = dpm_init(KK,aa,Gaussian(hh),xx,zz);

% run
for iter = 1:numiter
  fprintf(1,'DP mixture: iter# %d ',iter);
  drawnow; 

  % gibbs iteration 
  dpm = dpm_gibbs(dpm,1);

  fprintf(1, 'number of classes: %d.\n', dpm.KK);
  % record keeping
  record.KK(iter) = sum(dpm.nn>0);
  record.pp(iter,:) = dpm_demo1d_density(dpm,yy); 
  record.p0(iter,:) = dpm_demo1d_density(dpm0,yy);
end
fprintf(1,'\n');

figure(1);
dpm_demo1d_summarize(dpm0,yy,record.p0);
title('Prior over densities');
figure(2);
dpm_demo1d_summarize(dpm,yy,record.pp);
title('Posterior over densities');
