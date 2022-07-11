%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% This file runs bootstrap to create variance covariance matrix for %%%%
%%%% two basu coefficients.   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Store coefficients in matrix coef_sim
coef_sim = zeros(500,2);

for i = 1 : 500
    Simulate
    coef_sim(i,:) =moments(earnings,value,cfo,I);
end

W = cov(coef_sim);

clearvars coef_sim