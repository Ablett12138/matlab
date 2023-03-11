%% 2.灰度直方图任务
img = imread('lenargb.bmp');
img1 = imread('guazi.bmp');

%手写灰度化
mygray1=function1(img);
mygray2=function1(img1);

%matlab自带灰度化
matgary1=rgb2gray(img);
matgary2=rgb2gray(img1);


%读取灰度
myhist1=function2(matgary1);
myhist2=function2(matgary2);
figure% 打开一个新的窗口
%显示灰度直方图
plot(myhist1); %画图
title('1.lenargb的直方图');
figure% 打开一个新的窗口
plot(myhist2); %画图
title('2.Guazi的直方图');

%matla版本
%直方图
figure; %新开窗口
imhist(mygray1);
title('3.lenaMatlab的直方图');

figure; %新开窗口
imhist(mygray2);
title('4.GuaziMatlab的直方图');


function [myzjhist] = function2(img)
    [width,height,bmgs]=size(img);
    %获得图像的尺寸:宽度，高度
    myzjhist= zeros(256,1);
    %自己定义一个直方图
    myquzhi=0;
    %该点图像灰度值
    for i=1:width
        %循环处理
        for j=1:height
            myquzhi = img(i,j);
            myzjhist(myquzhi+1,1) = myzjhist(myquzhi+1,1)+1; %该灰度的直方图取值+1
        end
    end
    return 
end