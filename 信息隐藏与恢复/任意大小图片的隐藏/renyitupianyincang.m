% 任务 3 描述：
% （1） 实现任意大小的图片信息隐藏
% （2）以“载体 lena.bmp”为隐藏载体
% （3） 分别实现“Axinxi.jpg”的信息隐藏和提取
% （4） 分别实现“Bxinxi.jpg”的信息隐藏和提取
%% 1.信息隐藏
clc;
clear;
close all;
mypic = imread('载体lena.bmp');
imshow(mypic);
title('1.载体lena1024*1024 原图');



% figure;
myxinxipic1 = imread("Axinxi.jpg");
% imshow(myxinxipic1);
% title('2.Axinxi');
% 
% figure;
myxinxipic2 = imread("Bxinxi.jpg");
% % imshow(myxinxipic2);
% title('3.Bxinxi');

hided_image1=hideMessage(mypic,myxinxipic1);
hided_image2=hideMessage(mypic,myxinxipic2);

figure;
imshow(hided_image1);
title('2.隐藏信息的 Axinxi');
imwrite(hided_image1,'处理好的照片1.bmp');
figure;
imshow(hided_image2);
title('3.隐藏信息的 Bxinxi');
imwrite(hided_image2,'处理好的照片2.bmp');

% %%  2.信息读取

recover1=recoverMessage(hided_image1);
recover2=recoverMessage(hided_image2);

imwrite(recover1,'恢复的信息 Axinxi.bmp');
imwrite(recover2,'恢复的信息 Bxinxi.bmp');
% 在同一窗口中显示三个图像
figure% 打开一个新的窗口
subplot(1,2,1);
imshow(recover1);
title('1.隐藏的信息 Axinxi');

subplot(1,2,2);
imshow(recover2);
title('2.隐藏的信息 Bxinxi');



