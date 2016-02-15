function Z = GaussianRot2D3_fix(beta,x)
%
% Gaussian function with rotation.
% beta is a set of gaussian parameters.
% beta = [Amp,x0,x_sd,y0,y_sd,phi,Amp2,sd_ratio].
% two gaussians have similar SDs.
% x is input vector or matrix(3D)
%
b1 = 0.1316;%Amp
b2 = 52.1409;%x0
b3 = 128.7287;%x_sd
b4 = 114.1614;%y0
b5 = 80.7638;%y_sd
b6 = 1.9138;%phi( 0 <= phi, phi < 2*pi)

b2_2 = 96.8237;
b4_2 = 111.1359;

if size(x,3) == 1 % x is 2D matrix
    X = x(:,1);
    Y = x(:,2);
elseif size(x,3) == 2 % x is 3D matrix
    X = x(:,:,1);
    Y = x(:,:,2);
end

%‰ñ“]•â³
Xrot = X.*cos(b6) - Y.*sin(b6);
Yrot = X.*sin(b6) + Y.*cos(b6);
%’†SÀ•W•â³
X0rot = b2*cos(b6) - b4*sin(b6);
Y0rot = b2*sin(b6) + b4*cos(b6);

X0rot2 = b2_2*cos(b6) - b4_2*sin(b6);
Y0rot2 = b2_2*sin(b6) + b4_2*cos(b6);

%2D Gaussian
    b7 = beta(1);%Amp1
    b8 = beta(2);%sd_ratio
    Z = (b1*(exp(-( ((Xrot-X0rot).^2)/(2*(b3)^2) + ((Yrot-Y0rot).^2)/(2*(b5)^2))))...
        -b7*(exp(-( ((Xrot-X0rot).^2)/(2*(b8*b3)^2) + ((Yrot-Y0rot).^2)/(2*(b8*b5)^2)))))...
        + (b1*(exp(-( ((Xrot-X0rot2).^2)/(2*(b3)^2) + ((Yrot-Y0rot2).^2)/(2*(b5)^2))))...
        -b7*(exp(-( ((Xrot-X0rot2).^2)/(2*(b8*b3)^2) + ((Yrot-Y0rot2).^2)/(2*(b8*b5)^2)))));
    
%%%%%%