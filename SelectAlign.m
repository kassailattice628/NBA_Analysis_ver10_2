%%% select align %%%
alignt = (Bhead(16,selectdraw)+Bhead(24,selectdraw)/1024/75)*1000;
%alignt = Bhead(16,selectdraw)*1000;

selectnum = length(selectdraw);
alignp = zeros(1,length(selectnum));
for m = 1:selectnum
alignp(m) = find((t >= alignt(m)),1);
end

alignmaxp = max(alignp);
alignminp = min(alignp);
Balign = zeros(datap-(alignmaxp-alignminp),selectnum);
Balignnum = size(Balign);

%alignminp ‚ğŠî€‚É‚µ‚æ‚¤
for m = 1:selectnum;
    Balign(:,m) = B1(((alignp(m)-alignminp+1):(datap-(alignmaxp-alignp(m)))),selectdraw(m));
end