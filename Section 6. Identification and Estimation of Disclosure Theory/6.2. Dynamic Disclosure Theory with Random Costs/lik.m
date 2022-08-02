function [lik2] = lik(X,dataset)

%   Detailed explanation goes here
% Input: (1) paramters X:[phik0, phik1, alpha, beta, sigma_x, and sigma_e]
% (2) data: FirmID YearID disclosure indicator Management forecast,
% actual eps.

% Output: likelihood function value.

% Step 0.
phik0   = X(1);
phik1   = X(2);
alpha   = X(3);
beta    = X(4);
sigma_x = X(5);
sigma_e = X(6);

%Step 1. Create unique Firm ID.
UID = unqiue(dataset(:,1));

% Step 2. Calculate likelihood function by firm. 
% Year = dataset(:,2);
rng(2022)
p0 = rand(1);
% See Footnote 13 (p78) of BMM 2020. 
lnlik = [];
parfor j=1:UID
    firm = (Firm==UID(j));
    dataID = dataset(:,firm);
    MF  = dataID(:,3);       % extract forecasts series for firm j. 
    d   = ~isnan(MF(:,3));   % disclosure indicator
    EPS = dataID(:,4);       % extract actual earnings.
% Loop over each time t to update perceived probability.
    l   =  zeros(1,length(dataID));
    p   =  p0;
    for h=1:length(dataID)
%      Call function to get the disclosure threshold.
        pnd = getpnd(p,alpha,beta,sigma_x);
        if d(h) == 1
           l(h) = (1-p)*(1-normcdf(alpha.*pnd-MF(h))-beta).*...
               normpdf((MF(h)-sigma_x^2.*EPS(h)./sigma_e^2)./(sigma_x.*...
               sqrt(1-sigma_x^2/sigma_e^2))).*normpdf(EPS(h)./sigma_e)./...
               (sigma_x.*sigma_e.*sqrt(1-sigma_x^2/sigma_e^2));
           p = phik1;
        else
            nu = (p + (1-p).*normcdf(alpha.*MF(h)-alpha.*pnd-beta));
            l(h) = nu./sigma_e.*normpdf(EPS(h)/sigma_e);
            p = p/nu*phik0+(1-p/nu)*phik1;
        end
    end
    lnlik(j) = sum(log(l));
end
lik = sum(lnlik);

lik2 = -lik;
