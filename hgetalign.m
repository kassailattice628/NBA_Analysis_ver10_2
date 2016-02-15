%%%%hget unit mat
%Bmat ÇçÏÇ¡Çƒ


clear hspikes;

alignt = Bhead(16,selectdraw)*1000;
selectnum = length(selectdraw);
alignp = zeros(1,length(selectnum));
for m = 1:selectnum
alignp(m) = find((t >= alignt(m)),1);
end

alignmaxp = max(alignp);
alignminp = min(alignp);

Balign = zeros(datap-(alignmaxp-alignminp),selectnum);
Balignnum = size(Balign);
%%
%alignminp ÇäÓèÄÇ…ÇµÇÊÇ§
for m = 1:selectnum
    Balign(:,m) = B1(((alignp(m)-alignminp+1):(datap-(alignmaxp-alignp(m)))),m);
end


selectno = length(selectdraw);
Bmat = Balign;
v2ff=Bmat;
hspikes = cell(1,selectno);

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
hold on
xal = floor(t(alignminp));
line('xdata',[xal xal],'ydata',[0 500],'color','r','LineWidth',2);
hold off
