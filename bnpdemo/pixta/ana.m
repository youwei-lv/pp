shoppingIntervalDir = 'data/ShoppingIntervalClusteringResult_20150510T222329';
monthlySumDir = 'data/MonthlySumClusteringResult_20150510T222447';

KK = 5;
usernum = length(users);
burnin = 20;

files = getAllFiles(shoppingIntervalDir);
userShoppingIntervalCount = cell(1,usernum);
userShoppingIntervalCount(:) = {zeros(1,KK)};
for iFile = burnin + 1:length(files)
shoppingIntervalRec = load([shoppingIntervalDir,'/',num2str(iFile)], 'sampleRecord', 'fm');
shoppingIntervalSample = shoppingIntervalRec.sampleRecord{1};
shoppingIntervalMixture = shoppingIntervalRec.fm;
for iUser = 1:usernum
    userShoppingIntervalCount{iUser} = userShoppingIntervalCount{iUser} + count(shoppingIntervalSample{iUser},KK);
end
end


files = getAllFiles(monthlySumDir);
userMonthlySumCount = cell(1,usernum);
userMonthlySumCount(:) = {zeros(1,KK)};

for iFile = burnin + 1:length(files)
monthlySumRec = load([monthlySumDir,'/',num2str(iFile)], 'sampleRecord', 'fm');
monthlySumSample = monthlySumRec.sampleRecord{1};
monthlySumMixture = monthlySumRec.fm;
for iUser = 1:usernum
    userMonthlySumCount{iUser} = userMonthlySumCount{iUser} + count(monthlySumSample{iUser},KK);
end
end


userCorrM = cell(1,usernum);
userCorrM(:) = {zeros(KK)};
for iUser = 1:usernum
    userCorrM{iUser} = userMonthlySumCount{iUser}'/sum(userMonthlySumCount{iUser}) * userShoppingIntervalCount{iUser}/sum(userShoppingIntervalCount{iUser});
end

avgCorrM = zeros(KK);
for iUser = 1:usernum
    avgCorrM = avgCorrM + userCorrM{iUser};
end

avgCorrM = avgCorrM/usernum;