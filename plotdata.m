%% plotdata %%

readheader;
if Bhead(27,1) == 1
    detectsp;
    %%%波形データを描画！%%%
    %抽出したspike timing の値を，figure2に表示したい
    set(ui_dtsp,'string',num2str(insv));
end

subplot(s1);
set(p1,  'xdata', t,'ydata', B(:,n));
%set(gca,'title',text('string',{['S.Dura=',stimduration, ', S.col=',stimcol,', BGcol= ',bgcol,', S.pattern= ',stimpattern, ', Size= ', stimszx, ' x ', stimszy]...
%    ['MonitorDivide= ', divnum, ', Position= ', position, ', S.delay= ', PTBdelay, ' ms'],['n=', num2str(n)]}));
if get(ui_v_auto,'value') == 1
    Vmin = min(B(:,n));
    Vmax = max(B(:,n));
else
    Vmin = vmin;
    Vmax = vmax;
end

if f_open == 1%open all
    set(gca,'title',text('string',{'V-DATA',['n=', num2str(n)]}));
    if isempty(p1s)
        subplot(s1);
        hold on
        p1s = plot(lpv4,B(lpv3,n),'m*');
        hold off
    else
        set(p1s, 'xdata',lpv4, 'ydata', B(lpv3,n),'Marker','*', 'Color','m');
    end
elseif f_open == 2%open photo
    
    set(gca,'title',text('string',{'S-DATA',['n=', num2str(n)]}));
    
end

if Bhead(5,n) == 1
    set(p1flash,'xdata',[Bhead(16,n),Bhead(16,n)]*1000,'ydata',[Vmin Vmax]);

    amari = rem(Bhead(9,n),Bhead(8,n));
    if amari == 0
        amari = Bhead(8,n);
    end
    flash_correct = Bhead(16,n)+Bhead(24,n)/1024/75;
    set(p1correct,'xdata',[flash_correct, flash_correct]*1000,'ydata',[Vmin Vmax]);
elseif Bhead(5,n) == 0
    set(p1flash,'xdata',[0 0],'ydata',[min(B(:,n)), min(B(:,n))]);
    set(p1correct,'xdata',[0 0],'ydata',[min(B(:,n)), min(B(:,n))]);
end
axis([tmin tmax Vmin Vmax]);

if isempty(s2)
else
    subplot(s2);
    set(p2, 'xdata', t, 'ydata', Bp(:,n));
    xlim([tmin tmax]);
end

%%% header %%%
set(uiT,'Data',HeadTable);
%{
%total firing rate with sound in [Hz]. Latency is defined as 2 [ms]
spkNtS = length(find(v2fB(round(2*fs/1000):round((Bhead(11,n)+2)*fs/1000))>0))*1000/Bhead(11,n);
%firing rate before sound in [Hz]
%spkNtC= length(find(v2fB(1:round((timebs(2))*fs/1000))>0))*1000/timebs(2);
%if spkNtS*spkNtC == 0
spkNt = 0;
%else
%spkNt = spkNtS/spkNtC;
%end
%spike Number of whole trace
spkN =length(lpv3);
%}