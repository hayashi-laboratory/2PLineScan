function [BF] = BF(ms,n_figure)
% BF=blood flow, RBC/minisecond
% ms=millisecton/pixel; n=number of line counted; n_figure= image_no.

% input XT line scans
im= imread(strcat('Image',num2str(n_figure),'.tif'));
im=im(:,:,2);

% display image with true aspect ratio
image(im);
axis image
hold on;

% find the point at the top of the 1st line (to X axis)
[x1,y1]=myginput(1,'cross');
plot(x1,y1,'r*','MarkerSize',12)

% Draw a line
plot([x1,x1],[1,500],'-r','Linewidth',1.2)

% find the point at the top of the 10th line
[x2,y2]=myginput(1,'cross');
plot(x2,y2,'r*','MarkerSize',12)

% enter number of lines (n)
promt='How many lines?'
n=input(promt);

% calculate the RBC/time(msec)
y=y2-y1;
time=abs(y)*1.3;
BF=(n-1)/time;

% when count all RBC, BF= n/500*1.3

saveas(gcf,strcat('Image',num2str(n_figure),'_BF'),'tif')
close
end

