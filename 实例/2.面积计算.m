%% 1.拓展任务
img = imread('fankuaitu.bmp');

%matlab自带灰度化
matgary=rgb2gray(img);

%matla版本
%直方图
figure; %新开窗口
imhist(matgary);
title('1.fankuaitu的直方图');

%阈值分割
%----阈值分割
fankuaitu_thre=function3(matgary,226);

% 在同一窗口中显示2个图像
figure% 打开一个新的窗口
subplot(1,2,1);
imshow(matgary);
title("1.fankuaitu gray");

subplot(1,2,2);
imshow(fankuaitu_thre);
title("2.matgary thres");

%计算面积
area=0;
[width,height,bmsize] = size(fankuaitu_thre);%获得图片尺寸
for i=1:width
    for j=1:height
           if fankuaitu_thre(i,j)==0
               area=area+1;
           end
    end
end
fprintf('面积为:%d piex\n',area);