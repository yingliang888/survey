function [obj] = setmoments(params,datax)

% This function computes the mean of two moments


% define data
d=1-isnan(datax); % dummy variable {D, ND}.
df=datax; 
df(isnan(datax))=0;
nbobs=length(datax);

% define standard normal pdf, cdf.
F=@(x) normcdf(x);
f=@(x) normpdf(x);


% define parameters
p=params(1);
c=params(2);
z=getz(p,c);

momvect=NaN(nbobs,2);
momvect(:,1)=(1-p).*F(-z)-d;
momvect(:,2)=(1-p).*f(z)-df;


mom=mean(momvect); % dimension of mom is 1*2. 
obj=mom*mom'; % 1*1.
end