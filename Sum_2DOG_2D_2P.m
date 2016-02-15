function Z = Sum_2DOG_2D_2P(beta,x)
%
% Gaussian function with rotation.
% beta is a set of gaussian parameters.
% beta = [Amp0,x0,x_sd,y0,y_sd,phi].
% two gaussians have similar SDs.
% x is input vector or matrix(3D)



b1 = beta(1);%Amp1
b2 = beta(2);%SD1
b3 = beta(3);%Amp2
b4 = beta(4);%SD2
mu = beta(5);%

%DOG を重ねる？

Z1 = b1*(exp(-((x).^2)/2*(b2)^2)) - b3*(exp(-((x).^2)/2*(b4)^2));
Z2 = b1*(exp(-((x-mu).^2)/2*(b2)^2)) - b3*(exp(-((x-mu).^2)/2*(b4)^2));

% 中心のずれた　二つの 2D-DOG の和として fitting するか?
z = Z1 + Z2;

% Two p
%
%%
b1 = beta(1);%Amp
b2 = beta(2);%x0
b3 = beta(3);%x_sd
b4 = beta(4);%y0
b5 = beta(5);%y_sd
b6 = beta(6);%phi( 0 <= phi, phi < 2*pi)
 
if size(x,3) == 1 % x is 2D matrix
    X = x(:,1);
    Y = x(:,2);
elseif size(x,3) == 2 % x is 3D matrix
    X = x(:,:,1);
    Y = x(:,:,2);
end

%回転補正
Xrot = X.*cos(b6) - Y.*sin(b6);
Yrot = X.*sin(b6) + Y.*cos(b6);
%中心座標補正
X0rot = b2*cos(b6) - b4*sin(b6);
Y0rot = b2*sin(b6) + b4*cos(b6);

%2D Gaussian 
if length(beta) == 6
    Z = b1*(exp(-( ((Xrot-X0rot).^2)/(2*(b3)^2) + ((Yrot-Y0rot).^2)/(2*(b5)^2))));
elseif length(beta) == 8
    b7 = beta(7);%Amp1
    b8 = beta(8);%sd_ratio
    Z = b1*(exp(-( ((Xrot-X0rot).^2)/(2*(b3)^2) + ((Yrot-Y0rot).^2)/(2*(b5)^2))))...
        -b7*(exp(-( ((Xrot-X0rot).^2)/(2*(b8*b3)^2) + ((Yrot-Y0rot).^2)/(2*(b8*b5)^2))));
end
%

%回転は無視して



