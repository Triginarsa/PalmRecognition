function [ features, palmImage, overLappingBlockImage ] = extract_features( image, is_test )
%EXTRACT_FEATURES Summary of this function goes here
%   Detailed explanation goes here

addpath('Functions\DetectROI');
addpath('Functions\Gabor');

image = findROI(image,192, 150);

image = uint8(255*mat2gray(image));
% image = medfilt2(image,[9 9]);

palmImage = 0;
overLappingBlockImage = 0;

if (is_test == 0)
    palmImage = image;
end

h = [ -1  2  -1 
      -1  2  -1
     -1 2 -1 ];
 
image = imresize(image, [96 96]);
image = filter2(h, image);

fun = @(block_struct) ...
   std2(block_struct.data) * ones(size(block_struct.data));

image = blockproc(image,[6 6],fun);
image = imresize(uint8(image), [16 16]);

if (is_test == 0)
    overLappingBlockImage = image;
end

image = im2double(image);

features = image(:)';

end

