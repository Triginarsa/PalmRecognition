function [datasets, targets] = datasets_feature_extraction(directory)

% directory = 'datasets/';

features = [];
targets  = [];
STR      = ["Geyge", "Adi", "Dwi", "Andre", "Natha", "Angga", "Yoga"];

D = dir(directory);


for f = 3:length(D)
    fileName = [directory D(f).name]
    
    image = imread(fileName);
    
    image = imrotate(image, 90);
    
    image = imresize(image, [NaN 640]);
        
    [feature, palmImage, overLBImage] = extract_features(image, 1);
    lbpFeatures = extractLBPFeatures(rgb2gray(imread(fileName)), 'Upright', true);

    features = [features; [feature lbpFeatures]];
        
    str_length = strlength(D(f).name);
        
    owner = D(f).name(1 : str_length - 7);
    target = zeros(1, 7);
    target(1, find(STR == owner)) = 1;
    
    target
    targets = [targets; target];
end


datasets = features';
targets = targets';

end