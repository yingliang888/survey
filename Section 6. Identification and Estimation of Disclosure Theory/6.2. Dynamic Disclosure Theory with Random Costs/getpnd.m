function [pnd] = getpnd(p,alpha,beta,sigma_x)
%GETPND Summary of this function goes here
%   Detailed explanation goes here
% Input: 
%     (1) p:        probability of no endowment. 
%     (2) alpha:    the weight that a manager places on the firm's price.
%     (3) beta: fixed disclosure preference. can be positive or negative. 
%     (4) sigma_x:  std in manager's private information.

% Output: Price of non-disclosure.

F = @(x) normcdf(x);
f = @(x) normpdf(x);
% Lemma 2 (Equation (16)) in BMM. 
fun = @(y) (y - (1-p)./p.*integral(@(x) x.*...
    F(-alpha.*x - beta)*f((x+y)./sigma_x),-inf, inf) )^2;

pnd = @(p) fminsearch(@(y) fun(y,p,alpha, beta,sigma_x),0.4);

pnd = min(0,pnd);
end

