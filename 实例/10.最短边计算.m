%% 最短边距离
clc; 
clear; 
close all; 

mypic=imread('zuixiaobianjuli1.jpg');
mypicgray=rgb2gray(mypic); 
T = graythresh(mypicgray);                  % 自动获取阈值
g = imbinarize(mypicgray,T);                    %阈值分割
g=1-g;

%统计标注连通域
%使用外接矩形框选连通域，并使用形心确定连通域位置
[mark_image,num] = bwlabel(g,8); 
%bwlabel 寻找连通区域，    4连通是指，如果像素的位置在其他像素相邻的上、下、左或右，则认为他们是连接着的
%num 表示连通区域的个数
%l是大小和BWing一样的图像数组，里面存放着对bwing图像的标签值（即判定为连通后，在L矩阵中标记出来）

fprintf('连通体个数为:==>%d\n',num);
%获取各个连通体参数
status=regionprops(mark_image,'BoundingBox','Centroid','Area');

BoundingBox=status.BoundingBox;
center(1)=uint16(BoundingBox(1)+BoundingBox(3)/2);
center(2)=uint16(BoundingBox(2)+BoundingBox(4)/2);


%获取图像的大小
[width,height,channel]=size(mypicgray);
len=0;
i=center(2);
for j=center(1):width
    if g(i,j)==1
        len=len+1;
        g(i,j)=0;
    end
end

%%转换为灰度
figure; %新开窗口
subplot(1,2,1),imshow(mypicgray); 
hold on;
plot(center(1), center(2), 'r+', 'MarkerSize', 3, 'LineWidth', 1);
title('2.灰度化图');

subplot(1,2,2),imshow(g); 
rectangle('position',status.BoundingBox,'edgecolor','r'),
hold on;
plot(center(1), center(2), 'r+', 'MarkerSize', 3, 'LineWidth', 1);
title('2.最短距离的一半');
fprintf('最短边长度为:==>%d\n',len*2);