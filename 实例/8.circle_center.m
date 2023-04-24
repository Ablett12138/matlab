%%两孔之间距离
clc; 
clear; 
close all; 
mypic = imread('liangkongzhijianjuli.jpg'); 
imshow(mypic); 
title('1.liangkongzhijianjuli');

%%转换为灰度
figure; %新开窗口
mypicgray=rgb2gray(mypic); 
imshow(mypicgray); 
title('2.灰度化图');

T = graythresh(mypicgray);                  % 自动获取阈值
g = imbinarize(mypicgray,T); %把下面两行换成这句也可，意思是使用阈值将图像转换为二值图像。
figure;
imshow(g);title(['3.阈值处理,阈值为' num2str(T)]);

%统计标注连通域
%使用外接矩形框选连通域，并使用形心确定连通域位置
[mark_image,num] = bwlabel(g,8); 
%bwlabel 寻找连通区域，    4连通是指，如果像素的位置在其他像素相邻的上、下、左或右，则认为他们是连接着的
%num 表示连通区域的个数
%l是大小和BWing一样的图像数组，里面存放着对bwing图像的标签值（即判定为连通后，在L矩阵中标记出来）

max_area = 17000;
status=regionprops(mark_image,'BoundingBox','Centroid','Area');
figure;
imshow(mark_image);title('标记后的图像');
idx = find([status.Area] < max_area);
j=0;
for i=idx
    j=j+1;
    rectangle('position',status(i).BoundingBox,'edgecolor','r');%参考https://blog.csdn.net/zr459927180/article/details/51152094
    %参数说明：position绘制的为二维图像（他是通过对角的两点确定矩形框）
    %edgecolor 指边缘图像，r表示变换为红色。
    %facecolor 指内部填充颜色。
    text(status(i,1).Centroid(1,1)-15,status(i,1).Centroid(1,2)-15, num2str(j),'Color', 'r') 
    %这个是为绘制出来的矩形框图标记数字
end
k=0;
x=zeros(1,2,2);
for i=1:num
    if status(i).Area < max_area
        k=k+1;
        fprintf('第%d个孔的面积为%f\n',k, status(i).Area);
        x(:,:,k)=status(i).Centroid;
   
    end
end

distance=sqrt((x(1,1,1)-x(1,1,2)).^2+(x(1,2,1)-x(1,2,2)).^2);
fprintf('两孔的距离为%f\n',distance);
