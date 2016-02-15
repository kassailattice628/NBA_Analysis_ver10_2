%PSTH ��\��
clear histraw;
clear histx;
figure('Color','w');
x=[];
y=[];
ssemp = length(hspikes);
stspikes=zeros(1,ssemp);
for i=1:ssemp
    a=hspikes{1,i}; 
        x=[x;a];%#ok<AGROW>
    if isempty(a)
        continue
    end
   b=a-50*ones(length(a),1);
   c=b(find(b,1,'first'));
   y=[y;c]; %#ok<AGROW>, atency ��get
end

% devide time axis by bins
z=0:binms:Bhead(1,n);
%spike number
histraw = hist(x,z);


%%%�g���C�A�����Ŋ�����probability �ɂ���D
%histx = hist(x,z)/ssemp;%hist(x,z)�ŁC����PSTH�̃v���b�g�̒l�i�_�O���t��̒l�j
histx = hist(x,z)/ssemp*1000;
%change to freq (spikes/s).
%psth plot
bar(z,histx)
%%%
axis([-50 Bhead(1,1)+50, 0 500])

title(['N= ',num2str(length(y)),' mean latency= ',num2str(mean(y)),' latency std= ',num2str(std(y)),' spikenum= ',num2str(length(x))])
