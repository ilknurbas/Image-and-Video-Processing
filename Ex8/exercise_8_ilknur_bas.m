% İlknur Baş 
% Exercise 8
clc; close all; clear; 
% 1. Image Blurring
I = double(imread('DIP.jpg')); 
[row, col]=size(I);
[u, v] = meshgrid(-row/2:row/2-1, -col/2:col/2-1);

% image to Fourier domain
Fc = fftshift(fft2(I));
% Create filter
const = 0.000001; a = 0.1; b= 0.1; T =1;
H = (T./(pi*(u*a+v*b)+const)).*(sin(pi*(u*a+v*b))).*exp(-1i*pi*(u*a+v*b));
% Multiply the transform by the filter matrix
G = H.*Fc;
%  Do inverse shifting and inverse transform
gi = ifft2(ifftshift(G));
% take the real part
g = real(gi); % this has the motion blured image

% now, apply inverse filter to the motion blured image
% trying to restore image
% again, take the image to Fourier domain 
Fc_ = fftshift(fft2(g));
% apply inverse filtering
restore = Fc_./(H + 0.001);
restore = real(ifft2(ifftshift(restore)));  %  this has the restored image

figure, 
subplot(1,3,1); imshow(I,[]); title('Original Image');
subplot(1,3,2); imshow(g,[]); title('motion blured');
subplot(1,3,3); imshow(restore,[]); title('restored ');

fprintf('error margin - blurred image %d \n',immse(I, g));
fprintf('error margin - restored image %d \n',immse(I, restore));

% 2. Image Restoration via Wiener Filtering
% a. Add noise to the blurred image (1b) with zero mean and a variance of 50. (help randn)
noise = sqrt(50)*randn(size(g));
blurred_w_noise = double(g)+ noise;

% b. Apply simple inverse filtering to the degraded image (2a).
Fc_ = fftshift(fft2(blurred_w_noise));
inv_blurred_w_noise = Fc_./(H + 0.0001); % apply inverse filtering
g1 = real(ifft2(ifftshift(inv_blurred_w_noise))); 

% c. Apply the Wiener filter:
% Sn power spectrum of noise
% Sf power spectrum of the original image 
Sf = abs(fftshift(fft2(I))).^2;
Sn = abs(fftshift(fft2(noise))).^2 ;
div = Sn./Sf;
g = fftshift(fft2(blurred_w_noise));
% filter is applied
wiener = (1./(H + 0.0001)).* ((abs(H).^2)./(abs(H).^2 + div)) .* g;
wiener_fil = real(ifft2(ifftshift(wiener)));  


figure, 
subplot(3,1,1); imshow(blurred_w_noise,[]); title('blurred image with noise');
subplot(3,1,2); imshow(g1,[]); title('inverse filtering to blurred image with noise');
subplot(3,1,3); imshow(wiener_fil,[]); title(' Wiener filtering to blurred image with noise');


% try div = 
div1 = 1/10;  
div2 = 1/100;  
div3 = 1/1000;  
wiener = (1./(H + 0.0001)).* ((H.^2)./(H.^2 + div1)) .* (g);
wiener_fil = real(ifft2(ifftshift(wiener)));  

wiener = (1./(H + 0.0001)).* ((H.^2)./(H.^2 + div2)) .* (g);
wiener_fil_2 = real(ifft2(ifftshift(wiener)));  

wiener = (1./(H + 0.0001)).* ((H.^2)./(H.^2 + div3)) .* (g);
wiener_fil_3 = real(ifft2(ifftshift(wiener)));  

figure, 
subplot(2,2,1); imshow(blurred_w_noise,[]); title('blurred image with noise');
subplot(2,2,2); imshow(wiener_fil,[]); title('Wiener filtering to blurred image with noise div1 = 1/10');
subplot(2,2,3); imshow(wiener_fil_2,[]); title('div2 = 1/100');
subplot(2,2,4); imshow(wiener_fil_3,[]); title('div3 = 1/1000');


