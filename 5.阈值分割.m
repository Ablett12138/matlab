%% 3.阈值分割任务
%----灰度化
img = imread('lenargb.bmp');
img1 = imread('guazi.bmp');

%手写灰度化
mygray1=function1(img);
mygray2=function1(img1);

%matlab自带灰度化
matgary1=rgb2gray(img);
matgary2=rgb2gray(img1);

% 在同一窗口中显示三个图像
figure% 打开一个新的窗口
subplot(1,3,1);
imshow(img);
title("lenargb");

subplot(1,3,2);
imshow(mygray1);
title("LenargbMygray");

subplot(1,3,3);
imshow(matgary1);
title("LenargbGray");

% 在同一窗口中显示三个图像
figure% 打开一个新的窗口
subplot(1,3,1);
imshow(img1);
title("guazi");

subplot(1,3,2);
imshow(mygray2);
title("GuaziMygray");

subplot(1,3,3);
imshow(matgary2);
title("GuaziGray");

%----灰度直方图
%读取灰度
myhist1=function2(matgary1);
myhist2=function2(matgary2);
figure% 打开一个新的窗口
%显示灰度图
plot(myhist1); %画图
title('1.lenargb自己的直方图');
figure% 打开一个新的窗口
plot(myhist2); %画图
title('2.Guazi自己的直方图');

%matla版本
%直方图
figure; %新开窗口
imhist(mygray1);
title('3.lenaMatlab的直方图');

figure; %新开窗口
imhist(mygray2);
title('4.GuaziMatlab的直方图');

%----阈值分割
mygray1_thre=function3(mygray1,128);
mygray2_thre=function3(mygray2,128);

% 在同一窗口中显示2个图像
figure% 打开一个新的窗口
subplot(1,2,1);
imshow(mygray1_thre);
title("5.lenargb thres");

subplot(1,2,2);
imshow(mygray2_thre);
title("6.guazi thres");


function [img] = function3(img,num)
 [width,height,bmsize] = size(img);%第二步，获得图片尺寸
  for i=1:width
        for j=1:height
            if img(i,j)>num
                img(i,j) =255;
            else
                img(i,j) =0;
            end
        end
  end
return
end