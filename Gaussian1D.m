function Z = Gaussian1D(beta,x)
%
% Gaussian function with rotation.
% beta is a set of gaussian parameters.
% beta = [Amp, x0, x_sd1, Amp2, x_sd2];
% x is input vector
% phi is 0 in default

b1 = beta(1);%Amp
b2 = beta(2);%x0
%b2 = 0;
b3 = beta(3);%x_sd

if length(beta) == 3
    Z = b1*(exp(- ((x-b2).^2) / (2*(b3)^2)));
elseif length(beta) == 4
    b4 = beta(4);
    Z = b1*(exp(- ((x-b2).^2) / (2*(b3)^2)))+b4;
else
    b4 = beta(4);%Amp2
    b5 = beta(5);%x_sd2(maginfication factor)
    Z = b1*(exp( (- ((x-b2).^2) / (2*(b3)^2)))) - b4*(exp( (- ((x-b2).^2) / (2*(b5*b3)^2))));
end