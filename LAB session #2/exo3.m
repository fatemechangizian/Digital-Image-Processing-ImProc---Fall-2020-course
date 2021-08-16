% EXO3
% FATEMEH CHANGIZIAN
% 13-10-2020

matr=ones(256,256)*64;
mx = 128;
S = 128 ;  % side of square2
matr((mx-S/2):(mx+S/2),(mx-S/2):(mx+S/2))=192;
%I = original Image in 0-255 range
I=uint8(matr);
% Creating noise with noise strength: 30
X = 30*rand(size(matr));
%Add noise to the original image
A=I+uint8(X);

subplot(2,3,1);imshow(I);title('Original Image', 'FontSize', 15);
subplot(2,3,2);imshow(A);title('Noisy Image', 'FontSize', 15);

Filteredimg = medfilt2(A);
subplot(2,3,4);imshow(Filteredimg);title('Filtered Image with 3x3 Median filter', 'FontSize', 9);

Filteredimg2 = medfilt2(A,[5 5]);
subplot(2,3,5);imshow(Filteredimg2);title('with 5x5 Med filter', 'FontSize', 9);

Filteredimg3 = medfilt2(A,[9 9]);
subplot(2,3,6);imshow(Filteredimg3);title('with 9x9 Med filter', 'FontSize', 9);

% comparison between the result of applying the average filter and the median filter:

figure;
C3=fspecial('average',[9,9]);
Filteredimg3 = imfilter(A, C3);
subplot(1,2,1);imshow(Filteredimg3);title('with 9x9 Average filter', 'FontSize', 12);

Filteredimg3 = medfilt2(A,[9 9]);
subplot(1,2,2);imshow(Filteredimg3);title('with 9x9 Median filter', 'FontSize', 12);
