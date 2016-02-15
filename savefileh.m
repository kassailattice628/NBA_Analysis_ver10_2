[fname,dirname] = uiputfile('*.*');
savefilenameh=strcat([dirname fname],'_hspikes',fn,'.mat');
save(savefilenameh,'hspikes');
