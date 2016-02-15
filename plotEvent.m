function y = plotEvent(Y)
global Bhead;
%start timing
stimon = find(Bhead(4,:) >0);

startT = Bhead(18,stimon);
%endT = startT + Bhead(1,stimon)/1000;

%stim start timing, 1024て何だっけ？ <- monitor 縦pixelサイズ
stim_startT = startT + Bhead(16,stimon) + Bhead(24,stimon)/1024/75;
%stim end timing
stim_endT = stim_startT + Bhead(17,stimon);

%T = 0:10^(-4):Bhead(1,1)*nlength;
%recX = [startT',startT',endT',endT'];
stimX = [stim_startT', stim_startT', stim_endT',stim_endT'];
%Y = [0 1 1 0];
hold on
for i = 1: length(stimon)
    %fill(recX(i,:),Y,'r');
    %fill(recX(i,:),Y,[0.8 0.8 0.8]);
    %fill(stimX(i,:),Y, 'b')
    fill(stimX(i,:),Y, [0.8 0.8 0.8],'EdgeColor', 'none')
end
y = stimX(:,[1 3]);
%blank 部分を別の色で
%{ 
stimprev = find(Bhead(4,:)<=0);
startTprev = Bhead(17,stimprev);
endTprev = startTprev + Bhead(1,stimprev)/1000;
recXprev = [startTprev',startTprev',endTprev',endTprev'];

for i = 1: length(stimprev)
    fill(recXprev(i,:),Y,'r');
end
%}

%%%%
xlim([0 floor(Bhead(18,end)+Bhead(1,end)/1000 + 5)]);
%title('Recording and Stimulus Timing');
%xlabel('Time (sec)');
ylabel('Stim Timing');
hold off