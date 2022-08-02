%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Step 0. This folder estimates Bertomeu, Marinovic, and Ma (2020)  
% using maximum likelihood estimation (MLE). The estimation process is the
% following: Step 1. Import dataset that contains firmID, yearID,
% management forecast, and earnings (EPS). Step 2. Define likelihood
% function. Step 3. Use particleswarm to search for the maximum likelihood
% value of the function. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all; clear all; clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step 1. Import dataset. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data requirement:  (1) Management Forecasts Surprise; (2) EPS surprise

filename='data.csv';
[data,txt] = xlsread(filename);

Firm = data(:,1); 
Year = data(:,2);
d = ~isnan(:,3);
MF = data(:,3);
EPS = data(:,4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step 2. Block get likelihood. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Six unknown includes: phik0, phik1, alpha, beta, sigma_x, and sigma_e.
% function lik computes the likelihood function in Equation 6.15.
obj = @(x) lik(x, data);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step 3. Find max likelihood.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% set boundaries
lb = [0 0 0 0 0 0 ];
ub = [1 1 5 2 1 1 ];

[xstar, fval0] = particleswarm(obj,6,lb,ub);
loglik = -fval0;