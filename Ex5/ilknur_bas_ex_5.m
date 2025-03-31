% İlknur Baş
clc; close all; clear; 

% Part 1 
I = imread('cameraman.tif');
figure;
subplot(2,2,1); imshow(I); title('Original Image');

A = zeros(1,3);
% this is the ideal way, we are observing what change happens when the
% center value is changed. When 8, we can easily see the sharp edges, but
% not in the other ones.
A(1,1) = 8; 
A(1,2) = 9;
A(1,3) = 9.7;
[row,col] = size(A);
for i=1:col
    filter = [-1 -1 -1; -1, A(1,i), -1; -1 -1 -1];
    image = imfilter(I, filter);
    subplot(2,2,i+1); imshow(image); title("Filtered image, center value " + A(1,i));
end

% Part 2
% Part 2a
% randn return normalized values between 0 and 1
noise_image = I + uint8(10 * randn(size(I)));
figure;
subplot(1,2,1); imshow(I); title('Original Image');
subplot(1,2,2); imshow(noise_image); title('Noisy Image');

% Part 2b
result_1 = directional_filtering(noise_image, 3);
result_2 = directional_filtering(noise_image, 5);
result_3 = directional_filtering(noise_image, 7);
% According to the degree, we have seen changes(bluring effect) to that 
% direction. For instance, in the plot for 45, there is a bluring
% diagonally. This effect of change can been much more clearly when the 
% filter size is 7.

% Part 2c
% now the blurness is not just in one direction but the whole image.
figure;
subplot(2,2,1); imshow(I); title('Original Image');
subplot(2,2,2); imshow(result_1); title('Combination of filters when filter size is 3');
subplot(2,2,3); imshow(result_2); title('Combination of filters when filter size is 5');
subplot(2,2,4); imshow(result_3); title('Combination of filters when filter size is 7');

% Part 3
% Part 3a
A = imread('miranda1.tif');
[row,col] = size(A); % 400x400
noise = uint8(10 * randn(100)); 
A(151:row-150, 151:col-150) = A(151:row-150, 151:col-150) + noise;

% Part 3b
figure;
subplot(2,2,1); imshow(A); title('Noisy Image');
subplot(2,2,2); imshow(med_filter(A,3)); title('Median filtering  when filter size is 3');
subplot(2,2,3); imshow(med_filter(A,5)); title('Median filtering when filter size is 5');
subplot(2,2,4); imshow(med_filter(A,7)); title('Median filtering when filter size is 7');


% Part 3c
figure;
subplot(2,2,1); imshow(A); title('Noisy Image');
subplot(2,2,2); imshow(med_filter_part3(A,7,50)); title('Median threshold filtering 50');
subplot(2,2,3); imshow(med_filter_part3(A,7,100)); title('Median threshold filtering 200');
subplot(2,2,4); imshow(med_filter_part3(A,7,200)); title('Median threshold filtering when 500');

% According to the threshold value, we can detect some sharpness some
% areas.







