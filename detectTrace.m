function y = detectTrace(mat, threshold)
%mat（行列）の列データが閾値を超えたものの列番号を
%取り出す．

y = [];
for i = 1:size(mat,2)
    if max(mat(:,i)) > threshold
        y = [y, i];
    end
end

%{
%リストをドロップでよみこんで
x = SC******;
y = 1:size(x,1);
y(x(:,5) >= 0.05 & x(:,5) < 0.1);
y(x(:,5) >= 0.1 & x(:,5) < 0.2);
y(x(:,5) >= 0.2 & x(:,5) < 0.3);
y(x(:,5) >= 0.3);
%}