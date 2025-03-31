% İlknur Baş
clc; close all; clear; 

% Part 1 
% intensity transformations to enhance an image
I = imread('university.png');
figure; imshow(I)

r = double(I);
size(r) % 300,399
% (a) The log transformation
% try different values 
c_log = 60; % bigger value --> too bright, smaller value --> too dark
S1 = uint8(c_log*log(1 + r));

% (a) power-law transformation of the form
% try different values
% smaller gamma/c_power -- shadow look-alike image
% bigger gamma/c_power -- almost white image
c_power = 60; gamma = 0.4 ;
S2 = uint8(c_power*(r.^gamma));

figure;
subplot(2,2,1:2); imshow(I); title('Original Image');
subplot(2,2,3); imshow(S1); title('The log transformation');
subplot(2,2,4); imshow(S2); title('Power-law transformation');

% Part 2
% Using histogram equalization is better in terms of resulting image.
I1 = imread('moon.png');
I2 = imread('house.png');
I3 = imread('spine.jpg');
I4 = imread('church.png');

result_I1 = histequal(I1);
result_I2 = histequal(I2);
result_I3 = histequal(I3);
result_I4 = histequal(I4);

figure;
subplot(2,2,1); imshow(I1); title('Before: Original Image: moon');
subplot(2,2,2); histogram(uint8(I1)); title('Before: Original Histogram: moon');
subplot(2,2,3); imshow(result_I1); title('After: Histogram Equalized: moon');
subplot(2,2,4); histogram(result_I1); title('After: Histogram: moon');
ContrastStretch(I1, 0, 255)

figure;
subplot(2,2,1); imshow(I2); title('Before: Original Image: house');
subplot(2,2,2); histogram(uint8(I2)); title('Before: Original Histogram: house');
subplot(2,2,3); imshow(result_I2); title('After: Histogram Equalized: house');
subplot(2,2,4); histogram(result_I2); title('After: Histogram: house');
ContrastStretch(I2, 0, 255)

figure;
subplot(2,2,1); imshow(I3); title('Before: Original Image: spine');
subplot(2,2,2); histogram(uint8(I3)); title('Before: Original Histogram: spine');
subplot(2,2,3); imshow(result_I3); title('After: Histogram Equalized: spine');
subplot(2,2,4); histogram(result_I3); title('After: Histogram: spine');
ContrastStretch(I3, 0, 255)

figure;
subplot(2,2,1); imshow(I4); title('Before: Original Image: church');
subplot(2,2,2); histogram(uint8(I4)); title('Before: Original Histogram: church');
subplot(2,2,3); imshow(result_I4); title('After: Histogram Equalized: church');
subplot(2,2,4); histogram(result_I4); title('After: Histogram: church');
ContrastStretch(I4, 0, 255)

% Part 3
% use I3 OR I4 as A
B = imread('corel.png');
result_1 =  histmatching(I3, B);
result_2 =  histmatching(I4, B);

figure;
subplot(3,2,1:2); imshow(B); title('Original Image: corel B');
subplot(3,2,3); imshow(I3); title('Original Image: spine I3');
subplot(3,2,4); imshow(I4); title('Original Image: church I4');
subplot(3,2,5); imshow(result_1); title('After: spine & corel');
subplot(3,2,6); imshow(result_2); title('After: church & corel');


function result = histmatching(A, B)
    [row_A, column_A] = size(A);
    [row_B, column_B] = size(B);
    
    N_A = row_A * column_A;
    N_B = row_B * column_B;
    
    % according to slides, 256 is L (gray levels)
    n_value_A = zeros (256,1);
    n_value_B = zeros (256,1);
    % compute image histogram (normalized) for A
    for k = 1:row_A
        for l = 1:column_A
            % the pixels are [0,255]
            n_value_A(A(k,l)+1) = n_value_A(A(k,l)+1) + 1;        
        end
    end
    % compute image histogram (normalized) for B
    for k = 1:row_B
        for l = 1:column_B
            % the pixels are [0,255]
            n_value_B(B(k,l)+1) = n_value_B(B(k,l)+1) + 1;        
        end
    end
    

    % normalize the values
    for m = 1:256
        n_value_A(m,:) = n_value_A(m,:)/N_A;
        n_value_B(m,:) = n_value_B(m,:)/N_B;
    end
    
    cdf_val_A = zeros (256,1);
    cdf_val_B = zeros (256,1);
    temp = 0;
    % Compute the CDF (accumulating histogram values) for A
    for k = 1:256
        temp = temp + n_value_A(k,:);
        cdf_val_A(k) = temp ; 
       
        % Round the CDF values to integers to obtain the mapping between histogram bins
        cdf_val_A(k) = round(cdf_val_A(k)*255 + 0.5);
    end
    
    temp = 0;
    % Compute the CDF (accumulating histogram values) for B
    for k = 1:256
        temp = temp + n_value_B(k,:);
        cdf_val_B(k) = temp ; 
       
        % Round the CDF values to integers to obtain the mapping between histogram bins
        cdf_val_B(k) = round(cdf_val_B(k)*255 + 0.5);
    end  
    
    % mapping
    result = zeros(256,1);
    for k = 1:256
        [~,index] = min(abs(cdf_val_A(k)-cdf_val_B));
        result(k) = index-1;
    end
    result = uint8(result(A+1));
    
end