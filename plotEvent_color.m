function y = plotEvent_color(Y, stim)
% fill stimulus timing with colorized in stimulus properties.
%input Y is box size (bottom-left, up-left, up-right, bottom-right)
%input stim is the stim-# in the Bhead

% plotEvent_color([0 1 1 0], 6)

global Bhead;

startT = Bhead(18,:);

%stim start timing
% 最後の項はポジションによる補正（縦位置は1024pixel, 75Hz でずれ）
stim_startT = startT + Bhead(16,:) + Bhead(24,:)/1024/75;
%stim end timing
stim_endT = stim_startT + Bhead(17,:);

stimX = [stim_startT', stim_startT', stim_endT',stim_endT'];

%刺激パラメタの種類
list = unique(Bhead(stim,:));
%刺激パタンの種類の数
list_num = length(list);
color = {[1 0.8 0.8],[1 0.5 0.8],[1 1 0.8],[0.8 1 0.8],[0.8 1 1],[0.8 0.8 1],[0.5 0.8 1 ],[1 0.8 1 ]};
hold on;

i0=length(find(Bhead(4,:)<=0));
for j = 1:list_num
    for i = find(Bhead(4,:)>0 & Bhead(stim,:) == list(j))
        fill(stimX(i,:),Y, color{j},'EdgeColor', 'none')
        text(stim_startT(i),0.05, num2str(i-i0));
        %text(stim_startT(i),0.05, num2str(i));
        hold on;
    end
end
y = stimX(Bhead(4,:)>0,[1 3]);

%%%%
xlim([0 floor(Bhead(18,end)+Bhead(1,end)/1000 + 5)]);
ylabel('Stim Timing');
hold off