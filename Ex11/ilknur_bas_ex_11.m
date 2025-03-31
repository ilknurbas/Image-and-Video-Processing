% İlknur Baş
% exercise 11
clc, clear all, close all;

% Question 1
% YUV: luma, blue projection, , red projection 
% a
yuvdata = load('yuvdata.mat');
% yuvdata.cols, yuvdata.rows, yuvdata.yy, yuvdata.uu, yuvdata.vv
yuvdata.cols * yuvdata.rows; % 230400
size(yuvdata.yy); % 230400           1
size(yuvdata.uu); % 57600           1
size(yuvdata.vv); %  57600           1

% b
% Reshape the components yy, uu and vv to the given image size (reshape), 
yy_reshaped = reshape(yuvdata.yy, [yuvdata.cols, yuvdata.rows]);
size(yy_reshaped); % 640   360

% upsampling as necessary (imresize)
% 230400 / 4 = 57600
uu_reshaped = reshape(yuvdata.uu, [yuvdata.cols/2, yuvdata.rows/2]);
uu_reshaped = imresize(uu_reshaped, 2);
size(uu_reshaped); % 640   360

vv_reshaped = reshape(yuvdata.vv, [yuvdata.cols/2, yuvdata.rows/2]);
vv_reshaped = imresize(vv_reshaped, 2);
size(vv_reshaped); % 640   360

% Display the components in a 1x3 subplot to verify the result.
figure(1);
subplot(3,1,1); imshow(uint8(transpose(yy_reshaped)));
subplot(3,1,2); imshow(uint8(transpose(uu_reshaped)));
subplot(3,1,3); imshow(uint8(transpose(vv_reshaped)));

% c
% Center the U and V components around zero by subtracting 127 (note the data type).
uu_centered = uu_reshaped - 127;
vv_centered = vv_reshaped - 127;

% d
% Flatten and concatenate the components for conversion to RGB:
YUV = cat(2,yy_reshaped(:),uu_centered(:),vv_centered(:));

% e
% Perform the transformation from YUV to RGB with the matrix given above:
YuvToRgb = [1 0 1.402; 1 -0.34413 -0.71414; 1 1.772 0];
RGB = YuvToRgb*(YUV)';

% f) 
% Reshape each component back to the image size and produce the RGB image. 
red = reshape(RGB(1,:), [yuvdata.cols,yuvdata.rows]);
green = reshape(RGB(2,:), [yuvdata.cols,yuvdata.rows]);
blue = reshape(RGB(3,:), [yuvdata.cols,yuvdata.rows]);
rgb_ = cat(3,transpose(red), transpose(green), transpose(blue));
% Show the result via imshow.
figure(2);
imshow(uint8(rgb_));

 

% Question 2
% a) Load the RGB image lena.tiff and 
% convert it to YCbCr colorspace (use built-in function rgb2ycbcr). 
lena = imread('lena.tiff');
lena_ycbcr = rgb2ycbcr(lena);
% Display Y, Cb and Cr in a 1x3 subplot.
figure(3);
subplot(1,3,1); imshow(lena_ycbcr(:,:,1));
subplot(1,3,2); imshow(lena_ycbcr(:,:,2));
subplot(1,3,3); imshow(lena_ycbcr(:,:,3));

% b) % c) 
% Perform subsampling of the chrominance components: 4:2:2, 4:1:1, 4:2:0. 
% Upsample the same components back to the original resolution (imresize)
% recombine them and convert the images back to RGB (ycbcr2rgb).
size(lena); % ans = 512   512     3
y_lena = lena_ycbcr(:,:,1);
cb = lena_ycbcr(:,:,2);
cr = lena_ycbcr(:,:,3);

% 4:2:2
cb_422 = cb(:,1:2:end); cb_422 = imresize(cb_422, [512, 512]);
cr_422 = cr(:,1:2:end); cr_422 = imresize(cr_422, [512, 512]);
rgb_422 = ycbcr2rgb(cat(3, y_lena, cb_422, cr_422));

% 4:1:1
cb_411 = cb(:,1:4:end); cb_411 = imresize(cb_411, [512, 512]);
cr_411 = cr(:,1:4:end); cr_411 = imresize(cr_411, [512, 512]);
rgb_411 = ycbcr2rgb(cat(3, y_lena, cb_411, cr_411));

% 4:2:0
cb_420 = cb(1:2:end,1:2:end); cb_420 = imresize(cb_420, [512, 512]);
cr_420 = cr(1:2:end,1:2:end); cr_420 = imresize(cr_420, [512, 512]);
rgb_420 = ycbcr2rgb(cat(3, y_lena, cb_420, cr_420));

% Separately also perform subsampling on the luminance component, 
% following the format 4:1:1. 
% (Hint: you can use MATLAB indexing with a given step size to avoid for-loops.)
y_411 = y_lena(:,1:4:end); y_411 = imresize(y_411, [512, 512]);
rgb_y_411 = ycbcr2rgb(cat(3, y_411, cb, cr)); 


% Show the five RGB images (the original and 4 subsampled ones) together on a subplot. 
% is there a perceptible difference?
figure(4);
subplot(3,2,1:2); imshow(lena); title('Original');
subplot(3,2,3); imshow(rgb_422); title('rgb422'); immse(lena,rgb_422)
subplot(3,2,4); imshow(rgb_411); title('rgb411'); immse(lena,rgb_411)
subplot(3,2,5); imshow(rgb_420); title('rgb420'); immse(lena,rgb_420)
subplot(3,2,6); imshow(rgb_y_411); title('rgby411'); immse(lena,rgb_y_411)

% There is much changes in rgb_y_411 compared to others, the error values
% also shows that.



