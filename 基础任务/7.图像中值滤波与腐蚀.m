%%任务9描述：
%  (1)对图“fankuaituzaosheng.bmp”灰度化
% （2）而后进行滤波，
% （3）而后阈值分割
% （4）而后计算目标物体的面积
img = imread('fankuaituzaosheng.bmp');

%matlab自带灰度化
matgary=rgb2gray(img);

% 使用3x3的中值滤波器进行滤波
img_medfilt = medfilt2(matgary, [3, 1]);

% 定义腐蚀结构元素，这里使用3x3的矩形
SE = strel('rectangle',[3 3]);

% 对二值图像进行膨胀操作
dilated_img = imdilate(img_medfilt, SE);
% 对二值图像进行腐蚀操作
eroded_img = imerode(dilated_img, SE);

%----阈值分割
mygray_thre=function3(img_medfilt,128);

area_label=area_cal(mygray_thre);
fprintf('面积1号为:%d piex\n',area_label(1));
fprintf('面积2号为:%d piex\n',area_label(2));


% 在同一窗口中显示3个图像
figure% 打开一个新的窗口
subplot(1,3,1);
imshow(img);
title("1.原图");

subplot(1,3,2);
imshow(eroded_img);
title("2.滤波后的图像");

subplot(1,3,3);
imshow(mygray_thre);
title("3.阈值分割后的图像");

%%%%--------------------------------------------------------   函数阈值分割

%阈值分割
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

%%%%--------------------------------------------------------   函数中值滤波

function output_img = median_filter(input_img, filter_size)
% input_img为输入图像，filter_size为滤波器大小
% output_img为输出图像

% 将输入图像转换为灰度图像
if size(input_img, 3) == 3
    input_img = rgb2gray(input_img);
end

% 获取图像大小
[height, width] = size(input_img);

% 创建一个空的输出图像
output_img = zeros(height, width);

% 计算滤波器的半径
filter_radius = (filter_size - 1) / 2;

% 对每个像素进行滤波
for i = filter_radius + 1 : height - filter_radius
    for j = filter_radius + 1 : width - filter_radius
        % 获取滤波器内像素的中值
        filter_values = [];
        for k = -filter_radius : filter_radius
            for l = -filter_radius : filter_radius
                filter_values = [filter_values, double(input_img(i + k, j + l))];
            end
        end
        filter_median = median(filter_values);
        
        % 将中值赋给输出图像
        output_img(i, j) = filter_median;
    end
end

% 将输出图像转换为uint8类型
output_img = uint8(output_img);
end


%%%%--------------------------------------------------------   函数均值滤波

function output_img = mean_filter(input_img, filter_size)
% input_img为输入图像，filter_size为滤波器大小
% output_img为输出图像



% 获取图像大小
[height, width] = size(input_img);

% 创建一个空的输出图像
output_img = zeros(height, width);

% 计算滤波器的半径
filter_radius = (filter_size - 1) / 2;

% 对每个像素进行滤波
for i = filter_radius + 1 : height - filter_radius
    for j = filter_radius + 1 : width - filter_radius
        % 获取滤波器内像素的平均值
        filter_sum = 0;
        for k = -filter_radius : filter_radius
            for l = -filter_radius : filter_radius
                filter_sum = filter_sum + double(input_img(i + k, j + l));
            end
        end
        filter_avg = filter_sum / (filter_size .* filter_size);
        
        % 将平均值赋给输出图像
        output_img(i, j) = filter_avg;
    end
end

% 将输出图像转换为uint8类型
output_img = uint8(output_img);
end

%%%%--------------------------------------------------------   函数blob连通体计算

function  area_label = area_cal(gray)
%%面积计算
%%规避边界，防止溢出
biaoqian = 0;
[width,height,bmgs]=size(gray); %获得图像的尺寸：宽度，高度
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
return