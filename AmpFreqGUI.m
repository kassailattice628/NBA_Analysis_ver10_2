%% AmpFreqGUI %%
close all
clear all

global ui
global prm

set(0, 'showhiddenhandles', 'on');

scrsz=get(0,'ScreenSize');%これは，スクリーンサイズの取得で[左縁の位置=1, 下縁の位置=1, 幅=1280, 高さ=778)を自動で得る
figure1 = figure('Position',[scrsz(1)+10, scrsz(2)+50, scrsz(3)*7/8, scrsz(4)-200], 'Name', 'AmpFreqGUI');
%ラボのディスプレイは，1280 * 1024 と，高さが違うので，ちょっと変更
%figure1 = figure('Position',[scrsz(1)+4, scrsz(4)/5, scrsz(3)/3, 800-50], 'Name', 'AmpFreqGUI' );
%{
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

%openTaable内変数
prm.FVsampt = 0.574616;
prm.F0_end_frame = 15;
prm.stim_color = 6;
prm.interp_times = 10;
%}

%GUI
openGUI;

