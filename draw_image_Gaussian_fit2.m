function draw_image_Gaussian_fit2(X,Y,Z1,img_path,params,Z2, params2)
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

%%
center2 = [params2(2),params2(4)];
phi2 = params2(6);

m = -tan(phi2);
b = -m*center2(1) + center2(2);
yvh2 = xvh*m + b;

mrot = -m;
brot = mrot*center2(2) - center2(1);
xvv2 = yvv*mrot - brot;

%%
figure;
imshow(img);
hold on 
contour(X*img_calib,Y*img_calib,Z1);
plot([xvh(1) xvh(size(xvh))]*img_calib,[yvh(1),yvh(size(yvh))]*img_calib,'g');
plot([xvv(1) xvv(size(xvv))]*img_calib,[yvv(1),yvv(size(yvv))]*img_calib,'c');

contour(X*img_calib,Y*img_calib,Z2);
plot([xvh(1) xvh(size(xvh))]*img_calib,[yvh2(1),yvh2(size(yvh2))]*img_calib,'g');
plot([xvv2(1) xvv2(size(xvv2))]*img_calib,[yvv(1),yvv(size(yvv))]*img_calib,'c');
hold off







