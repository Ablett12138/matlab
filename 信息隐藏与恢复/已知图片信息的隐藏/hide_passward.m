% 任务 1 描述：
% （1） 读取 lenayinchan.bmp 图片
% （2） 读取 my911.bmp 图片
% （3） 通过对 lenayinchan.bmp 图片每个像素最后一位的改写， 将 my911.bmp 图
% 片隐藏在其中。
clc;
clear;
close all;
mypic = imread('lenayinchan.bmp');
imshow(mypic);
title('1.lena1024*1024 原图');
[width,height,bmgs]=size(mypic); %获得图像的尺寸：宽度，高度
mypicyiwei = reshape(mypic,[],1); %%变为一维矩阵
myxinxipic = imread('my911.bmp');

myxinxipicyiwei = reshape(myxinxipic,[],1); %%变为一维矩阵
[widthyy,bmgsyy]=size(myxinxipicyiwei); %获得图像的尺寸：宽度，高度
for i=1:widthyy
    quzhi=dec2bin(myxinxipicyiwei(i),8); %%转换为 8 位二进制
    s1=num2str(quzhi); %转换为字符串,待隐藏信息
    for j=1:8
        quzhi2 = dec2bin(mypicyiwei(8*(i-1)+j),8); %%载体
        s2=num2str(quzhi2); %转换为字符串 %%载体
        s2(8)=s1(j); %对最后一位赋值
        tempzhi = bin2dec(s2);
        mypicyiwei(8*(i-1)+j) = tempzhi;
    end
end
myyincanchulipic = reshape(mypicyiwei,width,height,bmgs);
figure;
imshow(myyincanchulipic);
title('3.隐藏信息的 lena');
imwrite(myyincanchulipic,'处理好的照片.bmp');