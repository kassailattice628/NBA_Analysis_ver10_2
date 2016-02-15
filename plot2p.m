function [diff,r_pol_n,index,i_near] = plot2p(yn2, ROI_Polar,OGB,b_fit)
%
%
%
%r1応答中心から 1SD 以内のニューロンを取り出す
dist_set = b_fit(1,3);

%2SDだと
%dist_set = b_fit(1,3)*2;

r_pol = zeros(size(ROI_Polar,1),6);
diff = r_pol;
dist = r_pol;
for n = 1:6
    r_pol(:,n) = ROI_Polar(:,2,n);
    %dist(:,n) = r_pol(:,n) - r_pol(:,1);
    dist(:,n) = r_pol(:,n);
    diff(:,n) = yn2(:,n) - yn2(:,1);
end

ind1 = find(r_pol(:,1)< dist_set);
index = intersect(OGB,ind1);%r1から dist_set以内のニューロンのID
num_i = size(index,2);


col = cell(1,5);
col{1} = 'b.';
col{2} = 'c.';
col{3} = 'g.';
col{4} = 'y.';
col{5} = 'r.';

%figure;hold on
r_pol_n = dist;
for n = 2:6
    r_pol_n(:,n) = dist(:,n)/b_fit(n,3); 
    %r_pol_n(:,n) = dist(:,n);
    plot(r_pol_n(index,n), diff(index,n),col{n-1})
end

i_sort = zeros(num_i,5);
i_near = zeros(round(num_i/3),5);
%距離が近い順に並べて
for n = 2:6
    [~,i_sort(:,n-1)]= sort(r_pol(index,n));
    i_near(:,n-1) = index(i_sort(1:round(num_i/3),n-1));
    %i_near(:,n-1) = index(i_sort(55:81,n-1));
end
%{
%near 1/3
for n = 2:6
    plot(dist(i_near,n), diff(i_near,n),col{n-1})
end
%}
%line([-150,380],[0,0])
%line([0,0],[-0.15,0.25])
