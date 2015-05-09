function hdpm = hdpm_init(KK,aa_0,q0,docs,docs_zz,aa_1);
% initialize finite mixture model, with 
% KK mixture components,
% aa concentration parameter,
% q0 an empty component with hh prior,
% xx data, x_i=xx{i}
% zz initial cluster assignments (between 1 and KK).

hdpm.KK = KK;
hdpm.NN = length(docs);
hdpm.qq = cell(1,KK);
hdpm.aa_0 = aa_0;
hdpm.aa_1 = aa_1;

dps = cell(1,length(docs));

% initialize mixture components
for kk = 1:KK,
  hdpm.qq{kk} = q0;
end

for dd = 1 : hdpm.NN
    dp.xx = docs{dd};
    dp.zz = docs_zz{dd};
    dp.nn = zeros(1,KK);
    dps{dd} = dp;
end
hdpm.docs = docs;

% add data items into mixture components
for ii = 1:hdpm.NN
    dp = hdpm.docs{ii};
    for jj = 1:length(dp.xx)
      kk = dp.zz(jj);
      hdpm.qq{kk} = additem(hdpm.qq{kk},dp.xx(jj));
      dp.nn(kk) = dp.nn(kk) + 1;
    end
    dpcomp = dp.nn > 0;
    
    hdpm.docs{ii} = dp;
end

end

function [v] = relabel(v, old_label, new_label)
    for i = 1:length(v)
        v(i) = new_label(find(old_label==v(i)));
    end
end