function [filtered_image] = med_filter(image, filter_size)
    % median filtering works as follows:
    % zero padding is needed.
    % You find the median for each nxn matrix where n is filter_sizeX. And
    % change the middle value with the median value.

    [row, col] = size(image);
    med_fil = image;
    x = filter_size-1;
    for i=1:row-x
        for j=1:col-x
            dummy_matrix = image(i:i+x , j:j+x);     
            med_fil(i+round(filter_size/2), j+round(filter_size/2)) = median(dummy_matrix(:));
        end
    end
    filtered_image = med_fil;
end



