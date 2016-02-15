function varargout = testfunc(varargin)

% tableplot.m -- Programmatic main function to set up a GUI
%                containing a uitable and an axes which
%                displays columns of the table as lines,
%                plus markers that show table selections.
%
% The following callbacks are also provided, as subfunctions:
%    plot1_callback   - Plot column selected on menu as line
%    select_callback  - Plot selected table data as markers
%  Being subfunctions, they do not need handles passed to them.
%
%

% Create a figure that will have a uitable, axes and checkboxes
figure('Position', [100, 300, 600, 460],...
    'Name', 'testfunc',...  % Title figure
    'NumberTitle', 'off',... % Do not show figure number
    'MenuBar', 'none');      % Hide standard menu bar menus



global prm
%define params
prm.headlength = 50;
prm.selectdraw = 1;
prm.selectno = 1;
prm.n=1;
prm.binms = 1;
prm.f_siv=1;
prm.spDparams=[100 2 0]; %Spike detection parameter
prm.insv =[];
prm.vmin = -50;
prm.vmax = 50;
prm.tmin = 0;
prm.tmax = [];
prm.savefname =[];
prm.cutf_low = 100;
prm.cutf_high = 1000;
prm.OrderN = 2;
Bfilt = [];

prm.fname =[];
prm.dirname =[];
prm.fname2 = [];
prm.dirname2 =[];

%openTaableì‡ïœêî
prm.FVsampt = 0.574616;
prm.F0_end_frame = 15;
prm.stim_color = 6;
prm.interp_times = 10;

