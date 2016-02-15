%% dFFtrialAVG %%
t1 = Bhead(18,:);%AItrig timing
t2 = t1 + Bhead(16,:)+Bhead(24,:)/1024/75; %Stim ON timing
s = size(Bhead);
t_ai = zeros(1,s(2));%Rec range
%t_stim = zeros(1,s(2));%Rec range
for nn = 1:s(2)
    t_ai(1,nn) =find(FVt <= t1(nn),1,'last');
    %t_stim(1,nn) = find(FVt <= t2(nn),1,'last');
end

dFFcut = zeros(max(diff(t_ai)),s(2)-1,ROIns); %<- 50 ‚Í“K“–‚É‚Â‚¯‚½‚Ì‚Å’¼‚µ‚½‚¢
for n3 = 1:ROIns
    for n4 = 1:s(2)-1
        if n4 > 1
            X = t_ai(n4)+1:t_ai(n4 + 1);
            dFFcut(X-t_ai(n4),n4,n3) = dFF(X, n3);
        elseif n4 == 1;
            X = t_ai(1):t_ai(2);
            dFFcut(X,1,n3) = dFF(X,n3);
        end
    end
end

