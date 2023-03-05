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
