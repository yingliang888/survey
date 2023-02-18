
clear;clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step 1. import raw data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% data file in csv.
% format: Column1: management forecast value, missing is treated as empty.
% Column2: Firm ID.

filename='data.csv';
[num,txt] = xlsread(filename);
guidance = num(:,1); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step 2. Estimate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define function fun by calling setmoments.m.
fun = @(x)setmoments(x,guidance);

% set lower and upper bounds of parameters: 0<p<1, 0<c<1
lb = [0 0];
ub = [1 5];
[parahat,fval] = fminsearch(fun,[0.5 0.5])
