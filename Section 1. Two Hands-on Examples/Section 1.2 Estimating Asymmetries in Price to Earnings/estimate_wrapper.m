%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% This file estimates the two parameters theta and psi in Section 1.2%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Step 1. Run simulate_wrapper.m first to obtain a simulated datasets and obtain basu 
% coefficients for ret and ret*d_loss.  We will use the two coefficients as
% empirical moments. 
simulate_wrapper
% save coefficients
data_coef = basu(2:3);

% Step 2. Run bootstrap to create SMM weight matrix: W 
tic
disp('%%% bootstrap variance covariance matrix')
bootstrap
toc

% Step 3. prepare for estimation -- very similar to simulation part.
clearvars -except W data_coef 
close all; clc;

disp('%%%%%%%%%%%%% Estimate parameters in Section 1.2 based on BW %%%%%%%%%%')
disp(' ')
global k_min k_max k_num z_num k0 z0 tol num_simulations burnin

% housekeeping
% Choose seed
rng('default');

%%%%%%%%%% set model parameters (7 mentioned in Table 1 of BW and others).  
mean_z      = 1;
rho         = 0.5;
std_epsilon  = 1;
beta       = 0.9;  % beta = 1/(1+r) in BW, where r is 0.1 in BW's simulation.
delta      = 0.3;  % Depreciation

parameters = [mean_z rho std_epsilon beta delta];
% Unknown is theta and psi.[theta: Capital share, psi: disruption cost]

% Set up initial grids and run tauchen.
Setup 

% Step 4. Estimate.

fun = @(x) objective(x,parameters,W,data_coef,z_prob_mat,z_vec);
initial_guess = [0.33 0.5];

disp('%%%%%%%%%%%%% Estimate parameters %%%%%%%%%%')
disp(' ')
tic
[xhat,fval]=fminsearch(fun,initial_guess)
toc
disp(' ')
