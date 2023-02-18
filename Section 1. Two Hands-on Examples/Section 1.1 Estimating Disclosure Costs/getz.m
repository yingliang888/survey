function output=getz(p,c)
% FUNCTION SUMMARY
% function plots normalized threshold Z(p) threshold

% INPUT: p (prob. of no info. endowment)

F=@(x) normcdf(x);
fun = @(t,p,c) (integral(@(x)F(x),-inf,t) + p/(1-p)*(t-c))^2;
    

z=@(p,c) fminsearch(@(t)fun(t,p,c),0.1);
output=z(p,c);


output=min(0,output);

end












