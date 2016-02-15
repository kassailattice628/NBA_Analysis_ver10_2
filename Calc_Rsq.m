function Rsq = Calc_Rsq(data,residual)
%
% calculation for R_square after fitting
%
SSresidual = sum(residual.^2);
SStotal = (length(data)-1)*var(data);
Rsq = 1 - (SSresidual/SStotal);
disp(Rsq);
