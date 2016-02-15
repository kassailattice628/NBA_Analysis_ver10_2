%%%%hget unit mat
%Bmat ÇçÏÇ¡Çƒ

clear hspikes;

Bmat = B1(:,(selectdraw));
v2ff=Bmat;
selectno = length(selectdraw);
hspikes = cell(1,selectno);

%{
for m = 1:selectno
    v2fB = zeros((length(Bmat)-1),1);  % Binary box for v2f(v2fB)
    for k=1:length(Bmat)-1
        if  v2ff(k,m)<spDparams(1) && v2ff((k+1),m)>spDparams(1)    % use only threshold
            % if  v2ff(k)<spDparams(1) & v2ff(k+1)>spDparams(1) & (v2ff(k+1)-v2ff(k))>spDparams(3) % use threshold and slope threshold
            v2fB(k)=(spDparams(1)-Bmat(k,m))/(Bmat((k+1),m)-Bmat(k,m))+k;
            v2fB(k+1:k+round(spDparams(2)*fs/1000))=0;     % make refractory period
        end
    end
    lpv3 =find(v2fB>0); %pi
    lpv4=lpv3*1000/fs; % in [ms] timing
    % draw threshold point in figure
    hspikes{1,m}=lpv4;
end

%}
for m = 1:selectno
    
    v2fB = zeros((length(Bmat)-1),1);  % Binary box for v2f(v2fB)
    k = 1;
    while k < length(v2ff)
        if v2ff(k,m)<spDparams(1) && v2ff(k+1,m)>spDparams(1) && (v2ff(k+1,m)-v2ff(k,m))/(1/fs) >spDparams(2)
            v2fB(k) = 1;
            k = k + 1 + round(spDparams(3)/1000*fs);% skip check during refractory period.
        else
            k = k+1;%check next point
        end
    end
    lpv3 = find(v2fB>0); %pi
    lpv4=lpv3*1000/fs; % in [ms] timing
    hspikes{1,m}=lpv4;
end




histogramplot;

