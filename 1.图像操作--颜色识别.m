%% 打开两幅图像
filename = 'lenargb.bmp';
imgRgb = imread(filename); % 读入一幅彩色图像
filename1 = 'guazi.bmp';
imgRgb1 = imread(filename1); % 读入一幅彩色图像
imshow(imgRgb); % 显示彩色图像
imshow(imgRgb1); % 显示彩色图像

%%图像灰度化
imgGray = rgb2gray(imgRgb); % 转为灰度图像
imgGray1 = rgb2gray(imgRgb1); % 转为灰度图像

figure % 打开一个新的窗口显示灰度图像
imshow(imgGray); % 显示转化后的灰度图像
imshow(imgGray1); % 显示转化后的灰度图像
imwrite(imgGray, 'lenargb_gray.jpg'); % 将灰度图像保存到图像文件
imwrite(imgGray1, 'guazi_gray.jpg'); % 将灰度图像保存到图像文件

%%创建100*100 红色图像
figure% 打开一个新的窗口
redImage = zeros(100, 100, 3); % 创建一个100x100的零矩阵
redImage(:, :, 1) = 1; % 将红色通道(第一个通道)设为1
imshow(redImage); % 显示图像
imwrite(redImage,"red.bmp")
 
%% 判断三幅图颜色
name1="tu1.jpg";
name2="tu2.jpg";
name3="tu3.jpg";

tu1 = imread("tu1.jpg");
tu2 = imread("tu2.jpg");
tu3 = imread("tu3.jpg");
figure% 打开一个新的窗口

% 在同一窗口中显示三个图像
subplot(1,3,1);
imshow(tu1);
title('图像1');

subplot(1,3,2);
imshow(tu2);
title('图像2');

subplot(1,3,3);
imshow(tu3);
title('图像3');

color1=function1(tu1);
color2=function1(tu2);
color3=function1(tu3);

% 在同一窗口中显示三个图像
figure% 打开一个新的窗口
subplot(1,3,1);
imshow(tu1);
title(color1);

subplot(1,3,2);
imshow(tu2);
title(color2);

subplot(1,3,3);
imshow(tu3);
title(color3);


