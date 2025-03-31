% İlknur Baş 
% Exercise 7
clc; close all; clear; 
% 1. Noise generation and restoration
image = imread('golden.jpg');
I = rgb2gray(image);

% a) Gaussian noise 
m = 0.1;
I1 = imnoise(I,'gaussian', m); % noise with mean m and variance of 0.01

% b)  Salt & pepper noise
d = 0.1;
I2 = imnoise(I,'salt & pepper',d); % noise with noise density of d

% c) Rayleigh noise:
b = 4000;
[height, width] = size(I);
noise = sqrt(-b*log((1-rand(height,width))));
I3 = uint8(double(I) + noise);

figure, 
subplot(2,2,1); imshow(image); title('Original Image');
subplot(2,2,2); imshow(I1); title('Image with Gaussian noise');
subplot(2,2,3); imshow(I2); title('Image with Salt & pepper noise ');
subplot(2,2,4); imshow(I3); title('Image with Rayleigh noise');


% 2. Restoration of Noisy Images
m =5 ; n=5; % filter size 
eps = 1;
% for I1 with gaussian
% a) Geometric mean filter:
geo_1 = exp(imfilter(log(double(I1)),ones(m,n),'replicate')).^(1/(m*n));
% b) Arithmetic mean filter:
arit_1 = imfilter(I1,fspecial('average',[m n]));
% c) Harmonic mean filter:
harm_1 = (m*n) ./ imfilter(1 ./ (double(I1) + eps), ones(m, n), 'replicate');
 
figure, 
subplot(2,2,1); imshow(I1); title('Image I1 with gaussian noise');
subplot(2,2,2); imshow(uint8(geo_1)); title('Geometric mean filter is applied');
subplot(2,2,3); imshow(uint8(arit_1)); title('Arithmetic mean filter is applied ');
subplot(2,2,4); imshow(uint8(harm_1)); title('Harmonic mean filter is applied ');

% for I2 with Salt & pepper noise
% a) Geometric mean filter:
geo_2 = exp(imfilter(log(double(I2)),ones(m,n),'replicate')).^(1/(m*n));
% b) Arithmetic mean filter:
arit_2 = imfilter(I2,fspecial('average',[m n]));
% c) Harmonic mean filter:
harm_2 = (m*n) ./ imfilter(1 ./ (double(I2) + eps), ones(m, n), 'replicate');
 
figure, 
subplot(2,2,1); imshow(I2); title('Image I2 with Salt & pepper noise');
subplot(2,2,2); imshow(uint8(geo_2)); title('Geometric mean filter is applied');
subplot(2,2,3); imshow(uint8(arit_2)); title('Arithmetic mean filter is applied ');
subplot(2,2,4); imshow(uint8(harm_2)); title('Harmonic mean filter is applied ');

% for I3 with Rayleigh noise:
% a) Geometric mean filter:
geo_3 = exp(imfilter(log(double(I3)),ones(m,n),'replicate')).^(1/(m*n));
% b) Arithmetic mean filter:
arit_3 = imfilter(I3,fspecial('average',[m n]));
% c) Harmonic mean filter:
harm_3 = (m*n) ./ imfilter(1 ./ (double(I3) + eps), ones(m, n), 'replicate');
 
figure, 
subplot(2,2,1); imshow(I3); title('Image I3 with Rayleigh noise');
subplot(2,2,2); imshow(uint8(geo_3)); title('Geometric mean filter is applied');
subplot(2,2,3); imshow(uint8(arit_3)); title('Arithmetic mean filter is applied ');
subplot(2,2,4); imshow(uint8(harm_3)); title('Harmonic mean filter is applied ');

% Arithmetic: blurs the image to get rid of the noice
% Geometric: compared to arithmetic blurs the image less
% Harmonic: fails for pepper

% 3. Noise cleaning with Weighted Median Filter

A = imread('golden.jpg');
A_1 = rgb2gray(A);
d = 0.09;
A_2 = imnoise(A_1,'salt & pepper',d); 


weight_kernel = ones(5);
weight_kernel(3,3)=10;
fun=@(x)  median(repelem(x(:),weight_kernel(:))); % adding more elements
% applies the function fun to each m-by-n sliding block of the grayscale image A
weighted_median = nlfilter(A_2,[5 5],fun) ;

fun2=@(x)  median(x(:));
median_ = nlfilter(A_2,[5 5],fun2) ;

figure, 
subplot(2,2,1); imshow(A_1); title('Original Image');
subplot(2,2,2); imshow(uint8(A_2)); title('Image with salt & pepper noice');
subplot(2,2,3); imshow(uint8(median_)); title('Image with median filter ');
subplot(2,2,4); imshow(uint8(weighted_median)); title('Image with weighted median filter (WMF)');












