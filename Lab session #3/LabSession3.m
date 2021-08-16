% Lab session 3: Edge detection
% FATEMEH CHANGIZIAN


% II. Pre-processing: de-noising

% A. Load the image and artificially add some noise:

img = imread('ic2.tif');
% Add Gaussian noise:
%imnoise(I,'gaussian',m,var_gauss) adds Gaussian white noise with mean m and variance var_gauss.
noisy_img = imnoise(img,'gaussian',0,0.04);

figure;
subplot(1,2,1);
imshow(img);
title('Original Image','FontSize', 15);
subplot(1,2,2);
imshow(noisy_img,[]);
title('Noisy Image','FontSize', 15);

%**************************************************************************
% B. De-noising the image:

% Apply average filter with 4 different filter sizes:
F1 = fspecial('average',[3,3]);
avr_filtered_image1 = imfilter(noisy_img, F1);

F2 = fspecial('average',[5,5]);
avr_filtered_image2 = imfilter(noisy_img, F2);

F3 = fspecial('average',[7,7]);
avr_filtered_image3 = imfilter(noisy_img, F3);

F4 = fspecial('average',[9,9]);
avr_filtered_image4 = imfilter(noisy_img, F4);

figure;
subplot(2,2,1);
imshow(avr_filtered_image1,[]);title('with 3x3 Average Filter');
subplot(2,2,2);
imshow(avr_filtered_image2,[]);title('with 5x5 Average Filter');
subplot(2,2,3);
imshow(avr_filtered_image3,[]);title('with 7x7 Average Filter');
subplot(2,2,4);
imshow(avr_filtered_image4,[]);title('with 9x9 Average Filter');


% Apply median filter with 4 different filter sizes:
med_filtered_image1 = medfilt2(noisy_img,[3 3]);
med_filtered_image2 = medfilt2(noisy_img,[5 5]);
med_filtered_image3 = medfilt2(noisy_img,[7 7]);
med_filtered_image4 = medfilt2(noisy_img,[9 9]);

figure;
subplot(2,2,1);
imshow(med_filtered_image1,[]);title('with 3x3 Median Filter');
subplot(2,2,2);
imshow(med_filtered_image2,[]);title('with 5x5 Median Filter');
subplot(2,2,3);
imshow(med_filtered_image3,[]);title('with 7x7 Median Filter');
subplot(2,2,4);
imshow(med_filtered_image4,[]);title('with 9x9 Median Filter');


% Apply wiener filter with 4 different filter sizes:
wn_filtered_image1 = wiener2(noisy_img,[3 3]);
wn_filtered_image2 = wiener2(noisy_img,[5 5]);
wn_filtered_image3 = wiener2(noisy_img,[7 7]);
wn_filtered_image4 = wiener2(noisy_img,[9 9]);

figure;
subplot(2,2,1);
imshow(wn_filtered_image1,[]);title('with 3x3 Wiener Filter');
subplot(2,2,2);
imshow(wn_filtered_image2,[]);title('with 5x5 Wiener Filter');
subplot(2,2,3);
imshow(wn_filtered_image3,[]);title('with 7x7 Wiener Filter');
subplot(2,2,4);
imshow(wn_filtered_image4,[]);title('with 9x9 Wiener Filter');

% Comparison between the results of applying average, median and wiener filter:
% ** Personally found 5x5 filter size more optimal than others.**
figure;
subplot(1,3,1);
imshow(avr_filtered_image2,[]);title('5x5 Average Filter','FontSize', 11);
subplot(1,3,2);
imshow(med_filtered_image2,[]);title('5x5 Median Filter','FontSize', 11);
subplot(1,3,3);
imshow(wn_filtered_image2,[]);title('5x5 Wiener Filter','FontSize', 11);

%{
After comparing different filters, I think the best result for noise reduction 
has been achieved with the Wiener Filter because it works reasonably well in a way that 
we can still see the edges with acceptable noise reduction. 
%}

% Therefore:
denoised_image = wn_filtered_image2;
figure;
subplot(2,1,1);
imshow(noisy_img,[]);title('Noisy Image','FontSize', 15);
subplot(2,1,2);
imshow(denoised_image,[]); title('Denoised Image with Wiener Filter size 5x5', 'FontSize', 11);
%%
%**************************************************************************
% III. Processing: low level feature detection

% A. Highlight edges

% Apply three different methods for edge detection: gradient, zero crossing of Laplacian and Canny edge detector.

% Part1: Gradient edges detection
% Vertical and horizontal components of the image's gradient:
% Creating horizontal and vertical axis gradient masks:
horizontal_mask =  [1 0 -1];
vertical_mask = transpose(horizontal_mask);

% Applying horizontal and vertical gradients to detect vertical and horizontal edges:
gradient_h = filter2(horizontal_mask,denoised_image);
gradient_v = filter2(vertical_mask,denoised_image);
% Compute the gradient magnitude:
gradient = sqrt(gradient_h.^2+gradient_v.^2);
%gradient=uint8(sqrt(double(gradientx.^2+gradienty.^2)));

figure;
subplot(1,3,1);
imshow(gradient_h,[]);title('Horizontal gradient');
subplot(1,3,2);
imshow(gradient_v,[]);title('Vertical gradient');
subplot(1,3,3);
imshow(gradient,[]);title('Gradient');

% Additinal Step for part1:
% Binarizing the image and performing morphological operations for making the edges more clearer:
%BW = im2bw(gradient,graythresh(gradient));
BW = imbinarize(gradient,(graythresh(gradient)*255));
% Creating more thin edges:
BW_morph = bwmorph(BW,'thin');
%{
figure;
subplot(1,2,1);
imshow(BW);
subplot(1,2,2);
imshow(BW_morph);
%}

