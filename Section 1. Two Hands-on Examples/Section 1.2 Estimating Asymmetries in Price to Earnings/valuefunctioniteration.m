%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%Value Function Iteration%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%Credit: Breuer and Windisch%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%initialize guess for value function
% Capital grid
    k_grid = linspace(k_min,k_max,k_num );
    k_mat  = ones(k_num ,1)*k_grid; % Rows are next period, columns are current period

% Value function
    V_old = ones(z_num, k_num );
    V_new = zeros(z_num, k_num );

% Policy
    policy = zeros(z_num, k_num );

    
% Value function iteration
    while(max(abs(V_old-V_new)) > tol)
        % Proposal/iteration
        V_old = V_new;

        % Expectation of V
        EVmat = z_prob_mat'*V_old;
        EVmat = EVmat';
        EVmat = EVmat(:);

        % Revenue
        revenue = kron(z_vec', (k_mat.^theta));

        % Capital adjustment cost
        adj_cost = kron(ones(z_num, 1), psi*((1-delta)*k_mat-k_mat').^2./k_mat);
        
        % Investment cash flow
        inv_cash_flow = kron(ones(z_num, 1), (1-delta)*k_mat-k_mat');

        % Total cash flow (after investing)
        cash_flow = revenue-adj_cost+inv_cash_flow;

        % Value function
        v = cash_flow+beta*EVmat*ones(1, k_num );
        
        % Pick the largest value in v, and assign the k index as policy.
        for i=1:z_num
            [V_new(i,:), policy(i,:)] = max(v(1+(i-1)*k_num :i*k_num ,:));
        end
    end


