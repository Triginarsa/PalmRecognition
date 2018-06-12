function [ result ] = recognize( neuralnet, feature )
%RECOGNIZE Summary of this function goes here
%   Detailed explanation goes here

STR      = ["Geyge", "Adi", "Dwi", "Andre", "Natha", "Angga", "Yoga"];

index = vec2ind(neuralnet(feature))

owner = STR(1, index);
result = owner;

end

