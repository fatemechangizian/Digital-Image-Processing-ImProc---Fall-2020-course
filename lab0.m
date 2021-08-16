img=imread('Lenna.jpg');
subplot(2,2,1);imshow(img);title('ORIGINAL');
R=img(:,:,1);
G=img(:,:,2);
B=img(:,:,3);
subplot(2,2,2);imshow(R);title('canal RED');
subplot(2,2,3);imshow(G);title('canal GREEN');
subplot(2,2,4);imshow(B);title('canal BLUE');
%% OR OR OR
img=imread('Lenna.jpg');
size(img);
vide=uint8(zeros(size(img,1),size(img,2)));
subplot(2,2,1);imshow(img);title('ORIGINAL');
R=cat(3,img(:,:,1),vide,vide);
G=cat(3,vide,img(:,:,2),vide);
B=cat(3,vide,vide,img(:,:,3));
subplot(2,2,2);imshow(R);title('canal RED');
subplot(2,2,3);imshow(G);title('canal GREEN');
subplot(2,2,4);imshow(B);title('canal BLUE');
%Save image
imwrite(B,'blue.png')
%%
img=imread('Lenna.jpg');
ImgScaled=imresize(img,1.5,'bilinear');
figure;
imshowpair(img,ImgScaled,'montage')
axis off

ImgROtate=imrotate(img,135,'bilinear');
figure;
imshow(ImgROtate);title('Rotated image');
%
figure;
[J, rect] =imcrop(img);
imshow(J);title('Cropped image');
%%
rgb=imread('Lenna.jpg');
gra_eqImg=rgb2gray(rgb);
figure;
imshow(gra_eqImg)
%
%[count,x]=imhist(rgb,256);
figure;
imhist(rgb,256);
cum=cumsum(count);
figure;
subplot(1,2,1);plot(x,count);
subplot(1,2,2);plot(x,cum);
%%
img=imread('Lenna.jpg');

%subplot(1,2,1);imshow(img);title('ORIGINAL image');
eqImg=histeq(img,256);
figure;
imshowpair(img,eqImg,'montage')
axis off
figure;
imhist(eqImg,256)
%subplot(1,2,2);imshow(eqImg);title('Equalized image');

%% Gaussian Filter
img=imread('lena.tif');


%filter=fspecial('gaussian',5,1);
%h = fspecial('gaussian',hsize,sigma) returns a rotationally symmetric Gaussian lowpass filter of size hsize with standard deviation sigma.
%imgf=filter2(filter,img);

%imgf = imgaussfilt(img,1);

filter = fspecial('gaussian',5,1);
imgfilter = imfilter(img,filter);

diff=double(imgfilter)-double(img);
subplot(1,3,1);imshow(img);title('ORIGINAL image');
%subplot(1,3,2);imshow(imgf);title('Filtered image');
subplot(1,3,2);imshow(imgfilter);title('Filtered image');
subplot(1,3,3);imshow(diff,[]);title('Difference image');

%%
img=imread('cameraman.tif');

imgf = medfilt2(img);

diff=double(imgf)-double(img);
subplot(1,3,1);imshow(img);title('ORIGINAL image');
subplot(1,3,2);imshow(imgf);title('Filtered image');
subplot(1,3,3);imshow(diff,[]);title('Difference image');
%%
img=imread('Lenna.jpg');
size(img);
grayimg=rgb2gray(img);
size(grayimg);
imgNlf = nlfilter(grayimg,[5 5],'std2');

diff=double(imgNlf)-double(grayimg);
subplot(1,3,1);imshow(img);title('ORIGINAL image');
subplot(1,3,2);imshow(imgNlf);title('Filtered image');
subplot(1,3,3);imshow(diff,[]);title('Difference image');
%%
img=imread('lena.tif');
FTimg=fft2(img);
trans=fftshift(FTimg);
subplot(1,2,1);imshow(img);title('ORIGINAL image');
subplot(1,2,2);imshow(log(abs(trans)+1),[]);title('FT image');
%%
img=imread('lena.tif');
trans=dct2(img);
subplot(1,3,1);imshow(img);title('ORIGINAL image');
subplot(1,3,2);imshow(log(abs(trans)+1),[]);title('DCT image');
trans2=blkproc(img,[8 8],'dct2(x)');
subplot(1,3,3);imshow(log(abs(trans2)+1),[]);title('8by8 DCT image');
%%
img=imread('lena.tif');
mosaic=blkproc(img,[8 8],'uint8(mean(x(:))*ones(8,8))');
subplot(1,2,1);imshow(img);title('ORIGINAL image');
subplot(1,2,2);imshow(mosaic);title('mosaic image');