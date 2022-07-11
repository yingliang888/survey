%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%Set up grids and run tauchen%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('%%%%%%Set up grids and run Tauchen')
disp(' ')
%%%%%%%%%% set solution parameters
%grid parameters
z_num = 100;        %number of grids for z
k_min      = 1;     % Min capital
k_max      = 600;   % Max capital
k_num      = 600;   % Number of capital grid points

%solution parameters
tol        = 0.001; % Tolerance

%simulation parameters
num_simulations = 101001; %simulation length.
burnin         = 1000;
k0              = 1; % initial capital (grid point)
z0              = 1; % initial z-category


%%%%%%%%%% profitability shock process
[z_vec, z_prob_mat] = tauchen(mean_z,std_epsilon,rho,3,z_num);
z_prob_mat(z_prob_mat<0) = 0; %fix rounding issue leading to negatives in tauchen() function