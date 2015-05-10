dd = 1;
KK = 5;
aa_0 = 1;
aa_1 = 0.2;
s0 = 3;
ss = 1;
numiter = 300;

% precision matrix  ~ Wishart(hh.dd, hh.vv, hh.SS)
% mean vector       ~ Normal(hh.dd, hh.uu, hh.rr*qq.RR)
hh.dd = dd;
hh.ss = s0^2/ss^2;% hh.rr=1/hh.ss
hh.vv = 3;
hh.VV = ss^2*eye(dd); %hh.SS = hh.VV*(hh.vv)
%hh.uu = zeros(dd,1);
hh.uu = 1;

users = users(1:1000);

monthlySum_docs = cell(1,length(users));
monthlySum_docs_zz = cell(1,length(users));
for iUser = 1:length(users)
    monthlySum_docs{iUser} = num2cell(users{iUser}.monthlySum / 1000);
    monthlySum_docs_zz{iUser} = randi(KK,1,length(users{iUser}.monthlySum));
end

% initialize DP mixture
hdpm = hdpm_init(KK,aa_0,Gaussian(hh),monthlySum_docs,monthlySum_docs_zz,aa_1);

sampleRecord = cell(1,numiter);
tic;
for iter = 1:numiter
   fprintf(1,'iter %d using %.3f mins.\n', iter, toc/60);
   tic;
   % gibbs iteration 
  hdpm = hdpm_gibbs(hdpm,1);
end

save(['MonthlySumClusteringResult_', datestr(now, 30)]);


clear fm sampleRecord monthlySum_docs monthlySum_docs_zz;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


