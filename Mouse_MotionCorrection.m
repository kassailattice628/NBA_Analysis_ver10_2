function Mouse_MotionCorrection
%This program runs both TurboReg and HMM
%1: TurboReg --> HHM
%2: HMM (compatible with two-channel-format)
%3: Jason's program (GB)

MotionCorrectionProgram = 1;


totalSetNo = 0;
FileNameList = {};
PathNameList = {};
while 1
    %FolderName = 'Y:\BehavioralData\';
    FolderName = 'Y:\Data\';
    [FileName,PathName] = uigetfile({'*.tif', 'Tiff data (*.tif)'}, 'Pick a file', ...
        FolderName, 'MultiSelect', 'on');

    if ~isequal(FileName,0) %Nothing selected
        totalSetNo = totalSetNo + 1;
        if ~iscell(FileName)
            FileNameList{totalSetNo}{1} = FileName;
            PathNameList{totalSetNo} = PathName;
        else
            FileNameList{totalSetNo} = FileName;
            PathNameList{totalSetNo} = PathName;
        end
    else
        break;
    end
end


disp(['Motion Correction: ', int2str(totalSetNo), ' sets of files.']);

for setno = 1:totalSetNo
    mkdir([PathNameList{setno} filesep 'TurboRegImage']);
    mkdir([PathNameList{setno} filesep 'matdata' filesep]);
    mkdir([PathNameList{setno} filesep 'HMMImage' filesep]);
    mkdir([PathNameList{setno} filesep 'GBImage' filesep]);





    sessionreferencefilename = [PathNameList{setno}, FileNameList{setno}{1}];
    %get the target image for TurboReg Analysis
    state = g_getSIstate(sessionreferencefilename);
    ImageMatrix = g_getimage(sessionreferencefilename, state, 1, [], 1:state.acq.numberOfChannelsSave, 0, 50);
    turboregrefimage = mean(ImageMatrix{1}, 3);
    HMMrefimage = [];

    FileNameList{setno} = sort(FileNameList{setno});
    for fileid = 1:length(FileNameList{setno})
        disp(['Analyzing ', PathNameList{setno}, FileNameList{setno}{fileid}]);

        currentfilename = [PathNameList{setno}, FileNameList{setno}{fileid}];



        switch MotionCorrectionProgram
            case 1, %Green only TurboReg --> HMM
                referenceColorID = 1;
                %for TurboReg
                turboregsourcefilename = currentfilename;
                turboregsavefilename = g_changeSIfilename(currentfilename, 'TurboReg_', 'BeforeNumber');
                turboregsavefilename = g_changeSIfilename(turboregsavefilename, 'TurboRegImage', 'InsertFolder');

                %for HMM
                HMMsourcefilename =  turboregsavefilename;
                HMMreferencefilename = turboregsavefilename;
                HMMimagefilename = g_changeSIfilename(currentfilename, 'TurboReg_HMM_', 'BeforeNumber');
                HMMimagefilename = g_changeSIfilename(HMMimagefilename, 'HMMImage', 'InsertFolder');
                combinedimagefilename = g_changeSIfilename(currentfilename, 'TurboReg_HMM_Combined_', 'BeforeNumber');
                combinedimagefilename = g_changeSIfilename(combinedimagefilename, 'HMMImage', 'InsertFolder');
                PIsavefilename = g_changeSIfilename(currentfilename, 'matdata', 'InsertFolder');
                PIsavefilename = g_changeSIfilename(PIsavefilename, 'TurboReg_', 'BeforeNumber');
                PIsavefilename = g_changeSIfilename(PIsavefilename, '_PI', 'BeforeExtension');
                PIsavefilename = g_changeSIfilename(PIsavefilename, 'mat', 'Extension');
                Markovsavefilename = g_changeSIfilename(currentfilename, 'matdata', 'InsertFolder');
                Markovsavefilename = g_changeSIfilename(Markovsavefilename, 'TurboReg_', 'BeforeNumber');
                Markovsavefilename = g_changeSIfilename(Markovsavefilename, '_Markov', 'BeforeExtension');
                Markovsavefilename = g_changeSIfilename(Markovsavefilename, 'mat', 'Extension');
                %run TurboReg
                RunTurboReg(turboregrefimage, turboregsourcefilename, turboregsavefilename, sessionreferencefilename);

                %run HMM
                if isempty(HMMrefimage)
                    state = g_getSIstate(HMMreferencefilename);
                    ImageMatrix = g_getimage(HMMreferencefilename, state, 1, [], 1:state.acq.numberOfChannelsSave, 0, 50);
                    HMMrefimage = mean(ImageMatrix{referenceColorID}, 3);
                    HMMrefimage(isnan(HMMrefimage)) = 0;
                end
                RunHMM(PathNameList{setno}, HMMrefimage, HMMsourcefilename, HMMimagefilename, [], ...
                    PIsavefilename, Markovsavefilename, HMMreferencefilename, referenceColorID, 0.04,0.01, 8, 2);

            case 2, %
                referenceColorID = 2;
                HMMsourcefilename =  currentfilename;
                HMMreferencefilename = currentfilename;
                HMMimagefilename = g_changeSIfilename(currentfilename, 'HMM_', 'BeforeNumber');
                HMMimagefilename = g_changeSIfilename(HMMimagefilename, 'HMMImage', 'InsertFolder');
                combinedimagefilename = g_changeSIfilename(currentfilename, 'HMM_Combined_', 'BeforeNumber');
                combinedimagefilename = g_changeSIfilename(combinedimagefilename, 'HMMImage', 'InsertFolder');
                PIsavefilename = g_changeSIfilename(currentfilename, 'matdata', 'InsertFolder');
                %PIsavefilename = g_changeSIfilename(PIsavefilename, 'TurboReg_', 'BeforeNumber');
                PIsavefilename = g_changeSIfilename(PIsavefilename, '_PI', 'BeforeExtension');
                PIsavefilename = g_changeSIfilename(PIsavefilename, 'mat', 'Extension');
                Markovsavefilename = g_changeSIfilename(currentfilename, 'matdata', 'InsertFolder');
                %Markovsavefilename = g_changeSIfilename(Markovsavefilename, 'TurboReg_', 'BeforeNumber');
                Markovsavefilename = g_changeSIfilename(Markovsavefilename, '_Markov', 'BeforeExtension');
                Markovsavefilename = g_changeSIfilename(Markovsavefilename, 'mat', 'Extension');

                %run HMM
                if isempty(HMMrefimage)
                    state = g_getSIstate(HMMreferencefilename);
                    ImageMatrix = g_getimage(HMMreferencefilename, state, 1, [], 1:state.acq.numberOfChannelsSave, 0, 50);
                    HMMrefimage = mean(ImageMatrix{referenceColorID}, 3);
                    HMMrefimage(isnan(HMMrefimage)) = 0;
                end
                RunHMM(PathNameList{setno}, HMMrefimage, HMMsourcefilename, HMMimagefilename, combinedimagefilename, ...
                    PIsavefilename, Markovsavefilename, HMMreferencefilename, referenceColorID, 0.04,0.01, 8, 2);
                %                 RunHMM(PathNameList{setno}, HMMrefimage, HMMsourcefilename, HMMimagefilename, combinedimagefilename, ...
                %                     PIsavefilename, Markovsavefilename, HMMreferencefilename, referenceColorID, 0.04,0.01, 12, 2);




        end


    end
end


% 
% for Greenberg Method
% GBsourcefilename = currentfilename;
% GBreferencefilename = currentfilename;
% GBimagefilename = g_changeSIfilename(currentfilename, 'TurboReg_GB_', 'BeforeNumber');
% GBimagefilename = g_changeSIfilename(GBimagefilename, 'GBImage', 'InsertFolder');
% 
% run GB
% if isempty(GBrefimage)
%     state = g_getSIstate(GBreferencefilename);
%     ImageMatrix = g_getimage(GBreferencefilename, state, 1, [], 1:state.acq.numberOfChannelsSave, 0, 50);
%     GBrefimage = mean(ImageMatrix{1}, 3);
%     GBrefimage(isnan(HMMrefimage)) = 0;
% end
% RunGB(PathNameList{setno}, GBrefimage, GBsourcefilename, GBreferencefilename, GBimagefilename);

