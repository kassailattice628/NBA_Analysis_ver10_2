function ROIaverage(xytfilename,roifilename, samp, startframe, endframe);
% 
%
%  ROIaverage(xytfilename,roifilename, samp, startframe,endframe);
%
%  xytfilename: path and file name of calcium images (.tif)
%  roifilename: path and file name of roi files (.roi or .zip)
%  samp: sampling rate of imaging experiment (fps)
%  startframe: first frame number for analysis
%  endframe:  last frame number 

tic

[ROIs]=ReadImageJROI(roifilename);

firstframe= imread(xytfilename);
imh=size(firstframe,1);
imw=size(firstframe,2);
nframe=endframe-startframe+1;
xytdata=zeros(imh,imw,nframe);


for imageind=1:nframe
  xytdata(:,:,imageind)=imread(xytfilename,imageind+startframe-1);
end

avedata=mean(xytdata,3);

%%% cell image and positions
figure
imagesc(avedata);colormap (gray); axis image

ncell=length(ROIs);
actime=(endframe-startframe+1)/samp;
time=linspace((startframe-1)/samp, endframe/samp, nframe);

for h=1:ncell
   actual_index(h)=str2num(ROIs{1,h}.strName);
end

[sorted_actual_index,IX]=sort(actual_index);

unnamed1=zeros(3,ncell);

hold on
for i=1:ncell
    axis ij;title ('Cell positions');
    x=[ROIs{1,IX(i)}.mnCoordinates(:,1); ROIs{1,IX(i)}.mnCoordinates(1,1)]-ROIs{1,IX(i)}.vnRectBounds(1,1)+ROIs{1,IX(i)}.vnRectBounds(1,2);
    y=[ROIs{1,IX(i)}.mnCoordinates(:,2); ROIs{1,IX(i)}.mnCoordinates(1,2)]-ROIs{1,IX(i)}.vnRectBounds(1,2)+ROIs{1,IX(i)}.vnRectBounds(1,1);
    bw(:,:,IX(i)) = poly2mask(x,y,128,256);

    %imshow(bw);
   
    plot(x,y,'b','LineWidth',2);
    unnamed1(1,i)=mean(x);
    unnamed1(2,i)=mean(y);
    unnamed1(3,i)=sum(sum(bw(:,:,IX(i))));
    text(unnamed1(1,i), unnamed1(2,i), ROIs{1,IX(i)}.strName, 'horizontalalignment','c','verticalalignment','m','color','r');
    
end

hold off

unnamed=zeros(nframe,ncell);

for j=1:ncell
for k=1:nframe
traceimage(:,:,k)=immultiply(xytdata(:,:,k),bw(:,:,IX(j)));
unnamed(k,j)=sum(sum(traceimage(:,:,k)))/unnamed1(3,j);
end
end


%%% trace normalization by baseline
for L=1:ncell
   
    n_unnamed(:,L)=unnamed(:,L)/mean (unnamed(:,L));
    sn_unnamed(:,L)=(n_unnamed(:,L)/(max(n_unnamed(:,L)))+(ncell-L));

end

% %%%calculating z-score and spike detection
thresh=3;%threshold = 3 s.d.
zsig = zscore(n_unnamed);
lessthanzero=find(zsig < thresh);
zsig(lessthanzero)=0;

pp1=[zsig(1,:);zsig(1:end-1,:)];%一つおくれの行列
pp2=[zsig(2:end,:);zsig(end,:)];%一つ進みの行列
spmat = sparse((zsig>=thresh)&(zsig-pp1>=0)&(zsig-pp2>=0));%sdがthresh以上のピークを探す
fspmat=full(spmat);

figure;
imagesc(zsig');colorbar;title ('z-score');xlabel('frame');ylabel('cell number')


%%% ca traces, all traces in 1 panel
scrsz = get(0,'ScreenSize');
figure('Position',[scrsz(3)/4 1 scrsz(3)/2 scrsz(4)])
plot(time,sn_unnamed, 'LineWidth',1);xlabel('time(sec)');ylim([0 ncell+1]);xlim([(startframe/nframe)*actime (endframe/nframe)*actime]);
set(gca,'YTick',[]);
hold on 


for m=1:ncell
scatX= find(fspmat(:,m))/(nframe/actime)+(startframe/nframe*actime);
scatY= ones(length(scatX),1)*(ncell-m)+1;
scatter (scatX,scatY,'k','*','LineWidth',1);
text(1+(startframe/nframe*actime), max(sn_unnamed(:,m))+0.15, ['Cell#' num2str(m)] , 'horizontalalignment','l','verticalalignment','m','color','k')

end
hold off

savefile=[xytfilename '_' num2str(startframe) '-' num2str(endframe)];
uisave({'unnamed','unnamed1'}, savefile)

toc



% %end of code