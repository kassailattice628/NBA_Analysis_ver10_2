function draw_image_Gaussian_fit(X,Y,Z,img_path,params)
% Draw 2D gaussian contour line on ROI color map.
% 'X' is a glid for X dim. 
% 'Y' is a glid for Y dim.
% 'Z' is a fitted data on glid(X,Y)
% 'img_path'
% 'params' = [Amp0,x0,x_sd0,y0,y_sd0,phi,Amp1,x_sd1,y_sd1];

center = [params(2),params(4)];
phi = params(6);

img = imread(img_path);
imgsz = size(img,1);
img_calib = imgsz/max(max(X));

m = -tan(phi);
b = -m*center(1) + center(2);
xvh = 0:max(max(X));
yvh = xvh*m + b;

mrot = -m;
brot = mrot*center(2) - center(1);
yvv = 0:max(max(X));
xvv = yvv*mrot - brot;

figure;
imshow(img);
hold on 
contour(X*img_calib,Y*img_calib,Z);%,'ShowText','on');
plot([xvh(1) xvh(size(xvh))]*img_calib,[yvh(1),yvh(size(yvh))]*img_calib,'g');
plot([xvv(1) xvv(size(xvv))]*img_calib,[yvv(1),yvv(size(yvv))]*img_calib,'c');
hold off


