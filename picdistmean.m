function mesd = picdistmean(r_pol,diff,i)
%r_pol = r_pol1;
%diff = diff1;
%i = i1; <- 応答中心1からの距離が100um以内のもの
%int = 50;
%0-400μmの間をintで区切るので
%mesd = zeros(400/int,2);

%r1応答中心からSD以内のもの
%さらに r2応答中心からの距離を SDでノーマライズしたものを使う．
int = 0.25;
%6SDまでみてる
mesd = zeros(6/int,2);
if isempty(i)
    ra = r_pol(:,2:end);
    dd = diff(:,2:end-1);
else
    ra = r_pol(i,2:end);
    dd = diff(i,2:end-1);
end

for n = 1:size(mesd,1)
    l = (n-1)*int;
    u = l +int;
    mesd(n,1) = mean(dd(l <= ra & ra<u));
    mesd(n,2) = std(dd(l <= ra & ra<u));
    ttest(dd(l <= ra & ra<u))
end