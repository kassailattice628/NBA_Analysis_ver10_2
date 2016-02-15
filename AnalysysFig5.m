x = -500:0.1:500;

b_ex = [1, 0, 70];
b_in = [0.3, 0, 70*3];

Z_ex = Gaussian1D(b_ex,x);
Z_in = Gaussian1D(b_in,x);
Z = Z_ex - Z_in;



figure;
plot(x, Z_ex, 'r-');
hold on 
plot(x, Z_in, 'b-');
plot(x, Z, 'g-');
%line([-500,500],[0,0]);
hold off;

%%

b_sub = [1, 0, 70, 0.3, 3];
Z_sub = Gaussian1D(b_sub, x);

figure;
plot(x, Z_sub);
line([-500,500],[0,0]);
%%
num =9;
Z_sub_mat = zeros(length(x),num);
b_o = linspace(-340,340,num);

for n = 1:num
    b = [1,b_o(n),80,0.3,3];
    Z_sub_mat(:,n) = Gaussian1D(b,x);
end
Z_sum = sum(Z_sub_mat,2);

figure;
plot(x,Z_sub_mat, 'b-')
hold on
plot(x,Z_sum, 'r-');

c = (num+1)/2-1:(num+1)/2+1;
Z_diff = Z_sum - sum(Z_sub_mat(:,c),2);
figure;
plot(x, Z_sum, 'k-');
hold on
plot(x, Z_sub_mat(:,(num+1)/2),'k-');
plot(x, Z_diff, 'r-');

%%
x = -1000:0.1:1000;
num =5;
Z_sub_mat = zeros(length(x),num);
b_o = linspace(-340,340,num);

for n = 1:num
    b = [1,b_o(n),100,0.3,3];
    Z_sub_mat(:,n) = Gaussian1D(b,x);
end
Z_sum = sum(Z_sub_mat,2);



%c = (num+1)/2-1:(num+1)/2+1;
c = (num+1)/2;
Z_diff = Z_sum - sum(Z_sub_mat(:,c),2);
figure;
plot(x, Z_sum, 'b-');
hold on
plot(x,Z_sub_mat, 'k-')
plot(x, Z_sub_mat(:,(num+1)/2),'r-');
plot(x, Z_diff, 'g-');



