%%多个目标
clc;
clear;
close all;
blob = imread('fankuaituduoge.bmp');
imshow(blob);
title('1.方块原图');

%%转换为灰度
figure; %新开窗口
blobgray=rgb2gray(blob);
imshow(blobgray);
title('2.方块灰度化图');

%直方图自己计算
[width,height,bmgs]=size(blobgray); %获得图像的尺寸：宽度，高度
%%阈值分割
for i=1:width
    for j=1:height
        if blobgray(i,j)>128
                blobgray(i,j) = 255;
            else
                blobgray(i,j) = 0;
        end
     end
end
%%转换为灰度
figure; %新开窗口
imshow(blobgray);
title('3.方块自己计算的阈值分割');

%%面积计算
biaoqian = 0;
for i=2:width %行扫描
    for j=2:height %列扫描
        if blobgray(i,j) == 0 % if( (当前数据 = 黑色)
            % if( (左边数据没标签)&&（上面数据没标签）&&（右边数据没标签）&&(下面数据没标签) )
            if( ((blobgray(i,j-1)==0)||(blobgray(i,j-1)==255))&&((blobgray(i-1,j)==0)||(blobgray(i-1,j)==255))&&((blobgray(i,j+1)==0)||(blobgray(i,j+1)==255))&&((blobgray(i+1,j)==0)||(blobgray(i+1,j)==255)) )
                    %贴新标签
                    biaoqian = biaoqian +1;
                    blobgray(i,j) = biaoqian;
                %左边坐标有标签，则改点赋值为左边标签
                elseif( (blobgray(i,j-1)~=0)&&(blobgray(i,j-1)~=255))
                    blobgray(i,j) = blobgray(i,j-1);
                elseif( (blobgray(i-1,j)~=0)&&(blobgray(i-1,j)~=255)) %上面坐标有标签，则改点赋值为上面标签
                    blobgray(i,j) = blobgray(i-1,j);
                elseif( (blobgray(i,j+1)~=0)&&(blobgray(i,j+1)~=255)) %右边坐标有标签，则改点赋值为右边标签
                    blobgray(i,j) = blobgray(i,j+1);
                elseif( (blobgray(i+1,j)~=0)&&(blobgray(i+1,j)~=255)) %下面坐标有标签，则改点赋值为下面标签
                    blobgray(i,j) = blobgray(i+1,j);
            end
        end
    end
end
%%贴完的标签的面积计算
area_label =zeros(254,1);
value =0;
count=0;
for i=1:width %行扫描
    for j=1:height %列扫描
        if( blobgray(i,j)~=0 &&(blobgray(i,j)~=255))
            value = blobgray(i,j);
            area_label(value,1) = area_label(value,1)+1;
        end
    end
end
for i=1:7
    fprintf('面积%d号为:%d piex\n',i,area_label(i));
end

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

%直方图自己计算
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
        if gray(i,j) == 0 % if( (当前数据 = 黑色)
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
value =0;
for i=1:width %行扫描
    for j=1:height %列扫描
        if( gray(i,j)~=0 &&(gray(i,j)~=255))
            value = gray(i,j);
            area_label(value,1) = area_label(value,1)+1;
        end
    end
end
fprintf('面积1号为:%d piex\n',area_label(1));
fprintf('面积2号为:%d piex\n',area_label(2));



