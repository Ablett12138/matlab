% imerode 函数，该函数能够实现二值图像的腐蚀操作；
% imdilate 函数，该函数能够实现二值图像的膨胀操作；
clc;
close all;
clear;
img=imread('少点.jpg');
img=rgb2gray(img);
se1=strel('square',9);
img2= imdilate(img,se1);
imshow(img);
title('原图');
figure;
imshow(img2);
title('膨胀后的图像')