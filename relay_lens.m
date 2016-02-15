function [M,obj_fl] = relay_lens(f1,f2,d)
% default input var
%�g�p�����Y�̏œ_����
%f1 = 60;
%f2 = 80;
%f2 = linspace(40,300,1000);
%�����Y�Ԃ̋���
% d = 90;

%PointGray Flea3 USB3.0, FL3U-U3-12Y3M-C
% Sensor size: 1/2 inch = 6.4*4.8 mm (1280 * 1024 pixels)
% �������C640*512 �Ŏg���Ȃ� 3.2*2.4 mm)
% Object size: 4*3 mm 
% �{���I�ɂ� 3.2/4 = 0.8�{���炢�ł����̂��i�ł����ĂP�{�j
% Object - flont lens �̋����� 100 mm �` 60 mm ���ǂ�


%���������Y�̏œ_����
f = f1.*f2./(f1+f2-d);

%�O�����Y�̎�_
delta1 = f.*d./f2;

%�ヌ���Y�̎�_
delta2 = f.*d./f1;

rl_mount = 10;% 10 �ɖ߂�
%�ヌ���Y����Z���T�܂ł̋���(C�}�E���g�̃t�����W�o�b�N��17.52mm)
b1 = 17.52+rl_mount;

%�ヌ���Y��_����Z���T�[�Ԃł̋���
b = b1 + delta2;

%�O�����Y��_���畨�̂܂ł̋��� 1/f = 1/a + 1/b �Ȃ̂�
a = f.*b./(b-f);

%%
%�O�����Y���畨�̂܂ł̋���
obj_fl = a - delta1; 

%�{��
M = b./a;

disp(['Magnification = x',num2str(M)])
disp(['Dist b/w Obj-FrontLens = ', num2str(obj_fl) ' mm'])
disp(['Focal Dist = ', num2str(f), ' mm']);

%%
% 0.8 �{�@80 mm �Ȃ�
% f1:50,f2:60,d:75 �ŁCx0.82, 83mm
% ���̂����肩
% f1:50,f2:100,d:70 �ŁCx0.84, 93mm
% f1:50,f2:90,d:70 �ŁCx0.82, 91mm

%% Tholabs SM1 �����Y�`���[�u
% 7.6 mm, 12.7mm, 25.4mm, 50.8mm, 76.2mm, 101.6mm

% �ρ@�����Y�`���[�u
% 14 + 12.7 or 25.4

% Iris ���� 11mm

% 75 mm
% 9.7 + 25.4 + 11 + 12.7 + (14+12.7)
% 

