clc, clear all, close all;

% Question 2
lena  = imread('lena.tiff');
lena_hsi = rgb2hsi(lena); % convert it to HSI color space

% a
figure;
subplot(2,3,1); imshow(lena(:,:,1),[]);
subplot(2,3,2); imshow(lena(:,:,2),[]);
subplot(2,3,3); imshow(lena(:,:,3),[]);
% H, S, I
subplot(2,3,4); imshow(lena_hsi(:,:,1),[]);
subplot(2,3,5); imshow(lena_hsi(:,:,2),[]);
subplot(2,3,6); imshow(lena_hsi(:,:,3),[]);

% b
green_noise = imnoise(lena(:,:,2),'Gaussian');
lena_noise = cat(3,lena(:,:,1), green_noise, lena(:,:,3));
lena_noise_hsi = rgb2hsi(lena_noise);

figure;
subplot(2,2,1); imshow(lena_noise);
subplot(2,2,2); imshow(lena_noise_hsi(:,:,1),[]);
subplot(2,2,3); imshow(lena_noise_hsi(:,:,2),[]);
subplot(2,2,4); imshow(lena_noise_hsi(:,:,3),[]);

%c
red_noise = imnoise((lena(:,:,1)),'Gaussian');
blue_noise = imnoise((lena(:,:,3)),'Gaussian');
lena_noise_all = cat(3,red_noise,green_noise,blue_noise);

lena_noise_all_hsi = rgb2hsi(lena_noise_all);
 
figure;
subplot(2,2,1); imshow(lena_noise_all);
subplot(2,2,2); imshow(lena_noise_all_hsi(:,:,1),[]);
subplot(2,2,3); imshow(lena_noise_all_hsi(:,:,2),[]);
subplot(2,2,4); imshow(lena_noise_all_hsi(:,:,3),[]);

%d
% there is no arithmetic  
filter = fspecial("average",3);
% apply filter to noise 
red = imfilter(lena_noise_all_hsi(:,:,1),filter);
green = imfilter(lena_noise_all_hsi(:,:,2),filter);
blue = imfilter(lena_noise_all_hsi(:,:,3),filter);
% new_hsi = cat(3,lena_noise_all_hsi(:,:,1), lena_noise_all_hsi(:,:,2), blue);
new_hsi = cat(3,red, green, blue);

new_rgb = hsi2rgb(new_hsi); 

figure;
subplot(1,3,1); imshow(lena);
subplot(1,3,2); imshow(new_hsi);
subplot(1,3,3); imshow(new_rgb);
 




 