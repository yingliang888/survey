function [zvec, piz] = tauchen(meanz, stdinnov, rho, multiple, znum)

% G. Tauchen (1986) 'Finite State Markov-Chain Approximations to 
% Univariate and Vector Autoregressions' Economics Leters 20: 177-181 
% 
% programmed by Aubhik 31.08.2004, contains numerical integration of normal density to yield distribution.
% translated from Fortran 90 programs of 18.02.2002.
%
% [zvec, piz] = tauchen(meanz, stdinnov, rho, multiple, znum)
%
%               meanz       mean of stochastic process z
%               stdinnov    standard deviation of innovations to z
%               rho         persistence of stochastic process z
%               multiple    numerical parameter that determines bounds as multiples of the standard deviation of z
%               znum        the number of grid points in the discretised space
%               zvec        the discretised space
%               piz         Markov transition matrix on zvec, piz(i,j) = Pr{z' = z(j) | z = z(i)}

% bounds for tauchen grid are multiples of standard deviation of the
% stochastic process.
stdz = stdinnov^2.0;
stdz = stdz/(1.0 - rho^2.0);
stdz = sqrt(stdz);
zlow = meanz - stdz*multiple;
zhigh = meanz + stdz*multiple;
meaninnov = meanz*(1.0 - rho);

% lowerbound and grid size for numerical integration
lowerbound = meaninnov - stdinnov*max(10.0, 2.0*multiple);
gridsize = 10000;

zvec = linspace(zlow, zhigh, znum);
piz = 0.0;

w = (zhigh - zlow)/(znum-1);

% This is equations (3a) and (3b) from Tauchen (1986)

for j = 1:1:znum
	
	z = zvec(1) - rho*zvec(j);
	F1 = normal(z + w/2.0, meaninnov, stdinnov, gridsize, lowerbound);
	piz(j,1) = F1;
	
	for k = 2:1:znum - 1
		z = zvec(k) - rho*zvec(j);
		F1 = normal(z + w/2.0, meaninnov, stdinnov, gridsize, lowerbound);
		F0 = normal(z - w/2.0, meaninnov, stdinnov, gridsize, lowerbound);
		piz(j,k) = F1 - F0;
    end 

	z = zvec(znum) - rho*zvec(j);
	F0 = normal(z - w/2.0, meaninnov, stdinnov, gridsize, lowerbound);
	piz(j,znum) = 1.0 - F0;

end 


function [normal] = normal(upperbound, mean, sd, gridsize, lowerbound)

% width of Darboux Rectangles
increment = (upperbound - lowerbound)/gridsize;

% create left and right vertices for all Darboux rectangles
X0DL = linspace(lowerbound, upperbound - increment, gridsize);
X1DU = linspace(lowerbound + increment, upperbound, gridsize);

% obtain normal density at vertices
F0DL = normaldensity(gridsize, X0DL, mean, sd);
F1DU = normaldensity(gridsize, X1DU, mean, sd);

% Average the function values.
F = (F0DL + F1DU)/2.0;

% weight each one by the width of the rectangle of integration.
normal = sum(F.*increment);

function [densities] = normaldensity(numberofpoints, vectorofpoints, mean, sd)

% From the Matlab version of this program, the reference is apparently 
% page 244, chapter 4 of Bopwerman and O'Connell (1997) Applied Statistics

variance = sd^2.0;
pi = 2.0*asin(1.0);
coefficient = variance*2.0*pi;
coefficient = 1.0/sqrt(coefficient);

% note the vector-valued operations as a scalar, mean, is subtracted from each 
% element of a vector, then this resultant vector is divided by two scalars and
% finally used as a vector of exponents for the exponential function.

transcend = (vectorofpoints - mean).^2.0;
transcend = transcend./variance;
transcend = transcend./2.0;
transcend = -1.0.*transcend;
densities = coefficient*exp(transcend);