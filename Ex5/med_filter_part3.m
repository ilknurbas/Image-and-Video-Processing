function [filtered_image] = med_filter_part3(image, filter_size, threshold)
    % median filtering works as follows:
    % You find the median for each nxn matrix where n is filter_sizeX. And
    % change the middle value with the median value.

    [row, col] = size(image);
    med_fil = image;
    x = filter_size-1;
    for i=1:row-x
        for j=1:col-x
            dummy_matrix = image(i:i+x , j:j+x);     
            med_fil(i+round(filter_size/2), j+round(filter_size/2)) = median(dummy_matrix(:));
            
            temp = i+round(filter_size/2);
            temp_2 = j+round(filter_size/2);
            % med_fil(i+round(filter_size/2), j+round(filter_size/2)) = median(dummy_matrix(:));
            if abs(image(temp,temp_2) - med_fil(temp,temp_2)) > threshold
                med_fil(temp,temp_2) = image(temp,temp_2);
            end
        end
    end
    filtered_image = med_fil;

end



