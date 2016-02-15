function [M,obj_fl] = relay_lens(f1,f2,d)
% default input var
%使用レンズの焦点距離
%f1 = 60;
%f2 = 80;
%f2 = linspace(40,300,1000);
%レンズ間の距離
% d = 90;

%PointGray Flea3 USB3.0, FL3U-U3-12Y3M-C
% Sensor size: 1/2 inch = 6.4*4.8 mm (1280 * 1024 pixels)
% ただし，640*512 で使うなら 3.2*2.4 mm)
% Object size: 4*3 mm 
% 倍率的には 3.2/4 = 0.8倍くらいでいいのか（でかくて１倍）
% Object - flont lens の距離は 100 mm ～ 60 mm が良い


%合成レンズの焦点距離
f = f1.*f2./(f1+f2-d);

%前レンズの主点
delta1 = f.*d./f2;

%後レンズの主点
delta2 = f.*d./f1;

rl_mount = 10;% 10 に戻す
%後レンズからセンサまでの距離(Cマウントのフランジバックは17.52mm)
b1 = 17.52+rl_mount;

%後レンズ主点からセンサー間での距離
b = b1 + delta2;

%前レンズ主点から物体までの距離 1/f = 1/a + 1/b なので
a = f.*b./(b-f);

%%
%前レンズから物体までの距離
obj_fl = a - delta1; 

%倍率
M = b./a;

disp(['Magnification = x',num2str(M)])
disp(['Dist b/w Obj-FrontLens = ', num2str(obj_fl) ' mm'])
disp(['Focal Dist = ', num2str(f), ' mm']);

%%
% 0.8 倍　80 mm なら
% f1:50,f2:60,d:75 で，x0.82, 83mm
% このあたりか
% f1:50,f2:100,d:70 で，x0.84, 93mm
% f1:50,f2:90,d:70 で，x0.82, 91mm

%% Tholabs SM1 レンズチューブ
% 7.6 mm, 12.7mm, 25.4mm, 50.8mm, 76.2mm, 101.6mm

% 可変　レンズチューブ
% 14 + 12.7 or 25.4

% Iris 厚み 11mm

% 75 mm
% 9.7 + 25.4 + 11 + 12.7 + (14+12.7)
% 

