%opens a jpg file and outputs .mif file for quartus 13 rom. 
clear;

%loads the picture and gets its size
img = imread('flappybird.png');
%output file
fid = fopen('flappybird.mif','w');
img2=img;

height=size(img,1);
width=size(img,2);


count = 0;
if (fid)
    % Print Header Files
    fprintf(fid,'WIDTH = 12;\n');
    fprintf(fid,'DEPTH = %d;\n',height*width);
    fprintf(fid,'ADDRESS_RADIX = HEX;\n');
    fprintf(fid,'DATA_RADIX = BIN;\n');
    fprintf(fid,'CONTENT BEGIN\n\n');
    
for row=1:height
    for col=1:width
        %gets each r g b in 8 bit value each
        R = img(row,col,1);
        G = img(row,col,2);
        B = img(row,col,3);
        %convert each to binary
        Rb = dec2bin(R,8);
        Gb = dec2bin(G,8);
        Bb = dec2bin(B,8);
        img2(row,col,1) = bin2dec([Rb(1:4) '0000']);
        img2(row,col,2) = bin2dec([Gb(1:4) '0000']);
        img2(row,col,3) = bin2dec([Bb(1:4) '0000']);
        %concatenate to 8 bit to represent all 3 colours
        Outbyte = [Rb(1:4) Gb(1:4) Bb(1:4)];
        %address in hex 
        fprintf(fid,'%x  : ',count);
        %pixel data in binary
        fprintf(fid,'%s ;\n',Outbyte);
        %print a new line every time a row is finished
        if (col == width)
        fprintf(fid,'\n');
        end
        %next pixel
        count=count+1;
    end    
end 
    fprintf(fid,'END;\n');
    fclose(fid);
    
    %output a compressed picture
    imwrite(img2,'output.png');
end
    