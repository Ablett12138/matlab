%%灰度图像均衡化
% 显示直方图
I = imread('zftjh.jpg');
%显示原图
figure, subplot(2,2,1), imshow(I), title('zftjh')
subplot(2,2,2), imhist(I), title('zftjh的直方图') 

% 使用histeq进行直方图均衡化
I_eq = histeq(I, 256);
subplot(2,2,3), imshow(I_eq), title('均衡化的图') 
subplot(2,2,4), imhist(I_eq), title('均衡化后的直方图')
