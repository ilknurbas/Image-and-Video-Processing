% İlknur Baş 
% Exercise 5
clc; close all; clear; 
% Question 1

image = zeros(128,128);
% a) Constant value 0.5 for whole image.
image_1 = image + 0.5;

% b) 20x20 white square in the middle.
image_2 = image;
image_2(55:74,55:74) = ones(20,20)*1;

% c) Ramp from 0 to 1 in horizontal axis, constant in vertical axis.
image_3 = image;
ramp = linspace(0,1,128)*255;
image_3 = uint8(repmat(ramp,128,1)); 

% d) Delta function at the center of the image.
% an image composed of all zeros, except for a single pixel
image_4 = image;
image_4(64,64) = 1;

% e) Cosine signal having four periods in both directions; (help meshgrid)
image_5 = image;

t = 0:1:127;
f = 1/32;
cosine = cos(2*pi*f*t);
[X,Y] = meshgrid(cosine);
image_5 = (X+Y)/2;

figure;
subplot(3,2,1); imshow(image); title('Original Image');
subplot(3,2,2); imshow(image_1); title('Constant value 0.5');
subplot(3,2,3); imshow(image_2); title('20x20 white square in the middle');
subplot(3,2,4); imshow(image_3); title('Ramp from 0 to 1 in horizontal axis');
subplot(3,2,5); imshow(image_4); title('Delta function at the center of the image.');
subplot(3,2,6); imshow(image_5); title('Cosine signal having four periods');

% Question 2

% a) Perform the 2D Fourier transform on all the images in task 1. 
figure;
subplot(3,2,1); imshow(dft(image)); title('Original Image');
subplot(3,2,2); imshow(dft(image_1)); title('Constant value 0.5');
subplot(3,2,3); imshow(dft(image_2)); title('20x20 white square in the middle');
subplot(3,2,4); imshow(dft(image_3)); title('Ramp from 0 to 1 in horizontal axis');
subplot(3,2,5); imshow(dft(image_4)); title('Delta function at the center of the image.');
subplot(3,2,6); imshow(dft(image_5)); title('Cosine signal having four periods');

% b)
% The output of dft shows the image in frequency domain. Normally, the
% image in the input is in the spatial domain. From the output, we
% understand the change of frequecies in each pixel that are in the spatial domain.

% c) Consider DFT images from task 1. Where is the energy concentrated and why?
% There is more energy towards brighter areas, brighter dots.

% Question 3
% when the high pass filter is applied, the edges are much more clear. The
% reason is that edges are the area where the differnce between pixels are
% much higher. The high pass filter passes those.
% Low-pass filter is the opposite. That's why we are seeing some kind of
% blur.

I = imread('cameraman.tif');
figure;
subplot(3,2,1:2); imshow(I); title('Image');
DO = 20; n = 2;

low_pass_filter = BWLPfilter(I, DO, n);
high_pass_filter = 1 - low_pass_filter;

subplot(3,2,3); imshow(low_pass_filter); title('low-pass filter');
subplot(3,2,4); imshow(high_pass_filter); title('high-pass filter');

% apply the filter to image
low_pass_filter_I =  filter_apply(I , low_pass_filter);
high_pass_filter_I = filter_apply(I , high_pass_filter);
subplot(3,2,5); imshow(low_pass_filter_I); title('Low-pass filter is applied');
subplot(3,2,6); imshow(high_pass_filter_I); title('High-pass filter is applied');
 




function g = filter_apply(image, filter)
    F = fft2(image);
    Fc = fftshift(F);
    G = filter.*Fc;
    gi = ifft2(ifftshift(G));
    g = real(gi);
    g = uint8(g);
end

function result = dft(image)
    % Obtain the Fourier transform
    F = fft2(image);
    % Move the zero-frequency component to the center of the matrix
    Fc = fftshift(F);
    % Fc has complex values. If you want to display the transform, 
    % you should take the absolute value. Also apply logarithm.
    % Because of log, magnitude gets smaller for higher frequencies. So we
    % can observe dft better. 
    % imshow(log(abs(Fc) + 0.0001)); 
    result = log(abs(Fc) + 0.0001);
    
end
 









