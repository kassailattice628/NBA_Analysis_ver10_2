%%%% DataExtract %%%%

n=1;
[fname,dirname] = uigetfile('*.*');
fid = fopen([dirname,fname], 'r');
[A,count] = fread(fid,inf,'single');

% *** ‚Í ‚¢‚ç‚È‚¢‚Æ‚±‚±‚Ü‚Å*21+1
% A2 = A(***:end);

%%
[fname,dirname] = uiputfile('*.*');
pat = regexptranslate('wildcard', '.*');
if fname ~= 0
    fname = regexprep(fname, pat,'');
end
fid = fopen([dirname,fname], 'w');
fwrite(fid,A2,'single');
flose(fid);

