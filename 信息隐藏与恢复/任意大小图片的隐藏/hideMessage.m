function [hided] = hideMessage(img1,img2)
    [width,height,bmgs]=size(img1); %获得图像的尺寸：宽度，高度
    mypicyiwei = reshape(img1,[],1); %%变为一维矩阵
    myxinxipic = img2;
    [width1,height1,bmgs1]=size(img2);
    myxinxipicyiwei = reshape(myxinxipic,[],1); %%变为一维矩阵
    [widthyy,bmgsyy]=size(myxinxipicyiwei); %获得图像的尺寸：宽度，高度
    
    width_bin=dec2bin(width1,16); %%转换为 16 位二进制
    height_bin=dec2bin(height1,16);
    s3=num2str(width_bin); %转换为字符串,待隐藏信息
    s4=num2str(height_bin); %转换为字符串,待隐藏信息
    for j=1:16
        quzhi3 = dec2bin(mypicyiwei(j),16); %%载体
        quzhi4 = dec2bin(mypicyiwei(j+16),16); %%载体
        s5=num2str(quzhi3); %转换为字符串 %%载体
        s6=num2str(quzhi4); %转换为字符串 %%载体
        s5(16)=s3(j); %对最后一位赋值
        s6(16)=s4(j); %对最后一位赋值
        tempzhi1 = bin2dec(s5);
        tempzhi2 = bin2dec(s6);
        mypicyiwei(j) = tempzhi1;
        mypicyiwei(j+16) = tempzhi2;
    end

    for i=1:widthyy
        quzhi=dec2bin(myxinxipicyiwei(i),8); %%转换为 8 位二进制
        s1=num2str(quzhi); %转换为字符串,待隐藏信息
        for j=1:8
            quzhi2 = dec2bin(mypicyiwei(8*(i+3)+j),8); %%载体
            s2=num2str(quzhi2); %转换为字符串 %%载体
            s2(8)=s1(j); %对最后一位赋值
            tempzhi = bin2dec(s2);
            mypicyiwei(8*(i+3)+j) = tempzhi;
        end
    end
    

    hided = reshape(mypicyiwei,width,height,bmgs);
    return
end