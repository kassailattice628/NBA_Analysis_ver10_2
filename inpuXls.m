function out = inpuXls
if exist('dirname','var') == 0
    [f,d] = uigetfile('*.xls');
else
    [f,d] = uigetfile([dirname,'*.xls']);
end
if f ==0
    return
end

out = dlmread([d,f] ,'\t',1,1);
