% İlknur Baş 
% Exercise 9

% Question 1
clc; close all; clear; 

% Histogram equalization process images in order to adjust the contrast
% of an image by modifying the intensity distribution of the histogram.
I = imread('fruits.jpg');
red = I(:,:,1);
green = I(:,:,2);
blue = I(:,:,3); 

figure;
subplot(2,2,1); histeq(red);
subplot(2,2,2); histeq(green);
subplot(2,2,3); histeq(blue);
subplot(2,2,4); imshow(cat(3, histeq(red), histeq(green), histeq(blue)));

I2 = imread('festia.jpg');
red = I2(:,:,1);
green = I2(:,:,2);
blue = I2(:,:,3); 

figure;
subplot(2,2,1); histeq(red);
subplot(2,2,2); histeq(green);
subplot(2,2,3); histeq(blue);
subplot(2,2,4); imshow(cat(3, histeq(red), histeq(green), histeq(blue)));

intensityeq(I);
intensityeq(I2);

% there is too many white pixels thats why thats not also work.

% Question 2
lake = imread('lake.jpg');
hsv = rgb2hsv(lake);
hue = hsv(:,:,2); % saturation  
gray  = graythresh(hue); % threshold that minimizes the variance of the thresholded black and white pixels
binarize = im2bw(hue,gray); % Binarize image
label_matrix = bwlabel(binarize);
indc = (label_matrix==752);
% impixelinfo to find 752 
img = uint8(double(lake).* indc);
 
figure;
imshow(img);
 
 

% which takes as an input a color image in RGB color space, 
% converts it to HSV color space, 
% applies histogram equalization on the value component 
% and converts the image back to RGB color space. (rgb2hsv)
function convert_rgb = intensityeq(I)
    red = I(:,:,1);
    green = I(:,:,2);
    blue = I(:,:,3); 
    convert_I = cat(3, histeq(red), histeq(green), histeq(blue));   
    hsv = rgb2hsv(I);
    hsv(:,:,3) =  histeq(hsv(:,:,3));
    convert_rgb = hsv2rgb(hsv);

    figure;
    subplot(2,2,1); imshow(I);
    subplot(2,2,2); imshow(convert_I);
    subplot(2,2,3); imshow(hsv);
    subplot(2,2,4); imshow(convert_rgb);
 
end



