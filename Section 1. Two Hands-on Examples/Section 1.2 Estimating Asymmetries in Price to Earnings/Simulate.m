
%%%%%%%%%% set up space %%%%%%%%%% 
Z_path = zeros(1,num_simulations);
z = zeros(1,num_simulations);
K_path = zeros(1,num_simulations);
K = zeros(1,num_simulations);   
value = zeros(1,num_simulations);
earnings = zeros(1,num_simulations);
cfo = zeros(1,num_simulations); %CFO
I = zeros(1,num_simulations);
a_cost = zeros(1,num_simulations);
s = zeros(1,num_simulations); %unexpected earnings.
    
% Starting
    Z_path(1) = z0;
    K_path(1) = k0;
    
% Path
    for j=2:num_simulations
        % Shock evolution
        Z_path(j) = min(sum(rand>cumsum(z_prob_mat(:,Z_path(j-1))))+1,100);
        z(j-1) = z_vec(Z_path(j-1));
        
        % Capital evolution
        K_path(j) = policy(Z_path(j-1), K_path(j-1));
        K(j-1) = k_grid(K_path(j-1));
        
        % Investment
        I(j-1) = k_grid(K_path(j))-(1-delta)*K(j-1);
        
        % Revenue
        revenue = z(j-1)*K(j-1)^theta;
        
        % Adjustment cost
        adj_cost = psi*( I(j-1))^2/K(j-1);
        a_cost(j-1) = adj_cost;
        
        % Investment cash flow (negative I)
        inv_cash_flow = (1-delta)*K(j-1)-k_grid(K_path(j));
        
        % Total cash flow
        cash_flow = revenue-adj_cost+inv_cash_flow;
        
        % Earnings (excluding capital investment, incl. depreciation)
        earnings(j-1) = revenue-adj_cost - delta*K(j-1);
 
        % Cash from operations (excluding capital investment, excl. depreciation)
        cfo(j-1) = revenue-adj_cost;
        
        % Earnings surprise (conditional on expected profitability, expected adjustment cost)
        k_next = zeros(length(z_vec), 1);
        
        for l = 1:length(z_vec)
            k_next(l) = k_grid(policy(l,K_path(j-1)));
        end
        
        if j==2
            s(j-1) = NaN;
        else
            s(j-1) = earnings(j-1)-z_prob_mat(:,Z_path(j-2))'*(z_vec'.*(K(j-1).^theta)-(psi*((k_next-(1-delta)*ones(length(z_vec),1)*K(j-1)).^2)./(ones(length(z_vec),1)*K(j-1)))-delta*ones(length(z_vec),1)*K(j-1));
        end
        
        % Value and policy function
        value(j-1) = cash_flow+beta*z_prob_mat(:,Z_path(j-1))'*V_new(:,K_path(j));
        
    end
    
% Drop the burnin period.
Z_path(1:burnin)=[];
z(1:burnin)=[];
K_path(1:burnin)=[];
K(1:burnin)=[];
value(1:burnin)=[];
earnings(1:burnin)=[];
cfo(1:burnin)=[];
I(1:burnin)=[];
a_cost(1:burnin)=[];
s(1:burnin)=[];