% Part 2. Zero crossing of Laplacian

laplacian_mask = [0 1 0;1 -4 1;0 1 0];
lap_filtered = edge(denoised_image,'zerocross',0.5,laplacian_mask);

%laplacian=filter2(denoised_image,fspecial('laplacian'));
%laplacian=imbinarize(laplacian,graythresh(laplacian)*255);
%lap_filtered=bwmorph(laplacian,'thin');

% Part 3. Canny edge detector

canny_filtered = edge(denoised_image,'canny',0.5);

% Comparing the results of three different techniques to perform edge detection on denoised image:
figure;
subplot(1,3,1);
imshow(BW_morph,[]);title('Gradient');
subplot(1,3,2);
imshow(lap_filtered,[]);title('Laplacian Zero Crossing');
subplot(1,3,3);
imshow(canny_filtered,[]);title('Canny');
%{
As we can see in the results, the gradient and Laplacian zero crossing
methods aren't good enough for edge detection but on the other hand, 
"Canny edge detector" seems to perform better and more efficient than others.
%}
%%
%**************************************************************************
% B. Compute the Radon transform:
%
% Compute the Radon transform of the final edge image obtained in the previous step from Canny:
figure;
theta = 0: 179;
[R, xp] = radon (canny_filtered, theta);
R(:,1);
size(R)
imagesc (theta, xp, R);
title ('radon transform');
xlabel ('theta (degrees)');
set (gca, 'XTick', 0: 10: 180);
colormap (hot);
colorbar

%{
*How does the Radon transform relate to the Hough transform for lines?
We know the hough transform can associate each line of the image with a
pair (?, ?) point in Hough space. This point is the intersection of many curves and 
each curve represents a point of the image. We can clearly see several
intersects of the curves for theta=90 on the y-axis which represent horizontal 
edges and for theta around 0 and 180 which represent vertical edges of the image 
on the x-axis .
[?: Projection angle (in degrees)]

-The Hough transform and the Radon transform are indeed very similar to each other 
and their relation can be loosely defined as the former being a discretized form of the latter.
We can use the radon function to implement a form of the Hough transform used to detect straight lines.

-Specific features (geometries) in the original image produce peaks or collections of points.
Masks can be easily applied to the image within the Radon domain to determine 
if and where these specific features occur.
%}

%**************************************************************************
% IV. Post-processing: high level detection & interpretation

%{
 A. Choose points in Radon transform and observe associated lines:
FUNCTION interactiveLine(imgEdge,imgRadon,N);
   Parameters:
     - imgEdge: Edge image
     - imgRadon: Radon transform of imgEdge
     - N: Number of lines to be drawn
so I use:
interactiveLine(canny_filtered,R,3)
For points near Theta = 90, the associated lines are horizontal. For points 
near Theta = 180, the associated lines are vertical.

%}
%%
%**************************************************************************
% B. Find the image orientation and rotate it
%
V = max(R)
% Summing the vertical and horizontal lines for a better estimate of the true rotation angle.
V(1:90)
V_orth = V(1:90) + V(91:180)
indexsum = find(V_orth == max(V_orth))

%{
Since we look for two main directions (orthogonal), we need to look for 
the highest value of the sum of the V vector, from 0-89 and from 90-179
to find out which two orthogonal directions have more edges in the image.
%}
%%
figure;
subplot(2,1,1);
plot(V); title('Full vector');
subplot(2,1,2);
plot(V_orth); title('Sum of orthogonal components');

%{
 We know the locations of peaks in the radon transform correspond to the locations of 
 straight lines in the original image.
 -In V plot, as we can see there are 2 main peaks value for angle(theta)=88 and 
 for angle=180 which means that most of the image edges are in these two directions.
 -In the V_orth plot, we see only one peak value at angle=88 which means the two
 orthogonal directions with most edges are 88 and 88+90. So we rotate the original
 image with the angle = -88  so that the image edges, appear horizontal and vertical.
%}
rotated_image = imrotate(denoised_image,-indexsum);

figure;
subplot(1,2,1);
imshow(noisy_img,[]); title('Original Image with Noise');
subplot(1,2,2);
imshow(rotated_image,[]); title('Registered Image');

% For Advance question in Step 6:
% Increasing the strength of the noise in Step 1 and observe when the rotation angle
% fails to be estimated correctly
noisy_img2 = imnoise(img,'gaussian',0,0.1);
denoised_image2 = wiener2(noisy_img2,[5 5]);
rotated_image2 = imrotate(denoised_image2,-indexsum);

noisy_img3 = imnoise(img,'gaussian',0,0.9);
denoised_image3 = wiener2(noisy_img3,[5 5]);
rotated_image3 = imrotate(denoised_image3,-indexsum);

figure;
subplot(2,2,1);
imshow(noisy_img,[]); title('Original Noisy Image');
subplot(2,2,2);
imshow(rotated_image,[]); title('Registered with Gaussian noise var=0.04');
subplot(2,2,3);
imshow(rotated_image2,[]); title('Registered with G noise var=0.1');
subplot(2,2,4);
imshow(rotated_image3,[]); title('Registered with G noise var=0.9');

%{
Although by increase the noise strength, we have blurred image even after
preprocessing, the orientation process and the computation of the rotation angle 
is still works well since the Canny edge detector is capable of detecting edges anyway.
%}
