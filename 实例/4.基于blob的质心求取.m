% 二值化处理
%%两个方块
clc;
clear;
close all;
blob = imread('fankuaitu2ge.bmp');
imshow(blob);
title('1.方块原图');

%%转换为灰度
figure; %新开窗口
gray=rgb2gray(blob);
imshow(gray);
title('2.方块由 matlab 灰度化图');

[width,height,bmgs]=size(gray); %获得图像的尺寸：宽度，高度

%%阈值分割
for i=1:width
    for j=1:height
        if gray(i,j)>128
            gray(i,j) = 255;
        else
            gray(i,j) = 0;
        end
    end
end

%%转换为灰度
figure; %新开窗口
imshow(gray);
title('3.方块自己计算的阈值分割');

%%面积计算
%%规避边界，防止溢出
biaoqian = 0;
for i=2:width %行扫描
    for j=2:height %列扫描
        % if( (当前数据 = 黑色))
        if gray(i,j) == 0 
        % if( (左边数据没标签)&&（上面数据没标签）&&（右边数据没标签）&&(下面数据没标签) )
            if( ((gray(i,j-1)==0)||(gray(i,j-1)==255))&&((gray(i-1,j)==0)||(gray(i-1,j)==255))&&((gray(i,j+1)==0)||(gray(i,j+1)==255))&&((gray(i+1,j)==0)||(gray(i+1,j)==255)) )
            %贴新标签
                biaoqian = biaoqian +1;
                gray(i,j) = biaoqian;
            %左边坐标有标签，则改点赋值为左边标签
            elseif( (gray(i,j-1)~=0)&&(gray(i,j-1)~=255))
                gray(i,j) = gray(i,j-1);
            elseif( (gray(i-1,j)~=0)&&(gray(i-1,j)~=255)) %上面坐标有标签，则改点赋值为上面标签
                gray(i,j) = gray(i-1,j);
            elseif( (gray(i,j+1)~=0)&&(gray(i,j+1)~=255)) %右边坐标有标签，则改点赋值为右边标签
                gray(i,j) = gray(i,j+1);
            elseif( (gray(i+1,j)~=0)&&(gray(i+1,j)~=255)) %下面坐标有标签，则改点赋值为下面标签
                gray(i,j) = gray(i+1,j);
            end
        end
    end
end
%%贴完的标签的面积计算
area_label =zeros(254,1);
%%质心的标签建立
sumX_label = zeros(254,1);
sumY_label = zeros(254,1);
value =0;
for i=1:width %行扫描
    for j=1:height %列扫描
        if( gray(i,j)~=0 &&(gray(i,j)~=255))
            value = gray(i,j);
            sumX_label(value,1) = sumX_label(value,1)+j;
            sumY_label(value,1) = sumY_label(value,1)+i;
            area_label(value,1) = area_label(value,1)+1;
        end
    end
end
fprintf('面积1号为:%d piex\n',area_label(1));
fprintf('面积2号为:%d piex\n',area_label(2));

%%计算质心
centroidX(1) = sumX_label(1) / area_label(1);
centroidY(1) = sumY_label(1) / area_label(1);

centroidX(2) = sumX_label(2) / area_label(2);
centroidY(2) = sumY_label(2) / area_label(2);

%%显示图像
imshow(blob);
hold on;
plot(centroidX(1), centroidY(1), 'r+', 'MarkerSize', 3, 'LineWidth', 1);
plot(centroidX(2), centroidY(2), 'r+', 'MarkerSize', 3, 'LineWidth', 1);
fprintf('1号物体质心坐标为:X=%.2f Y=%.2f\n',centroidX(1),centroidY(1));
fprintf('2号物体质心坐标为:X=%.2f Y=%.2f\n',centroidX(2),centroidY(2));