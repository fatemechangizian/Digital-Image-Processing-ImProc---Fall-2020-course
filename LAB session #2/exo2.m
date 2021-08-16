% EXO2
% FATEMEH CHANGIZIAN
% 13-10-2020

matr=ones(256,256)*64;
mx = 128;
S = 128 ;  % side of square2
matr((mx-S/2):(mx+S/2),(mx-S/2):(mx+S/2))=192;
%I = original Image in 0-255 range
I=uint8(matr);
% Creating noise with noise strength: 30
X = 30*rand(size(I));
%Add noise to the original image : noisy image
A=I+uint8(X);

subplot(2,3,1);imshow(I);title('Original Image', 'FontSize', 15);
subplot(2,3,2);imshow(A);title('Noisy Image', 'FontSize', 15);

C=fspecial('average',[3,3]);
Filteredimg = imfilter(A, C);
subplot(2,3,4);imshow(Filteredimg);title('Filtered Image with 3x3 avr filter', 'FontSize', 9);
C2=fspecial('average',[5,5]);
Filteredimg2 = imfilter(A, C2);
subplot(2,3,5);imshow(Filteredimg2);title('with 5x5 avr filter', 'FontSize', 9);
C3=fspecial('average',[9,9]);
Filteredimg3 = imfilter(A, C3);
subplot(2,3,6);imshow(Filteredimg3);title('with 9x9 avr filter', 'FontSize', 9);
figure;

Y = 100*rand(size(I));
%Add noise to the original image : noisy image
A1=I+uint8(Y);

subplot(2,3,1);imshow(I);title('Original Image', 'FontSize', 15);
subplot(2,3,2);imshow(A1);title('Noisy Image', 'FontSize', 15);

C=fspecial('average',[7,7]);
Filteredimg = imfilter(A1, C);
subplot(2,3,4);imshow(Filteredimg);title('Filtered Image with 7x7 avr filter', 'FontSize', 9);
C2=fspecial('average',[15,15]);
Filteredimg2 = imfilter(A1, C2);
subplot(2,3,5);imshow(Filteredimg2);title('with 15x15 avr filter', 'FontSize', 9);
C3=fspecial('average',[20,20]);
Filteredimg3 = imfilter(A1, C3);
subplot(2,3,6);imshow(Filteredimg3);title('with 20x20 avr filter', 'FontSize', 9);
