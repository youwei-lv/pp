dd = 1;
KK = 5;
aa = 0.1*KK;
s0 = 5;
ss = 5;
numiter = 200;

% precision matrix  ~ Wishart(hh.dd, hh.vv, hh.SS)
% mean vector       ~ Normal(hh.dd, hh.uu, hh.rr*qq.RR)
hh.dd = dd;
hh.ss = s0^2/ss^2;% hh.rr=1/hh.ss
hh.vv = 3;
hh.VV = ss^2*eye(dd); %hh.SS = hh.VV*(hh.vv)
%hh.uu = zeros(dd,1);
hh.uu = 10;

shoppingInterval_docs = cell(1,length(users));
shoppingInterval_docs_zz = cell(1,length(users));
for iUser = 1:length(users)
    shoppingInterval_docs{iUser} = users{iUser}.shoppingIntervals;
    shoppingInterval_docs_zz{iUser} = randi(KK,1,length(users{iUser}.shoppingIntervals));
end

% initialize DP mixture
fm = fm_docs_init(KK,aa,Gaussian(hh),shoppingInterval_docs,shoppingInterval_docs_zz);

sampleRecord = cell(1,numiter);
tic;
for iter = 1:numiter
   fprintf(1,'iter %d using %.3f mins.\n', iter, toc/60);
   tic;
   % gibbs iteration 
  [fm, sampleRecord{iter}] = fm_gibbs_docs(fm,1);
end

save 'ShoppingIntervalClusteringResult.mat'


clear fm sampleRecord shoppingInterval_docs shoppingInterval_docs_zz;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


