%%% ch_plot %%%
switch get(ui_plot,'value')
    case 0
        set(ui_plot, 'string', 'V-plot')
        set(ui_axis_auto, 'string', 'V-auto')
        B1 = Bv;
        B2 = Bi;
        ylabel(s1,'mV');
        ylabel(s2,'nA');
        set(p1, 'color', 'blue')
        set(p2, 'color', 'red')
    case 1
        set(ui_plot, 'string', 'I-plot')
        set(ui_axis_auto, 'string', 'I-auto')
        B1 = Bi;
        B2 = Bv;
        ylabel(s1,'nA');
        ylabel(s2,'mV');
        set(p1, 'color', 'r')
        set(p2, 'color', 'b')
end
plotdata2