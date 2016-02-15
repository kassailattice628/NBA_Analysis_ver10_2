%%SplitData2%%
splitNum = input('Split Num?:::>>> ','s');
splitNum = str2double(splitNum);
whichPart = input('First half(1) or Latter half (2)?:::>>> ');
while ismember(whichPart,[1,2]) == 0
    disp('Invalid numbers!!');
    whichPart = input('First half(1) or Latter half (2)?:::>>> ');
end

if whichPart == 1
    Bhead = Bhead(:, 1:splitNum);
    B = B(:, 1:splitNum);
elseif whichPart == 2
    Bhead = Bhead(:,splitNum:end);
    B = B(:,splitNum:end);
end

delete(subEvent);
delete(subROI);
n=1;
Bv = B;

readheader;

t = 0:Bhead(2,1)/1000:Bhead(1,1)-Bhead(2,1)/1000; %ms
tmax = t(end);
set(ui_tmax,'string',tmax);

nlength = length(Bhead(1,:));

s1 = subplot('position', [0.3 0.7 0.45 0.25]);
p1 = plot(t,B(:,n),'m','erasemode','normal');
zoom on;
p1s =[];
s2 =[];

vmin = -1;
vmax = 5;
set(ui_vmin,'string', vmin);
set(ui_vmax, 'string',vmax);

if Bhead(5,n) == 1
    p1flash = line('XData',[Bhead(16,n),Bhead(16,n)]*1000,'YData',[vmin vmax],'Color','r','LineWidth',1);
    p1correct = line('XData',[flash_correct, flash_correct]*1000, 'YData',[vmin vmax],'Color','g','LineWidth',1);
elseif Bhead(5,n) == 0
    p1flash = line('XData',[0 0],'YData',[min(B(:,n)),min(B(:,n))],'Color','r','LineWidth',1);
    p1correct = line('XData',[0 0],'YData',[min(B(:,n)),min(B(:,n))],'Color','g','LineWidth',1);
end
hold off
ylim([vmin vmax]);

title({'S-DATA',['n=', num2str(n)]});
xlabel('Time (ms)');
ylabel('V Data (mV)');

subEvent = subplot('position',[0.3 0.5 0.45 0.15]);
subROI = subplot('position',[0.3 0.05 0.45 0.4]);

%%%%
openTable;

AA = vertcat(Bhead,B);
AA = reshape(AA, [],1);
fid = fopen('Asplit', 'w'); % Open or Create file(fname) as an 'append' mode.
fwrite(fid,AA,'single');
fclose(fid);
clear AA;

