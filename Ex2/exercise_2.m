clear all, close all;
% İlknur Baş
% EXERCISE 2_1

help quant
help quantiz

A = 0:255;
% step = 64
step = 256/4;
% each element of A is rounded to the closest multiple of step variable
QA1 = quant(A, step);
% partition vector = 64:64:192, which is the quantization partition
% these values are endpoints
partition = step:step:256-step;
% codebook vector = 32:64:224 which prescribes a value for each partition 
codebook = step/2:step:256-step/2; 
% Perform quantization
% QA2 is quantized output value of A
% indx is the quantization index
% dividing a signal into partitions
[indx,QA2] = quantiz(A, partition, codebook);

help unique
% returns the same values as in A but with no repetitions
display(unique(QA1)) % 0    64   128   192   256
display(unique(QA2)) %  32    96   160   224


% EXERCISE 2_2
matrix_I = imread('lena_face.png');
figure, imshow(matrix_I) % figure1

level_val = [128, 64, 32, 16, 8, 4]; % 128 has highest quality

class(A) % type double 
class(matrix_I)  % type uint8 
size(A) %  1   256
size(matrix_I) % 256   256
size(matrix_I(:)) % 65536   1

figure
for i = 1:length(level_val)
    QA = cal_quantiz(level_val(i), matrix_I);
    QA = reshape(QA, [256, 256]);
    class(QA)  % type  double 
    QA = uint8(QA);
    subplot(3,2,i); imshow(QA); % figure2
end

% add noise to image
% randn(n) returns an n-by-n matrix of normally distributed random numbers.
class(size(matrix_I))  % type double
noise_image = matrix_I + uint8(10 * randn(size(matrix_I)));
% figure; imshow(noise_image);   

QA1 = cal_quantiz(16, matrix_I); % Quantize lena_face.png 
QA1 = reshape(QA1, [256, 256]);
QA1 = uint8(QA1);

QA2 = cal_quantiz(16, noise_image); % Quantize noise_image
QA2 = reshape(QA2, [256, 256]);
QA2 = uint8(QA2);

figure
subplot(2,1,1); imshow(QA1);
subplot(2,1,2); imshow(QA2); % figure 3


% EXERCISE 2_3
% background 63 and 223, size  400x400 and 160x160
% small gray level values of 127

image_1 = uint8(63 * ones(400)); % ones(n) returns an n-by-n matrix of ones.
image_1(120:280, 120:280) =  127 ;% row, column

image_2 = uint8(223 * ones(400)); % ones(n) returns an n-by-n matrix of ones.
image_2(120:280, 120:280) =  127 ;% row, column

figure
subplot(1,2,1); imshow(image_1); % this one is brighter
subplot(1,2,2); imshow(image_2); % figure 4 % looks darker


% try to do second gray area more bright
image_2(120:280, 120:280) =  150; % 20: too dark 
figure
subplot(1,2,1); imshow(image_1);
subplot(1,2,2); imshow(image_2);


function QA = cal_quantiz(level, matrix_I)
    step = 256/level;
    partition = step:step:256-step;
    codebook = step/2:step:256-step/2; 
    matrix_I = matrix_I(:); %linear
    [indx,QA] = quantiz(matrix_I, partition, codebook);
end



