function [ neuralnet ] = train( dataset_dir )
%TRAIN Summary of this function goes here
%   Detailed explanation goes here

[datasets, targets] = datasets_feature_extraction(dataset_dir);
neuralnet = patternnet(96);
neuralnet = train(neuralnet, datasets, targets);

datasets
end

