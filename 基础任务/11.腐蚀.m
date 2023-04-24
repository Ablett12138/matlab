% imerode 函数，该函数能够实现二值图像的腐蚀操作；
% imdilate 函数，该函数能够实现二值图像的膨胀操作；
%腐蚀膨胀例子 2
clc;
close all;
clear;
img=imread('多点.jpg');
img=rgb2gray(img);
se1=strel('disk',6);
img1=imerode(img,se1);
imshow(img);
title('原图');
figure;
imshow(img1);
title('腐蚀后的图像');