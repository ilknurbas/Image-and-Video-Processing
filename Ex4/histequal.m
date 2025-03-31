% The logic was written in lecture slides
% 1. Compute the image histogram (normalized)
% 2. Compute the CDF (accumulating histogram values)
% 3. Round the CDF values to integers to obtain the mapping between histogram bins
% 4. Modify the intensities of the original image according to the obtained mapping
function result = histequal(I)
    
    [row, column] = size(I);
    N = row * column;
    % according to slides, 256 is L (gray levels)
    n_value = zeros (256,1);
    % compute image histogram (normalized)
    for k = 1:row
        for l = 1:column
            % the pixels are [0,255]
            n_value(I(k,l)+1) = n_value(I(k,l)+1) + 1;        
        end
    end
    
    % normalize the values
    for m = 1:256
        n_value(m,:) = n_value(m,:)/N;
    end
    
    cdf_val = zeros (256,1);
    temp = 0;
    % Compute the CDF (accumulating histogram values)
    for k = 1:256
        temp = temp + n_value(k,:);
        cdf_val(k) = temp ; 
       
        % Round the CDF values to integers to obtain the mapping between histogram bins
        cdf_val(k) = round(cdf_val(k)*255 + 0.5);
    end     
    
    % modify the intensities of the original image according to the obtained mapping
    result = cdf_val(I+1);
    result = uint8(result);
    
end

