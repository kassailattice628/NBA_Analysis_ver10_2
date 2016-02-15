%%%% get_selectROI %%%

selectROI = str2num(get(ui_selectROI, 'string'));
if isempty(get(ui_selectROI,'string'))
    selectROI = 1:size(dFF,2);
end
deselectROI = str2num(get(ui_deselectROI,'string'));

if isempty(get(ui_deselectROI,'string'))
    deselectROI =[];
end

selectROI = setdiff(selectROI, deselectROI);


    