
%%任务7  --- 滤波面积计算
clc;
clear;
close all;
img = imread('zaosheng.jpg');

%matlab自带灰度化
matgary=rgb2gray(img);

% 使用3x3的中值滤波器进行滤波
img_medfilt = medfilt2(matgary, [3, 3]);

img_gaussian=fspecial('gaussian',3,0.8); %生成高斯序列
img_gaussian=uint8(filter2(img_gaussian,img_medfilt));

img_mean=fspecial('average',[4 4]);
img_mean=uint8(filter2(img_mean,img_gaussian));


%----阈值分割
mygray_thre=my_thres(img_gaussian,190);



%%腐蚀
% 定义腐蚀结构元素，这里使用矩形
SE = strel('rectangle',[60 60]);

% 对二值图像进行腐蚀操作
eroded_img = imdilate(mygray_thre, SE);
% 对二值图像进行膨胀操作
dilated_img = imerode(eroded_img, SE);

SE = strel('rectangle',[10 10]);
% 对二值图像进行膨胀操作
dilated_img = imerode(dilated_img, SE);
eroded_img = imdilate(dilated_img, SE);



% 在同一窗口中显示三个图像
figure% 打开一个新的窗口
subplot(3,2,1);
imshow(img);
title('1.原图');

subplot(3,2,2);
imshow(img_medfilt);
title('2.中值滤波后');

subplot(3,2,5);
imshow(mygray_thre);
title('5.阈值分割后');

subplot(3,2,3);
imshow(img_gaussian);
title('3.高斯处理后');

subplot(3,2,4);
imshow(img_gaussian);
title('4.均值处理后');

subplot(3,2,6);
imshow(eroded_img);
title('6.滤波完成后');

area_label=area_cal(eroded_img);
fprintf('面积1号为:%d piex\n',area_label(1));
fprintf('面积2号为:%d piex\n',area_label(2));
fprintf('面积3号为:%d piex\n',area_label(3));

