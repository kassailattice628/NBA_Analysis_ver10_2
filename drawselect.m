figure2 = figure('Color','w');%bar ‚ğ‚Â‚¯‚é‚â‚Â‚Í figure hundle ‚ğ figure3 ‚ÉD

Bmat = B1(:,selectdraw);
plot(t,Bmat,'b'); hold on
%{
hold on
plot(t, Bmat(:,(rem(Bhead(9,selectdraw),7)==1)),'k');
plot(t, Bmat(:,(rem(Bhead(9,selectdraw),7)==2)),'b');
plot(t, Bmat(:,(rem(Bhead(9,selectdraw),7)==3)),'y');
plot(t, Bmat(:,(rem(Bhead(9,selectdraw),7)==4)),'g');
plot(t, Bmat(:,(rem(Bhead(9,selectdraw),7)==5)),'c');
plot(t, Bmat(:,(rem(Bhead(9,selectdraw),7)==6)),'m');
plot(t, Bmat(:,(rem(Bhead(9,selectdraw),7)==0)),'r');
%}
hold off

if get(ui_axis_auto,'value') == 1
    Vmin = min(B1(:,n));
    Vmax = max(B1(:,n));
else
    Vmin = vmin;
    Vmax = vmax;
end
axis([tmin tmax Vmin Vmax]);