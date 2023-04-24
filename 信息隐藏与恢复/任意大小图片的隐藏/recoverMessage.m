function [recover] = recoverMessage(mypic)
    mypicyiwei = reshape(mypic,[],1); %%变为一维矩阵
    [width,bmgs]=size(mypicyiwei); %获得图像的尺寸：宽度，高度
    quzhi1 = dec2bin(0,16);
    quzhi2 = dec2bin(0,16);
    s1=num2str(quzhi1); %转换为字符串
    s2=num2str(quzhi2); %转换为字符串
    for j=1:16
        width_bin = dec2bin(mypicyiwei(j),16);
        height_bin= dec2bin(mypicyiwei(j+16),16);
        s3=num2str(width_bin); %转换为字符串
        s4=num2str(height_bin); %转换为字符串

        s1(j)=s3(16); %对最后一位取值
        s2(j)=s4(16); %对最后一位取值
    end
    width1 = bin2dec(s1)
    height1 = bin2dec(s2)

    pic = uint8(zeros(width1*height1,1));
    for i=1:width1*height1
        %转换为字符串
        quzhi3 = dec2bin(0,8);
        s1=num2str(quzhi3); %转换为字符串
        for j=1:8
            quzhi4 = dec2bin(mypicyiwei(8*(i+3)+j),8);
            s2=num2str(quzhi4); %转换为字符串
            s1(j)=s2(8); %对最后一位取值
        end
        tempzhi = bin2dec(s1);
        pic(i,1) = tempzhi;
    end
    recover = reshape(pic,width1,height1,1);
    return
end