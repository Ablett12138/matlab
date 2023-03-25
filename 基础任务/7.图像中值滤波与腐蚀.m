%%任务9描述：
%  (1)对图“fankuaituzaosheng.bmp”灰度化
% （2）而后进行滤波，
% （3）而后阈值分割
% （4）而后计算目标物体的面积
img = imread('fankuaituzaosheng.bmp');

%matlab自带灰度化
matgary=rgb2gray(img);

% 使用3x3的中值滤波器进行滤波
img_medfilt = medfilt2(matgary, [3, 1]);

% 定义腐蚀结构元素，这里使用3x3的矩形
SE = strel('rectangle',[3 3]);

% 对二值图像进行膨胀操作
dilated_img = imdilate(img_medfilt, SE);
% 对二值图像进行腐蚀操作
eroded_img = imerode(dilated_img, SE);

%----阈值分割
mygray_thre=function3(img_medfilt,128);

area_label=area_cal(mygray_thre);
fprintf('面积1号为:%d piex\n',area_label(1));
fprintf('面积2号为:%d piex\n',area_label(2));


% 在同一窗口中显示3个图像
figure% 打开一个新的窗口
subplot(1,3,1);
imshow(img);
title("1.原图");

subplot(1,3,2);
imshow(eroded_img);
title("2.滤波后的图像");

subplot(1,3,3);
imshow(mygray_thre);
title("3.阈值分割后的图像");