openfile;
%{
% Create an axes on the right side; set x and y limits to the
% table value extremes, and format labels for the demo data.
haxes = axes('Units', 'normalized',...
             'Position', [.465 .065 .50 .85],...
             'XLim', [0 tablesize(1)],...
             'YLim', [0 max(max(count))],...
             'XLimMode', 'manual',...
             'YLimMode', 'manual',...
             'XTickLabel',...
             {'12 AM','5 AM','10 AM','3 PM','8 PM'});
title(haxes, 'Hourly Traffic Counts')   % Describe data set
% Prevent axes from clearing when new lines or markers are plotted
hold(haxes, 'all')

% Create an invisible marker plot of the data and save handles
% to the lineseries objects; use this to simulate data brushing.
hmkrs = plot(count, 'LineStyle', 'none',...
                    'Marker', 'o',...
                    'MarkerFaceColor', 'y',...
                    'HandleVisibility', 'off',...
                    'Visible', 'off');

% Create an advisory message (prompt) in the plot area;
% it will vanish once anything is plotted in the axes.
axpos = get(haxes, 'Position');
ptpos = axpos(1) + .1*axpos(3);
ptpos(2) = axpos(2) + axpos(4)/2;
ptpos(3) = .4; ptpos(4) = .035;
hprompt = uicontrol('Style', 'text',...
                    'Units', 'normalized',...
                    'Position', ptpos,... % [.45 .95 .3 .035],...
                    'String',...
                      'Use Plot check boxes to graph columns',...
                    'FontWeight', 'bold',...
                    'ForegroundColor', [1 .8 .8],...
                    'BackgroundColor', 'w');

% Create three check boxes to toggle plots for columns
uicontrol('Style', 'checkbox',...
          'Units', 'normalized',...
          'Position', [.10 .96 .09 .035],...
          'TooltipString', 'Check to plot column 1',...
          'String', 'Col 1',...
          'Value', 0,...
          'Callback', {@plot_callback,1});
uicontrol('Style', 'checkbox',...
          'Units', 'normalized',...
          'Position', [.20 .96 .09 .035],...
          'TooltipString', 'Check to plot column 2',...
          'String', 'Col 2',...
          'Value', 0,...
          'Callback', {@plot_callback,2});
uicontrol('Style', 'checkbox',...
          'Units', 'normalized',...
          'Position', [.30 .96 .09 .035],...
          'TooltipString', 'Check to plot column 3',...
          'String', 'Col 3',...
          'Value', 0,...
          'Callback', {@plot_callback,3});

% Create a text label to say what the checkboxes do
uicontrol('Style', 'text',...
          'Units', 'normalized',...
          'Position', [.025 .955 .06 .035],...
          'String', 'Plot',...
          'FontWeight', 'bold');
               
% Subfuntions implementing the two callbacks
% ------------------------------------------

function plot_callback(hObject, eventdata, column)
    % hObject     Handle to Plot menu
    % eventdata   Not used
    % column      Number of column to plot or clear

    colors = {'b','m','r'}; % Use consistent color for lines
    colnames = get(htable, 'ColumnName');
    colname = colnames{column};
    if get(hObject, 'Value')
        % Turn off the advisory text; it never comes back
        set(hprompt, 'Visible', 'off')
        % Obtain the data for that column
        ydata = get(htable, 'Data');
        set(haxes, 'NextPlot', 'Add')
        % Draw the line plot for column
        plot(haxes, ydata(:,column),...
            'DisplayName', colname,...
            'Color', colors{column});
    else % Adding a line to the plot
        % Find the lineseries object and delete it
        delete(findobj(haxes, 'DisplayName', colname))
    end
    end


function select_callback(hObject, eventdata)
    % hObject    Handle to uitable1 (see GCBO)
    % eventdata  Currently selected table indices
    % Callback to erase and replot markers, showing only those
    % corresponding to user-selected cells in table.
    % Repeatedly called while user drags across cells of the uitable

        % hmkrs are handles to lines having markers only
        set(hmkrs, 'Visible', 'off') % turn them off to begin
        
        % Get the list of currently selected table cells
        sel = eventdata.Indices;     % Get selection indices (row, col)
                                     % Noncontiguous selections are ok
        selcols = unique(sel(:,2));  % Get all selected data col IDs
        table = get(hObject,'Data'); % Get copy of uitable data
        
        % Get vectors of x,y values for each column in the selection;
        for idx = 1:numel(selcols)
            col = selcols(idx);
            xvals = sel(:,1);
            xvals(sel(:,2) ~= col) = [];
            yvals = table(xvals, col)';
            % Create Z-vals = 1 in order to plot markers above lines
            zvals = col*ones(size(xvals));
            % Plot markers for xvals and yvals using a line object
            set(hmkrs(col), 'Visible', 'on',...
                            'XData', xvals,...
                            'YData', yvals,...
                            'ZData', zvals)
        end
    end


%}
    function openfile
        %%openfile%%
        issub = exist('subEvent','var');
        if issub ==1
            delete(subEvent);
            delete(subROI);
            %delete(subTraces);
        end
        f_open = 1;%open file style
        n=1;
        global Bhead
        %global dirname
        [Bhead, Bv, Bi, Bp, datap, prm.fname, prm.dirname] = SelectOpen(prm.headlength,prm.dirname);
        
        if prm.fname == 0
            prm.fname =[];
            prm.dirnme =[];
            %clear dirname;
            subEvent = subplot('position',[0.3 0.5 0.45 0.15]);
            subROI = subplot('position',[0.3 0.05 0.45 0.4]);
        else
            B = Bp;
            
            
            %readheader;
            
            t = 0:Bhead(2,1)/1000:Bhead(1,1)-Bhead(2,1)/1000; %ms
            tmax = t(end);
            set(prm.ui_tmax,'string',tmax);
            
            detectsp;
            ui_dtsp = uicontrol( 'style','edit','string',insv,'position', [450 770 650 25],'callback','insv=str2num(get(ui_dtsp,''string''))', 'BackGroundColor',[1 1 1], 'fontsize', 10);
            uicontrol( 'position',[450 795 120 25],'String','Detected Spikes', 'Style','text', 'fontsize', 10);
            set(ui_dtsp,'string',num2str(insv));
            
            nlength = length(Bhead(1,:));%ÉgÉåÅ[ÉXêî
            
            s1 = subplot('position', [0.3 0.58 0.45 0.3]);
            p1 = plot(t,B(:,n),'b','erasemode','normal');
            zoom on;
            
            hold on;
            p1s = plot(lpv4,B(lpv3,n),'m*');
            if Bhead(5,n) == 1
                p1flash = line('XData',[Bhead(16,n),Bhead(16,n)]*1000,'YData',[vmin vmax],'Color','r','LineWidth',1);
                p1correct = line('XData',[flash_correct, flash_correct]*1000, 'YData',[vmin vmax],'Color','g','LineWidth',1);
            elseif Bhead(5,n) == 0
                p1flash = line('XData',[0 0],'YData',[min(B(:,n)),min(B(:,n))],'Color','r','LineWidth',1);
                p1correct = line('XData',[0 0],'YData',[min(B(:,n)),min(B(:,n))],'Color','g','LineWidth',1);
            end
            hold off
            
            ylim([prm.vmin prm.vmax]);
            %title({['S.Dura=',stimduration, ', S.col=',stimcol,', BGcol= ',bgcol,', S.pattern= ',stimpattern, ', Size= ', stimszx, ' x ', stimszy],['MonitorDivide= ', divnum, ', Position= ', position, ', S.delay= ', PTBdelay, ' ms'],['n=', num2str(n)]});
            title({'V-DATA',['n=', num2str(n)]});
            %xlabel('Time (ms)');
            ylabel('V Data (mV)');
            
            if isempty(Bp)
                p1s =[];
                s2 =[];
            else
                s2 = subplot('position', [0.3 0.45 0.45 0.1]);
                p2 = plot(t,Bp(:,n),'g');
                %title('S-DATA');
                xlabel('Time (ms)');
                ylabel('Sensor (mV)');
            end
            
            %s1 = subplot('position', [0.3 0.58 0.45 0.3]);
            %s2 = subplot('position', [0.3 0.45 0.45 0.1]);
            
            subEvent = subplot('position',[0.3,0.35, 0.45, 0.05]);
            
            subROI = subplot('position',[0.3,0.05,0.45, 0.23]);
            
            %subTraces = subplot('position',[0.3 0.05,0.45, 0.13]);
            
        end
    end

end