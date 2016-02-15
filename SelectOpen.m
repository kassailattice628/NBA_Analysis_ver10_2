function [y1, y2v, y2i ,y3, datap, f,d] = SelectOpen(headlength,dirname)
%global dirname
%[Bhead, Bvoltage, ,Bcurrent, Bphoto, datap, fname, dirname] = SelectOpen(headlength,dirname);
%%% select open file %%%

if exist('dirname', 'var') == 0
    [f,d] = uigetfile('*.*');
else
    %[fname, dirname] = uigetfile([dirname,'*.*']);
    [f,d] = uigetfile([dirname,'*.*']);
end

if f == 0
    y1 = 0;
    y2v = 0;
    y2i = 0;
    y3 = 0;
    datap = 0;
    return;
end
fid = fopen([d,f], 'r');
[A, count] = fread(fid, inf, 'single');

if A(2) == 0
    datap =0;
else
    datap = A(1)/A(2)*1000;
end

if A(27)==1 %open head +Vdata+ +Idata + Photodata
    i = 3;
elseif A(27) == 2 %header only 
    i = 0;
elseif A(27) == 3 % Header + Photo
    i = 1;
end

if A(50) == 0 %HEADER��50�m�ہi�g���؂����ꍇ�ɂ͗v�ύX�j
    headlength = 50;
end % header �����Ȃ��Ƃ��́C�����ݒ�� headerlength ���g�p
datalength= headlength + datap*i;
Aamari = rem(count, datalength);
if Aamari ~= 0;
    A = [A; zeros(datalength - Aamari, 1)];
end
nlength=length(A)/datalength;
A = reshape(A, datalength, nlength);
y1 = A((1: headlength),:);%Bhead

if A(27)== 1 %open all data
    Vrow = headlength+1:(headlength+datap);
    Irow = (headlength+1+datap):(headlength+datap*2);
    Prow = (headlength+datap*2+1):(headlength+datap*3);
    y2v = A(Vrow,:); %Bv
    y2i = A(Irow,:); %Bi
    y3 = A(Prow,:); % Bp
    clear A;
    clear Vrow;
    clear Irow;
    clear Prow;
elseif A(27) == 2 % open header file only
    y2v = [];
    y2i = [];
    y3 = [];
elseif  A(27) == 3 %open header and photo
    Prow = headlength+1:(headlength+datap);
    y2v = [];
    y2i = [];
    y3 = A(Prow,:); %photo
    clear A;
    clear Prow;
end





