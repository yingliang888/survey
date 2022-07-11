%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code replicates the simulation of Breuer and Windisch (2019) and
% create Figure 3. Asymmetry in Earnings-to-Price in the survey. This code
% is heavily adapted from Breuer and Windisch (2019) appendix. Please refer
% to the appendix for more detailed information. 
% By Jeremy Bertomeu, Ying Liang, and Iván Marinovic %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;
disp('%%%%%%%%%%%%% Asymmetry in Earnings-to-Price%%%%%%%%%%')
disp(' ')
% housekeeping
% Choose seed
rng('default');

%%%%%%%%%% set model parameters (7 mentioned in Table 1 of BW and others).  
mean_z      = 1;
rho         = 0.5;
std_epsilon  = 1;
beta       = 0.9;  % beta = 1/(1+r) in BW, where r is 0.1 in BW's simulation.
theta      = 0.33; % Capital share
psi        = 0.5;  % disruption cost
delta      = 0.3;  % Depreciation

%%%%%%%%% Set up grids 
Setup

%%%%%%%%%% implement value function iteration

disp('%%% Implement baseline VFI solution')
disp(' ')
tic
valuefunctioniteration
toc

%%%%%%%%%% simulate data using value function and policy function 
disp('%%% Implement simulation')
disp(' ')
tic
Simulate
toc
%%%%%%%%% Run Basu regression using the simulated data.
Basu_regression

%%%%%%%%% Estimation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%