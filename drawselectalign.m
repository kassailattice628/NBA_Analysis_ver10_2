SelectAlign;

figure;
plot(t(1:Balignnum(1))-t(alignminp),Balign,'b');
line('XData',[0,0],'YData',[Vmin Vmax],'Color','k','LineWidth',2);
axis([tmin-t(alignminp), tmax-t(alignminp), Vmin, Vmax]);