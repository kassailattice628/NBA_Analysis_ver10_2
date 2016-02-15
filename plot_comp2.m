function [diff, diffout] = plot_comp2(ind,indout,yn1n,yn2n,i)

diff = cell(1,6);
diff_mean = zeros(6,1);
diff_std = zeros(6,1);
for n = 1:6
    if i == 1
        I = 1;
    else
        I = n;
    end
    diff{1,n} = comp2(ind{1,n},yn1n,yn2n,I,n);
    diff_mean(n) = mean(diff{1,n});
    diff_std(n) = std(diff{1,n});
end

diffout = cell(1,5);
diffout_mean = zeros(5,1);
diffout_std = zeros(5,1);
for n = 1:5
    if i == 1
        I = 1;
    else
        I = n;
    end
    diffout{1,n} = comp2(indout{1,n},yn1n,yn2n,I,n);
    diffout_mean(n) = mean(diffout{1,n});
    diffout_std(n) = std(diffout{1,n});
end

figure;
for n = 1:6
    if isempty(diff{1,n})
    else
        if n ==1
            plot(n,diff{1,n},'b.');hold on
        else
            plot(n,diff{1,n},'b.');hold on
            if isempty(diffout{1,n-1})
            else
                plot(n+0.2, diffout{1,n-1}, 'r*')
            end
        end
    end
end
x_ = 1:6;
x_out = 2:6;
errorbar(x_+0.1, diff_mean, diff_std);
errorbar(x_out+0.3, diffout_mean, diffout_std,'r');
hold off