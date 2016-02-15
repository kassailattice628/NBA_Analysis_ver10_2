%中心から dist_set の中にある細胞を ２点目の刺激方向軸で半分に分割して，比べる

% stim1 の中心の座標
X0 = centers(1,1);
Y0 = centers(2,1);
%[X0,Y0] 中心に回転させた後の座標
ROI_Polar_rot = zeros(size(ROI_Polar(:,:,1),1), size(ROI_Polar(:,:,1),2),5);%回転用
%[X0,Y0]を中心に回転させた後，stim n の中心を [0,0] に変換したあとの座標
ROI_Polar_rotn= ROI_Polar_rot; % 回転後の response center n の中心 を 0 にあわせる
ROI_Cart_rotn = ROI_Polar_rot;
roi =OGB;
%%
for n = 1:5
    X0n = centers(1,n+1);
    Y0n = centers(2,n+1);
    
    %stim1 と stim_n の 中心を結んだ直線の角度を求めるために(X0,Y0)基準の極座標に
    [phi,rho]= cart2pol(X0n-X0, Y0n-Y0);% phi が傾きなので下で補正
    %disp(rad2deg(phi));
    %-phi 回転後の stimn 応答中心
    X0n_rot= pol2cart(phi - phi, rho);
    
    %stim1中心の極座標 ROI_Polar(:,:,1) を -phi 回転させる
    ROI_Polar_rot(:,:,n) = [ROI_Polar(:,1,1) - phi, ROI_Polar(:,2,1)];
    %回転後の極座標をxy座標に変換(stim1中心）
    [Xn_rot,Yn_rot] = pol2cart(ROI_Polar_rot(:,1,n),ROI_Polar_rot(:,2,n));
    %stim1 中心と stimn 中心の中点 x = X0n_rot/2 を軸に stimn 側を stim 1側に折り返して２つの応答を重ねる
    Xn_rot_sp = Xn_rot;
    Xn_rot_sp(Xn_rot >= X0n_rot/2) = X0n_rot - Xn_rot(Xn_rot >= X0n_rot/2);
    %X0n_rot/2 = 0 にしておく？
    %Xn_rot_sp2 = Xn_rot_sp- X0n_rot/2;
    
    Yn_rot_sp = Yn_rot;
    %x = 0 で反転する？
    %Yn_rot_sp(Yn_rot < 0) = -Yn_rot(Yn_rot < 0);
    ROI_Cart_rotn(:,1,n) = Xn_rot_sp;
    ROI_Cart_rotn(:,2,n) = Yn_rot_sp;
    [ROI_Polar_rotn(:,1,n), ROI_Polar_rotn(:,2,n)] = cart2pol(Xn_rot_sp, Yn_rot_sp);
    
    %n応答中心に平行移動して極座標に戻す
    %[ROI_Polar_rotn(:,1,n),ROI_Polar_rotn(:,2,n)] = cart2pol(Xn_rot-X0n_rot, Yn_rot-Y0n_rot);
end
%座標check
%{
figure;
polar(ROI_Polar(:,1,1),ROI_Polar(:,2,1),'ko');
hold on
polar(ROI_Polar_rotn(:,1,1),ROI_Polar_rotn(:,2,1),'bo');
polar(ROI_Polar_rotn(:,1,2),ROI_Polar_rotn(:,2,2),'co');
polar(ROI_Polar_rotn(:,1,3),ROI_Polar_rotn(:,2,3),'go');
polar(ROI_Polar_rotn(:,1,4),ROI_Polar_rotn(:,2,4),'yo');
polar(ROI_Polar_rotn(:,1,5),ROI_Polar_rotn(:,2,5),'ro');
%}
%%
% マッピングする
figure;
plot(ROI_Cart_rotn(:,1,1),ROI_Cart_rotn(:,2,1),'.','color',[1,.3,.3]);
plot(ROI_Cart_rotn(:,1,2),ROI_Cart_rotn(:,2,2),'.','color',[.3,.3,.3]);
plot(ROI_Cart_rotn(:,1,3),ROI_Cart_rotn(:,2,3),'.','color',[.1,.3,.5]);



