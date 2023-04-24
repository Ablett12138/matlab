clear;
clc;
close all;
I=imread('rice.png');
imshow(I);
title('1. 大米原图');
% % 2.估计图像背景：
% %
% % 图像中心位置背景亮度强于其他部分亮度，用 imopen 函数和一个半径为 15 的圆盘结
% 构元素对输入的图像 I 进行形态学开操作，去掉那些不完全包括在圆盘中的对象，从而实现
% 对背景亮度的估计。
figure;
background=imopen(I,strel('disk',15));
imshow(background);
title('2. 背景');
figure,surf(double(background(1:8:end,1:8:end))),zlim([0,255]);
set(gca,'ydir','reverse');
title('3. 背景');
% 3.从原始图像中减去背景图像（原始图像 I 减去背景图像得到背景较为一致的图像）：
I2=imsubtract(I,background);
figure,imshow(I2)
title('4. 消除背景后照片');
% 4.调节图像的对比度 (图像较暗，可用 imadjust 函数命令来调节图像的对比度)
I3=imadjust(I2,stretchlim(I2),[0 1]);
figure,imshow(I3);
title('5. 调整对比度后照片');
%5.使用阈值操作将图像转换为二进制(二值)图像(bw),调用 whos 命令查看图像的存储信息.
level=graythresh(I3); % 图像灰度处理
bw=im2bw(I3,level); % 图像二值化处理
figure;
imshow(bw); % 显示处理后的图片
title('6. 二值化');
% 6.检查图像中对象个数（bwlabel 函数表示了二值图像中的所有相关成分并返回在图像中
%找到的对象个数）
[labeled,numObjects]=bwlabel(bw,8);
% 7.检查标记矩阵：（imcrop 命令进行交互式操作，图像内拉出较小矩形并显示已标记的对
%
% grain=imcrop(labeled);
% 8.观察标记矩阵（用 label2rgb 将其显示为一副伪彩色的索引图像）:
figure;
RGB_label=label2rgb(labeled,@spring,'c','shuffle');
imshow(RGB_label);
title('7.伪彩色');
% 9.测量图像对象或区域的属性（Regionprops，返回一个结构数据）
graindata=regionprops(labeled,'basic');