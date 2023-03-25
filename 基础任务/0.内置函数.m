%%%%--------------------------------------------------------   函数说明：颜色识别函数

function [color] = function1(tu)
% 函数说明：颜色识别函数
% 函数体
    red=0;
    green=0;
    yellow=0;
    %% 依次判断三幅图的颜色
    for i = 1:size(tu,1)
      for j = 1:size(tu,2)
               if tu(i,j,1)>=200&&tu(i,j,2)<=50&&tu(i,j,3)<=50          %这里的200 和50可以根据具体情况进行设置
                red=red+1;
               elseif tu(i,j,1)>=200&&tu(i,j,2)>=200&&tu(i,j,3)<=50
                 yellow=yellow+1;
               elseif tu(i,j,2)>=200&&tu(i,j,1)<=100&&tu(i,j,3)<=100
               green=green+1;
               end
      end
    end
    
    if max(max(red,yellow),green)==red
        color = 'red';
    elseif max(max(red,yellow),green)==yellow
        color='yellow';
    elseif max(max(red,yellow),green)==green
        color='green';
    end


    return 
    
end

%%%%--------------------------------------------------------   灰度直方图函数

function [myzjhist] = function2(img)
    [width,height,bmgs]=size(img);
    %获得图像的尺寸:宽度，高度
    myzjhist= zeros(256,1);
    %自己定义一个直方图
    myquzhi=0;
    %该点图像灰度值
    for i=1:width
        %循环处理
        for j=1:height
            myquzhi = img(i,j);
            myzjhist(myquzhi+1,1) = myzjhist(myquzhi+1,1)+1; %该灰度的直方图取值+1
        end
    end
    return 
end



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

%%%%--------------------------------------------------------   函数blob连通体面积计算

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
