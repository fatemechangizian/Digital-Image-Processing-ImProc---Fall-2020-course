% Fatemeh Changizian
% 04-10-2020
% Lab 01
%% II.A. Squares:
%At first, I define a 1024*1024 square with graylevel 32:

matr=uint8(ones(1024,1024)*32);
imshow(matr)
hold on 
%{
Then, I choose a 512*512 square matrix in the center of the previous one 
and we replace value=64 instead of 32 to create a new square image matrix 
with graylevel 64.
%}

mx = 512;
S = 512 ;  % side of square2
matr((mx-S/2):(mx+S/2), (mx-S/2):(mx+S/2))=64;
imshow(matr)

%{
After that, I choose a 256*256 square matrix in the center and we replace 
value=128 to create a new square image matrix with graylevel 128.
%}
S = 256 ;  % side of square3 
matr((mx-S/2):(mx+S/2), (mx-S/2):(mx+S/2))=128;
imshow(matr)

%{
At the end, I resize the input image to make it 128*128 dimension and assign image
value to the 128*128 centered square.
%}

img=imread('lena.tif');
img2=imresize(img,0.5);
S = 128; % side of square4
matr((mx-S/2):(mx+S/2)-1, (mx-S/2):(mx+S/2)-1) = img2;
imshow(matr);
a=title('II.A.Centered squares with different gray levels including an image:', 'Color','magenta');
a.FontSize = 12;
hold off
%% III Mosaic:

%At first, I create a 1024*1024 square matrix:

matr=uint8(zeros(1024,1024));
img=imread('Lenna.jpg');

% matr1:Original image matrix
%matr1= matr(1:size(img,1), 1:size(img,1))+img(:,:,:);

%{
"matr2" is in the Upper right corner of the output "matr" image which is
blue channel image after a vertical flip.
%}
VflipImg = flipud(img);
vide=uint8(zeros(size(VflipImg,1),size(VflipImg,2)));
B=cat(3,vide,vide,VflipImg(:,:,3));
%matr2= matr(1:size(B,1), 1:size(B,1))+B(:,:,:);

%{
"matr3" is in the Lower left corner of the output "matr" image which is
 red channel after an horizontal flip.
%}
HflipImg = fliplr(img);
vide=uint8(zeros(size(HflipImg,1),size(HflipImg,2)));
R=cat(3,HflipImg(:,:,1),vide,vide);
%matr3= matr(1:size(R,1), 1:size(R,1))+R(:,:,:);

%{
"matr4" is in the Lower right corner of the output "matr" image which is
 green channel after both flips.
%}

HVflipImg = fliplr(VflipImg);
vide=uint8(zeros(size(HVflipImg,1),size(HVflipImg,2)));
G=cat(3,vide,HVflipImg(:,:,2),vide);
%matr4= matr(1:size(G,1), 1:size(G,1))+G(:,:,:);

% matr: A mosaic (concatenation of matr1 to matr4)with the different color channels of the Lenna image.
%matr=[matr1 matr2;matr3 matr4];
matr=[img B;R G];
imshow(matr);
b=title('III.Mosaic with the different color channels of the Lenna image', 'Color','magenta');
b.FontSize = 12;
%% III.A. 3D image:
img=imread('IMG_7768.jpg');
img2=imresize(img,0.1);

%Computing intensity means convert RGB image to grayscale image, so, first convert the image to grayscale.
grayImg=rgb2gray(img2);

% To create a three-dimensional surface plot of image and the line style property of the surface is none. 
surf(grayImg, 'LineStyle', 'none')

%{
This line maps 0 to a display intensity of 0 and the highest value in the array 
to white with a display intensity of 255, with the numbers of the array in 
between mapped to display between the grayscale range 0-255.
%}
colormap(jet(256))
title('III.A.Lenna image as a 3D surface:');
%% III.B. Bitplane slicing
image = imread('Lenna.jpg');

%{
Pixel value of grayscale image lies between 0 -255, so its information is 
contained using 8 bit. So, we can divide those image into 8 planes (8 Binary Image).
%}
grayImg=rgb2gray(image);

% Extracting bit-plane from Grayscale image.Bit Planes from 1 to 8. Output Format: Binary
% Takes image with type double as it ranges between [0, 1]
img = double(grayImg);
% With mod() operation, we can extract a bit-plane image. The mod(img,2) gives either 0 or 1:
% bit-plane 0:
bp0 = mod(img,2);
% For the next bit-plane, I do the same operation except do it after shifting the bit using floor():
bp1 = mod(floor(img/2),2);
bp2 = mod(floor(img/4),2);
bp3 = mod(floor(img/8),2);
bp4 = mod(floor(img/16),2);
bp5 = mod(floor(img/32),2);
bp6 = mod(floor(img/64),2);
bp7 = mod(floor(img/128),2);
% Concatenate Binary matrices
B=[bp0 bp1 bp2 bp3; bp4 bp5 bp6 bp7];
%{
converts B into an array of logical values. Any nonzero element of B is 
converted to logical 1 (true) and zeros are converted to logical 0 (false).
%}
imshow(logical(B));
title('III.B.Mosaic containing the bitplanes of the pixel values of Lenna image:');
