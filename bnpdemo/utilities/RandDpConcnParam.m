function alpha = RandDpConcnParam(alpha,numdata,numclass,aa,bb,numiter)

% Modification of Escobar and West.  Works for multiple groups of data.
% numdata, numclass are row vectors, one element per group.

if nargin == 5
  numiter = 1;
end

numdata(numdata==0)='';
numclass(numclass==0)='';

totalclass = sum(numclass);
num = length(numdata);

for ii = 1:numiter
  %xx = randbeta((alpha+1)*ones(1,num),numdata);
  xx = betarnd((alpha+1)*ones(1,num),numdata);
  
  zz = rand(1,num).*(alpha+numdata)<numdata;

  gammaa = aa + totalclass - sum(zz);
  gammab = bb - sum(log(xx));
  %alpha = randgamma(gammaa)./gammab;
  alpha  = gamrnd(gammaa,1/gammab);
end