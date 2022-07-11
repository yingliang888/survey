function [moms] = moments(earnings,value,cfo,I)
%MOMENTS Summary of this function goes here
% This function calculates the Basu regression coefficients.
%    

ear = earnings(2:end-1)./(value(1:end-2)-cfo(1:end-2)+I(1:end-2));
ret = ((value(2:end-1)-cfo(2:end-1)+I(2:end-1))-(value(1:end-2)-cfo(1:end-2)+I(1:end-2)))./(value(1:end-2)-cfo(1:end-2)+I(1:end-2));

% Truncation
l_ear = quantile(ear, [0.01, 0.99]);

for i = 1:length(ear)
    if ear(i) <= l_ear(1) || ear(i) >= l_ear(2)
        ear(i) = NaN;
    end
end

for i = 1:length(ret)
    if ret(i) < -1 || ret(i) > 1
        ret(i) = NaN;
    end
end


%%% Basu Coefficient

% Covariate Matrix
d = (ret<0);
ret_d = ret.*d;
cons = ones(length(d), 1);        
X = [cons ret' ret_d'];

% Basu Coefficient
basu = regress(ear', X);

% store coefficients for ret and ret_d.
moms = basu(2:3);

end

