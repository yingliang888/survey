function [fval] = objective(x,params,W, data_mom,z_prob_mat,z_vec)
global k_min k_max k_num z_num k0 z0 tol num_simulations burnin
%OBJECTIVE function uses the given parameters X to (1) solve VFI, (2) simulate
%datasets to generate moments (Basu coefficients), (3) returns SMM results.
% We assume equal weight for now. 

mean_z      = params(1);
rho         = params(2);
std_epsilon  = params(3);
beta       = params(4);  % beta = 1/(1+r) in BW, where r is 0.1 in BW's simulation.
delta      = params(5);  % Depreciation
theta       = x(1);
psi         =x(2);

%%%%%%%%%% implement value function iteration
valuefunctioniteration

%%%%%%%%%% simulate data using value function and policy function 
Simulate

%%%%%%%%% Run Basu regression using the simulated data.
mom_s = moments(earnings, value,cfo,I);

% fval = (data_mom - mom_s)'*inv(W)*(data_mom - mom_s);

fval = (data_mom - mom_s)'*eye(2)*(data_mom - mom_s);

end

