function [fitness,predValue] = wheelcase_AcquisitionFunc(drag,d)
%wheelcase_AcquisitionFunc - Infill criteria based on uncertainty and fitness
%
% Syntax:  [fitness, dragForce] = wheelcase_AcquisitionFunc(drag,d)
%
% Inputs:
%   drag -    [2XN]    - dragForce mean and variance
%   d    -             - domain struct 
%
% Outputs:
%    fitness   - [1XN] - Fitness value (higher is better)
%    predValue - [1XN] - Predicted drag force (mean)
%

%------------- BEGIN CODE --------------

fitness = (drag(:,1)*d.muCoef) + (drag(:,2)*d.varCoef); % better fitness is higher fitness  
predValue{1} = drag(:,1);
predValue{2} = drag(:,2);

%------------- END OF CODE --------------