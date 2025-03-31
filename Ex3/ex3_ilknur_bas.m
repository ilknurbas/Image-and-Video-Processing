clear all, close all;
% İlknur Baş
% EXERCISE 3_1_a

A = imread('wom1.png'); %  256×256 uint8 matrix
figure, imshow(A) % figure1
[rows, columns, depth] = size(A);
fprintf('%d\n',[rows, columns, depth]);

% calculates the number of pixels/intensity level within each range. 
histogram = zeros(1,256);
bin = 0:255;
for i=bin
    % sum(A == i) --> sum of each column (256 times )
    % sum(sum(A == 131)) --> sum for whole matrix
    pixel = sum(sum(A == i));
    histogram(i+1) = pixel;
end
figure, imhist(A)
figure, bar(bin,histogram)

% EXERCISE 3_1_b

% contrast stretching on the input image, so as to expand its range to [0 255].
% attempts to improve the contrast in an image by `stretching' the range of intensity values 

% the function is at the bottom

% EXERCISE 3_1_c
A2 = imread('man8.png');
A3 = imread('wom1.png');

% The contrast is improved in both images
figure
subplot(2,2,1); imshow(A2);   
subplot(2,2,2); imshow(A3);    
subplot(2,2,3); imshow(ContrastStretch(A2));  
subplot(2,2,4); imshow(ContrastStretch(A3));  

figure
subplot(2,2,1); imhist(A2);   
subplot(2,2,2); imhist(A3);    
subplot(2,2,3); imhist(ContrastStretch(A2));  
subplot(2,2,4); imhist(ContrastStretch(A3));  

% EXERCISE 3_2_a
A4 = imread('mbaboon.bmp');
% intensity of the (2, 2)th pixel
fun = @(block_struct) block_struct.data(2,2);
% process the input image A by applying the function fun to blocks of size [m n]
A5 = blockproc(A4,[4 4],fun);

% EXERCISE 3_2_b
fun = @(block_struct) block_struct.data(1,1);
% process the input image A by applying the function fun to blocks of size [m n]
A6 = blockproc(A4,[4 4],fun);

% EXERCISE 3_2_c
fun = @(block_struct) uint8(mean(block_struct.data(:)));
% process the input image A by applying the function fun to blocks of size [m n]
A7 = blockproc(A4,[4 4],fun);

figure
subplot(2,2,1); imshow(A5);   
subplot(2,2,2); imshow(A6);    
subplot(2,2,3:4); imshow(A7);

% Each time, a new matrix is formed

% EXERCISE 3_4_a
c1 = -100; 
c2 = 100; 
A_new_1 = A + c1;
A_new_2 = A + c2;

figure
subplot(2,2,1); imhist(A);   
subplot(2,2,3); imhist(A_new_1);
subplot(2,2,4); imhist(A_new_2);

% EXERCISE 3_4_b
c1 = 0.5; 
c2 = 1; 
A_new_3 = A * c1;
A_new_4 = A * c2;
 

figure
subplot(2,2,1); imhist(A);   
subplot(2,2,3); imhist(A_new_3);
subplot(2,2,4); imhist(A_new_4);



function stretched_A = ContrastStretch(A)  
    min_val = min(min(A)); % min valued pixel
    max_val = max(max(A)); % max valued pixel
    fprintf('min %d\n',min_val); % 55
    fprintf('maxV %d\n',max_val); % 144
    slope = 255/(max_val - min_val);
    fprintf('slope %d\n',slope); % 3
    stretched_A = (A-min_val) * slope;
end


