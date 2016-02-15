function Z = diffExp(beta,x)
%
% Exponentially decaying function
% beta is a set of parameters.
% beta = [Amp0, tau0, Amp1, tau1)

b1 = beta(1);
b2 = beta(2);
b3 = beta(3);
b4 = beta(4);

Z = b1*exp(-x/b2) - b3*exp(-x/b4);
%Z = (b1*(exp( (- (x).^2) / (2*(b2)^2)))).^2 - b3*(exp( (- (x).^2) / (2*(b4)^2)));