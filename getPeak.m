function y = getPeak(x,n)

y = cell(1,5);

y{1} = find(x(:,n) < 0.05);
y{2} = find(x(:,n) >= 0.05 & x(:,n) < 0.1);
y{3} = find(x(:,n) > 0.1 & x(:,n) < 0.15);
y{4} = find(x(:,n) > 0.15 & x(:,n) < 0.2);
y{5} = find(x(:,n) >= 0.2);