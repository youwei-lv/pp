load 'monthly_sum.mat'
load 'shopping_intervals.mat';

original_id = sort(unique(monthly_sum(:,3)));

users = '';

intervalDataCell = '';
intervalUserId = [];
fid = fopen('data/user_shoping_interval_by_year_before_2015_3_1.txt');
tline = fgets(fid);
while ischar(tline)
    data  = sscanf(tline,'%d');
    intervalUserId = [intervalUserId, data(1)];
    intervalDataCell{end+1} = data(2:end);
    tline = fgets(fid);
end
fclose(fid);

for iId = 1:length(original_id)
    user_id = original_id(iId);
    userMonthlySum = monthly_sum(monthly_sum(:,3)==user_id, 4)';
    
    idIndex = intervalUserId == user_id;
    if any(idIndex)
        user.user_id = user_id;
        user.monthlySum = userMonthlySum;
        user.shoppingIntervals = intervalDataCell{idIndex};
        users{end+1} = user;
    end
end