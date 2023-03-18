%%任务9描述：
%  (1)对图“fankuaituzaosheng.bmp”灰度化
% （2）而后进行滤波，
% （3）而后阈值分割
% （4）而后计算目标物体的面积
img = imread('fankuaituzaosheng.bmp');

%matlab自带灰度化
matgary=rgb2gray(img);

% 使用3x3的中值滤波器进行滤波
img_medfilt = medfilt2(matgary, [3, 3]);

% 定义腐蚀结构元素，这里使用3x3的矩形
SE = strel('rectangle',[3 3]);

% 对二值图像进行膨胀操作
dilated_img = imdilate(img_medfilt, SE);
% 对二值图像进行腐蚀操作
eroded_img = imerode(dilated_img, SE);

%----阈值分割
mygray_thre=function3(eroded_img,10);

%计算面积
area=0;
[width,height,bmsize] = size(mygray_thre);%获得图片尺寸
for i=1:width
    for j=1:height
           if mygray_thre(i,j)==0
               area=area+1;
           end
    end
end
fprintf('图形面积为:%d piex\n',area);

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

%%中值滤波
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



%%--- 均值滤波
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
