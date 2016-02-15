function[A1,h1, A2, h2] = SplitData(headlength, splitNum)

[fname, dirname] = uigetfile('*.*');
fid = fopen([dirname, fname], 'r');
[A, count] = fread(fid, inf, 'single');

if A(2) == 0
    datap =0;
else
    datap = A(1)/A(2)*1000;
end

if A(27)==1 %open head +Vdata+Photodata
    i = 2;
elseif A(27) == 2
    i = 0;
elseif A(27) == 3
    i = 1;
end

datalength= headlength + datap*i;
%
AA = A(datalength*(splitNum-1):end);
save 'Asplit' AA;
Aamari = rem(count, datalength);
if Aamari ~= 0;
    A = [A; zeros(datalength - Aamari, 1)];
end
nlength=length(A)/datalength;
A = reshape(A, datalength, nlength);
h = A((1: headlength),:);%Bhead
h1 = h(1:splitNum-1,:);
h2 = h(splitNum:end,:);
A1 = A(1:splitNum-1,:);
A2 = A(splitNum:end,:);