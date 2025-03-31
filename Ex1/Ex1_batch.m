%İlknur Baş
function [] = Ex1_batch()
    for i = 1:6
        % imread - reads image file
        % num2str - Convert numbers to character array
        % strcat - Concatenate strings horizontally
        image = imread(strcat("c_",num2str(i),".jpg"));
        result_I = Process(image);
        imwrite(result_I,strcat("c_",num2str(i),".bmp"))
    end
end


function result_I = Process(I) % I image matrix I
    
    % scale down to 75% of the original size
    result_I = imresize(I,0.75);
    result_I = result_I(:,size(result_I,2)/2:end,:); 
    result_I = fliplr(result_I);
    % rotate 90 degrees counterclockwise 
    result_I = imrotate(result_I,90);

end