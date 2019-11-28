function [rotMatrix] = rotation_Matrix(ffdParams)
%ROTATION_MATRIX Summary of this function goes here
%   Detailed explanation goes here
rotMatrix = eul2rotm([
    deg2rad(ffdParams.rotationAngle(2)),...
    deg2rad(ffdParams.rotationAngle(1)),...
    deg2rad(ffdParams.rotationAngle(0))]);
end

