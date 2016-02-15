function Z = Double_Gauss_Sum1(beta,x)%,C0,C1)
%
% Two same Gaussians are simply summed.
% !!!! without inhibition !!!!
%
% Gaussian function with rotation.
% beta is a set of gaussian parameters.
% beta = [Amp,x0,x_sd,y0,y_sd,phi,Amp2,sd_ratio].
%
%
% center of the 1st gaussian is C0(x0,y0)
% center of the 2nd gaussian is C1(x1,y1)

b1 = beta(1);%Amp
b3 = beta(2);%x_sd
b5 = beta(3);%y_sd
b6 = beta(4);%phi( 0 <= phi, phi < 2*pi)


%b2 = C0(1);%x0
b2 = 96.6895;
%b4 = C0(2);%y0
b4 = 205.6102;
%b7 = C1(1);%x1
b7 = 152.2950;
%b8 = C1(2);%y1
b8 = 203.0907;

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

%中心座標補正
X1rot = b7*cos(b6) - b8*sin(b6);
Y1rot = b7*sin(b6) + b8*cos(b6);

if length(beta) == 4
    Z = b1*(exp(-( ((Xrot-X0rot).^2)/(2*(b3)^2) + ((Yrot-Y0rot).^2)/(2*(b5)^2))))...
        + b1*(exp(-( ((Xrot-X1rot).^2)/(2*(b3)^2) + ((Yrot-Y1rot).^2)/(2*(b5)^2))));
elseif length(beta) == 6
    b9 = beta(5);%Amp1
    b10 = beta(6);%sd_ratio
    Z = b1*(exp(-( ((Xrot-X0rot).^2)/(2*(b3)^2) + ((Yrot-Y0rot).^2)/(2*(b5)^2))))...
        -b9*(exp(-( ((Xrot-X0rot).^2)/(2*(b10*b3)^2) + ((Yrot-Y0rot).^2)/(2*(b10*b5)^2))))...
        +b1*(exp(-( ((Xrot-X1rot).^2)/(2*(b3)^2) + ((Yrot-Y1rot).^2)/(2*(b5)^2))))...
        -b9*(exp(-( ((Xrot-X1rot).^2)/(2*(b10*b3)^2) + ((Yrot-Y1rot).^2)/(2*(b10*b5)^2))));
end
%{
%1st Gaussian
if length(beta) == 4
    Z0 = b1*(exp(-( ((Xrot-X0rot).^2)/(2*(b3)^2) + ((Yrot-Y0rot).^2)/(2*(b5)^2))));
elseif length(beta) == 6
    b9 = beta(5);%Amp1
    b10 = beta(6);%sd_ratio
    Z0 = b1*(exp(-( ((Xrot-X0rot).^2)/(2*(b3)^2) + ((Yrot-Y0rot).^2)/(2*(b5)^2))))...
        -b9*(exp(-( ((Xrot-X0rot).^2)/(2*(b10*b3)^2) + ((Yrot-Y0rot).^2)/(2*(b10*b5)^2))));
end

%中心座標補正
X1rot = b7*cos(b6) - b8*sin(b6);
Y1rot = b7*sin(b6) + b8*cos(b6);

%2nd Gaussian
if length(beta) == 8
    Z1 = b1*(exp(-( ((Xrot-X1rot).^2)/(2*(b3)^2) + ((Yrot-Y1rot).^2)/(2*(b5)^2))));
elseif length(beta) == 10
    b9 = beta(9);%Amp1
    b10 = beta(10);%sd_ratio
    Z1 = b1*(exp(-( ((Xrot-X1rot).^2)/(2*(b3)^2) + ((Yrot-Y1rot).^2)/(2*(b5)^2))))...
        -b9*(exp(-( ((Xrot-X1rot).^2)/(2*(b10*b3)^2) + ((Yrot-Y1rot).^2)/(2*(b10*b5)^2))));
end

%}
%%%%%%