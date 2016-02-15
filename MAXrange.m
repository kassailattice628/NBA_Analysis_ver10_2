%stim ÇÃä‘äuÇ≈ãÊêÿÇÈ
clear dFF_
clear dFF1
clear dFF2
clear dFF3
clear dFF4
clear dFF5
clear dFFall

range = floor(Bhead(18,:)/FVsampt);

range_max = zeros(length(selectROI),length(range)-2);
range_norm = range_max;

for i1 = selectROI
    ind = find(selectROI == i1);
        i2_1=1;
        i2_2=1;
        i2_3=1;
        i2_4=1;
        i2_5=1;
        dFF1 =zeros(1,30);
        dFF2 =zeros(1,30);
        dFF3 =zeros(1,30);
        dFF4 =zeros(1,30);
        dFF5 =zeros(1,30);
    for i = 3:length(range)-1
         dFFt = range(i)-2:(range(i)+floor(7/FVsampt));
        if Bhead(6,i) == 10
            dFF1(i2_1,:)=  dFF(dFFt,i1);
            i2_1 = i2_1+1;
        elseif Bhead(6,i) == 20
            dFF2(i2_2,:)=  dFF(dFFt,i1);
            i2_2 = i2_2+1;
        elseif Bhead(6,i) == 60
            dFF3(i2_3,:)=  dFF(dFFt,i1);
            i2_3 = i2_3+1;
        elseif Bhead(6,i) == 99
            dFF4(i2_4,:)=  dFF(dFFt,i1);
            i2_4 = i2_4+1;
        elseif Bhead(6,i) == 200
            dFF5(i2_5,:)=  dFF(dFFt,i1);
            i2_5 = i2_5+1;
        end

        
        %range_max(ind,i-1) =max(dFF(range(i):rang(i)+floor(7/FVsampt),i1));

    end
        dFF1ave  = mean(dFF1);
        dFF2ave  = mean(dFF2);
        dFF3ave  = mean(dFF3);
        dFF4ave  = mean(dFF4);
        dFF5ave  = mean(dFF5);
        dFF_(ind,:) = [dFF1ave, dFF2ave, dFF3ave, dFF4ave, dFF5ave];
    %range_norm(ind,:) = range_max(ind,:)/max(range_max(ind,:));
end

%%

y = dFF_;
for i = 1: length(selectROI)
    y(i,:) = y(i,:) + (0.2*(i-1));
end
figure;
plot(y')