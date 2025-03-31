function result = directional_filtering(I, filter_size)

    % when filter size is 3 at 0 degree, the filter is 0,0,0 ; 1,1,1; 0,0,0]/3
    filter_0 = zeros(filter_size, filter_size);
    filter_0(floor(filter_size/2)+1, :) = ones(1,filter_size); % floor rounds toward negative infinity
    filter_0 = filter_0/filter_size;
    I_0 = imfilter(I, filter_0);

    % create filter for 45, it should be counterclockwise 
    filter_1 = rot90(diag(ones(filter_size, 1))); % rotate array counterclockwise
    filter_1 = filter_1/filter_size;
    I_1 = imfilter(I, filter_1);

    % create filter for 90
    filter_2 = zeros(filter_size, filter_size);
    filter_2(:, floor(filter_size/2)+1) = ones(1,filter_size);
    filter_2 = filter_2/filter_size;
    I_2 = imfilter(I, filter_2);

    % create filter for 135
    filter_3 = diag(ones(filter_size, 1));
    filter_3 = filter_3/filter_size;
    I_3 = imfilter(I, filter_3);
    

    filter_0
    filter_1
    filter_2
    filter_3 
    
    figure;
    subplot(3,2,1:2); imshow(I); title('Original Image');
    subplot(3,2,3); imshow(I_0); title('Image with directional filter of 0 degree');
    subplot(3,2,4); imshow(I_1); title('Image with directional filter of 45 degree');
    subplot(3,2,5); imshow(I_2); title('Image with directional filter of 90 degree');
    subplot(3,2,6); imshow(I_3); title('Image with directional filter of 135 degree');
    
    % combine results from 4 filtered image
    result = double(I_0) + double(I_1) + double(I_2) + double(I_3);
    result = uint8(result/4);


end


