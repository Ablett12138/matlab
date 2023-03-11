%% 1.基础任务--灰度任务
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





