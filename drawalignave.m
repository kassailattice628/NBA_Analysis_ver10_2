%%% draw ligned average %%%
SelectAlign;
%%
Balignave = mean(Balign,2);
figure;
plot(t(1:Balignnum(1))-t(alignminp),Balignave, 'r');
%line('XData',[t(alignminp),t(alignminp)],'YData',[Vmin Vmax],'Color','k','LineWidth',2);
line('XData',[0,0],'YData',[Vmin Vmax],'Color','k','LineWidth',2);
axis([tmin-t(alignminp), tmax-t(alignminp), Vmin, Vmax]);

