% Variables (excl. last observation)
%    The demoninator is discounted future value from last period. 
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
X = [cons ret' d'  ret_d'];

% Basu Coefficient
basu97 = regress(ear', X);

[basu, basu_interval] = regress(ear', [cons ret' ret_d']);
