%% 最短边距离
clc; 
clear; 
close all; 

mypic=imread('zuixiaobianjul2.jpg');
mypicgray=rgb2gray(mypic); 
T = graythresh(mypicgray);                  % 自动获取阈值
imgTh = imbinarize(mypicgray,T);                    %阈值分割
imgTh=(1-imgTh)*255;
%%%先用迭代式阈值求法将图像变为二值图
%%%旋转图像求其MER
for angle = 0 : 1 : 90
    imgRotated = double(imrotate(imgTh,angle,'bicubic','loose'));  %求旋转后的图像
%   imshow(uint8(imgRotated));
    [row, col] = size(imgRotated);

    %%%判断最小外接矩形的边界
    for i = 1 : row
        if sum(imgRotated(i, :)) > col
            break;
        end
    end
    yMinTest = i;

    for i = row : -1 : 1
        if sum(imgRotated(i, :)) > col
            break;
        end
    end
    yMaxTest = i;

    for i = 1 : col
        if sum(imgRotated(:, i)) > row
            break;
        end
    end
    xMinTest = i;

    for i = col : -1 : 1
        if sum(imgRotated(:, i)) > row
            break;
        end
    end
    xMaxTest = i;
    %%%判断最小外接矩形的边界
    
    %%%计算面积
    XLU = xMinTest * cosd(angle) - yMinTest * sind(angle);
    YLU = xMinTest * sind(angle) + yMinTest * cosd(angle);

    XLD = xMinTest * cosd(angle) - yMaxTest * sind(angle);
    YLD = xMinTest * sind(angle) + yMaxTest * cosd(angle);

    XRU = xMaxTest * cosd(angle) - yMinTest * sind(angle);
    YRU = xMaxTest * sind(angle) + yMinTest * cosd(angle);

    XRD = xMaxTest * cosd(angle) - yMaxTest * sind(angle);
    YRD = xMaxTest * sind(angle) + yMaxTest * cosd(angle);
        
    l1 = sqrt((XLU - XRU) ^ 2 + (YLU - YRU) ^ 2);
    l2 = sqrt((XLU - XLD) ^ 2 + (YLU - YLD) ^ 2);


    nowSize = l1 * l2;
    %%%保存当前求得的MER
    if angle == 0 || nowSize < typicalSize
        xMin = xMinTest;
        yMin = yMinTest;
        xMax = xMaxTest;
        yMax = yMaxTest;
        typicalSize = nowSize;
        typicalAngle = angle;
        typicalImg = imgRotated;
    end
    %%%保存当前求得的MER
    lastSize = nowSize;
end

%%%重现
XLU = xMin * cosd(typicalAngle) - yMin * sind(typicalAngle);
YLU = xMin * sind(typicalAngle) + yMin * cosd(typicalAngle);

XLD = xMin * cosd(typicalAngle) - yMax * sind(typicalAngle);
YLD = xMin * sind(typicalAngle) + yMax * cosd(typicalAngle);

XRU = xMax * cosd(typicalAngle) - yMin * sind(typicalAngle);
YRU = xMax * sind(typicalAngle) + yMin * cosd(typicalAngle);

XRD = xMax * cosd(typicalAngle) - yMax * sind(typicalAngle);
YRD = xMax * sind(typicalAngle) + yMax * cosd(typicalAngle);
%%%重现

subplot(2,1,1);
imshow(imgTh);
title('原图像');

out1 = imrotate(imgTh,typicalAngle,'bicubic','loose');
rectx = [xMin, xMax, xMax, xMin, xMin];
recty = [yMax, yMax, yMin, yMin, yMax];
subplot(2,1,2);
imshow(out1);
title(['旋转角度为',num2str(typicalAngle),'°']);
line(rectx(:),recty(:),'color','r');

center(1)=uint16(xMin+xMax)/2;
center(2)=uint16(yMin+yMax)/2;

%获取图像的大小
[width,height,channel]=size(out1);

for i=1:width
    for j=1:height
        if out1(i,j)>0
            out1(i,j)=255;
        else
            out1(i,j)=0;
        end
    end
end


len=0;
i=center(1);
for j=center(2):height
    if out1(j,i)==255
        len=len+1;
        out1(j,i)=0;
    end
end

%%转换为灰度
figure; %新开窗口
imshow(out1); 
hold on;
plot(center(1), center(2), 'r+', 'MarkerSize', 3, 'LineWidth', 1);
title('1.旋转后的图');
fprintf('最短边长度为:==>%d\n',len*2);