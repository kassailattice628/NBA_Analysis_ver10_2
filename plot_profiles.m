function plot_profiles(X,Y,Z,params,img_path,realsz)
%%
center = [params(2),params(4)];
phi = params(6);

img = imread(img_path);
imgsz = size(img,1);
sz_ratio = imgsz/realsz;

ROIcenter = inpuXls; 
% ROI cordinates (X,Y)
l = length(ROIcenter);
X_data = ROIcenter(1:2:l-1)*sz_ratio;
Y_data = ROIcenter(2:2:l)*sz_ratio;

m = -tan(phi);
b = (-m*center(1) + center(2));
xvh = 0:max(max(X));
yvh = xvh*m + b;

mrot = -m;
brot = (mrot*center(2) - center(1));
yvv = 0:max(max(X));
xvv = yvv*mrot - brot;

figure;
%subplot(4,4,[5,6,7,9,10,11,13,14,15])
imshow(img);
hold on
contour(X,Y,Z);
plot(X_data(roi),Y_data(roi),'.b');
set(gca,'YDir','reverse');

%plot horizontal and vertical lines
plot([xvh(1) xvh(size(xvh))],[yvh(1),yvh(size(yvh))],'k');
plot([xvv(1) xvv(size(xvv))],[yvv(1),yvv(size(yvv))],'k');
hold off

%{
%% fitted line
xdatafit = 0:max(max(X));
if length(params)==6
    beta1 = [params(1),params(2),params(3)];
    beta2 = [params(1),params(4),params(5)];
    
elseif length(params)==9
    beta1 = [params(1),params(2),params(3),params(7),params(8)];
    beta2 = [params(1),params(4),params(5),params(7),params(9)];
end
hdatafit = Gaussian1D(beta1,xdatafit);
vdatafit = Gaussian1D(beta2,xdatafit);

%plot axis1
subplot(4,4,1:3);
plot(xdatafit, hdatafit,'k');
hold on
xposh = (X_data -center(1))/cos(phi) + center(1);
plot(xposh(roi),Z_data(roi),'.r');
xlim([min(xdatafit) max(xdatafit)])
hold off

%plot axis 2
subplot(4,4,[8,12,16])
xposv = (Y_data -center(2))/cos(phi) + center(2);
plot(Z_data(roi), xposv(roi),'.g');
hold on
plot(vdatafit, xdatafit,'k');
ylim([min(xdatafit) max(xdatafit)])
set(gca, 'YDir','reverse')
%}
