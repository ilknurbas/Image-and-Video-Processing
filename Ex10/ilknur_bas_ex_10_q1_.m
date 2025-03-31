% Question 1
clc; close all; clear; 

cheetah = imread("cheetah.jpg");
chameleon = imread("chameleon.jpg");
dist = 50;

cube_cheetah = sliceCube(cheetah, dist);
cube_chameleon = sliceCube(chameleon, dist);

sphere_cheetah = sliceSphere(cheetah, dist);
sphere_chameleon = sliceSphere(chameleon, dist);

figure;
subplot(2,2,1); imshow(cheetah);
subplot(2,2,2); imshow(cube_cheetah);
subplot(2,2,3); imshow(chameleon);
subplot(2,2,4); imshow(cube_chameleon);

figure;
subplot(2,2,1); imshow(cheetah);
subplot(2,2,2); imshow(sphere_cheetah);
subplot(2,2,3); imshow(chameleon);
subplot(2,2,4); imshow(sphere_chameleon);


% manhattan
function cmask_image = sliceCube(I, dist)
    I = double(I);
    red = I(:,:,1);
    green = I(:,:,2);
    blue = I(:,:,3); 
    % lets you select pixels interactively from the image in the current axes.
    % When you finish selecting pixels, impixel returns the pixel values in p.
    C = impixel(uint8(I));
    C
    red_C = C(1,1);
    red_C
    green_C = C(1,2);
    green_C
    blue_C = C(1,3); 
    blue_C
    distance = abs(red-red_C)+abs(green-green_C)+ abs(blue-blue_C);
    cmask = distance <= dist;
    cmask_image = uint8(cat(3, red.*cmask, green.*cmask, blue.*cmask));
    
end


function cmask_image = sliceSphere(I, dist)
    I = double(I);
    red = I(:,:,1);
    green = I(:,:,2);
    blue = I(:,:,3); 
    C = impixel(uint8(I));
    red_C = C(1);
    green_C = C(2);
    blue_C = C(3); 
    distance = (red-red_C).^2 + (green-green_C).^2 + (blue-blue_C).^2;
    cmask = distance <= dist^2;
    cmask_image = uint8(cat(3, red.*cmask, green.*cmask, blue.*cmask));
    
end

 