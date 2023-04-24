% 任务 2 描述：
% （1） 读“取处理好的照片 22.bmp” 图片
% （2）将该图片 100*100 个像素的最低位提取出来
% （3）恢复出隐藏的信息。
% （4） 同样， 恢复出“信息隐藏处理好的照片
clc;
clear;
close all;
mypic = imread('处理好的照片22.bmp');
imshow(mypic);
title('1.处理好的照片22原图');
[width,height,bmgs]=size(mypic); %获得图像的尺寸：宽度，高度
mypicyiwei = reshape(mypic,[],1); %%变为一维矩阵
myxinxi = uint8(zeros(100*100,1));
for i=1:100*100
    %转换为字符串
    quzhi1 = dec2bin(0,8);
    s1=num2str(quzhi1); %转换为字符串
    for j=1:8
        quzhi2 = dec2bin(mypicyiwei(8*(i-1)+j),8);
        s2=num2str(quzhi2); %转换为字符串
        s1(j)=s2(8); %对最后一位取值
    end
    tempzhi = bin2dec(s1);
    myxinxi(i,1) = tempzhi;
end
myxinxinhuifu = reshape(myxinxi,100,100,1);
figure;
imshow(myxinxinhuifu);
title('2.隐藏的信息');
imwrite(myxinxinhuifu,'恢复的信息.bmp');