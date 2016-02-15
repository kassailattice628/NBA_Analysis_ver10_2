%%% Offset dFF %%%

F0 = mean(dFF(1:F0_end_frame,:));
[ncol, nrow] = size(dFF);
dFFoff = zeros(ncol, nrow);
for i = 1:nrow
    dFFoff(:,i) = dFF(:,i) - F0(i);
end
dFF = dFFoff;
