% EXO1
% FATEMEH CHANGIZIAN
% 13-10-2020

img=imread('lena.png');
% compute Fourier Transform
FFT1=fft2(img);
FFT=fft2(FFT1);
imshow(uint8(abs(FFT)),[])
figure;
% shift in Fourier Domain
FFTshift=fftshift(FFT);
imshow(uint8(abs(FFTshift)),[])
%
% FFT spectrum of image
imgfft = uint8(log(1 + abs(FFTshift)));

% disply the original image and the spectrum in 2D and 3D
figure;
subplot(1, 2, 1);
imshow(img); title('Original Image','FontSize', 14);
subplot(1, 2, 2); 
imshow(imgfft, []); title('2D spectrum','FontSize', 14);
%
figure;
surf(uint8(log(1 + abs(FFTshift)))); title('3D spectrum','FontSize', 14);

% LOW PASS FILTER
% Create Low Pass Filter Masks with different Cut Off Frequency:

% LPFiltering with very low frequency:
mask = freqLPF(size(FFTshift), 0.05);
filtered1 = FFTshift.*mask;
Ifiltered1 = ifft2(ifftshift(filtered1));
slow = uint8(log(1 + abs(filtered1)));
imglow = uint8(Ifiltered1);

% LPFiltering with medium frequency:
mask = freqLPF(size(FFTshift), 0.2);
filtered2 = FFTshift.*mask;
Ifiltered2 = ifft2(ifftshift(filtered2));
smedium = uint8(log(1 + abs(filtered2)));
imgmedium = uint8(Ifiltered2);

% LPFiltering with high frequency:
mask = freqLPF(size(FFTshift), 0.6);
filtered3 = FFTshift.*mask;
Ifiltered3 = ifft2(ifftshift(filtered3));
shigh = uint8(log(1 + abs(filtered3)));
imghigh = uint8(Ifiltered3);

figure;
subplot(2,4,1);
imshow(img); title('original image');
subplot(2,4,2);
imshow(imglow); title('LPF:low cut off frequency: 0.05');
subplot(2,4,3);
imshow(imgmedium); title('LPF:medium cut off frequency: 0.2');
subplot(2,4,4);
imshow(imghigh); title('LPF:high cut off frequency: 0.6');

% show the low pass filtered spectrums 
subplot(2,4,5);
imshow(imgfft, []); title(' Image FT spectrum');
subplot(2,4,6);
imshow(slow, []); title(' LPF Fcut low spectrum');
subplot(2,4,7);
imshow(smedium, []); title(' LPF Fcut meduim spectrum');
subplot(2,4,8);
imshow(shigh, []); title(' LPF Fcut high spectrum');
%
% We can do the same for high pass filters

% HIGH PASS FILTER
% Create High Pass Filter Masks with different Cut Off Frequency:

% HPFiltering with very low frequency:
mask = freqHPF(size(FFTshift), 0.01);
filtered1 = FFTshift.*mask;
Ifiltered1 = ifft2(ifftshift(filtered1));
slow = uint8(log(1 + abs(filtered1)));
imglow = uint8(Ifiltered1);

% HPFiltering with medium frequency:
mask = freqHPF(size(FFTshift), 0.1);
filtered2 = FFTshift.*mask;
Ifiltered2 = ifft2(ifftshift(filtered2));
smedium = uint8(log(1 + abs(filtered2)));
imgmedium = uint8(Ifiltered2);

% HPFiltering with high frequency:
mask = freqHPF(size(FFTshift), 0.5);
filtered3 = FFTshift.*mask;
Ifiltered3 = ifft2(ifftshift(filtered3));
shigh = uint8(log(1 + abs(filtered3)));
imghigh = uint8(Ifiltered3);

figure;
subplot(2,4,1);
imshow(img); title('original Image');
subplot(2,4,2);
imshow(imglow); title('HPF:low cut off frequency: 0.01');
subplot(2,4,3);
imshow(imgmedium); title('HPF:medium cut off frequency: 0.1');
subplot(2,4,4);
imshow(imghigh); title('HPF:high cut off frequency: 0.5');

% show the high pass filtered spectrums
subplot(2,4,5);
imshow(imgfft, []); title(' Image FT spectrum');
subplot(2,4,6);
imshow(slow, []); title(' HPF Fcut low spectrum');
subplot(2,4,7);
imshow(smedium, []); title(' HPF Fcut medium spectrum');
subplot(2,4,8);
imshow(shigh, []); title(' HPF Fcut high spectrum');

