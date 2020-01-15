function [fitness,predValue] = wheelcase_AcquisitionFunc(drag,genome,d)
%wheelcase_AcquisitionFunc - Infill criteria based on uncertainty and fitness
%
% Syntax:  [fitness, dragForce] = wheelcase_AcquisitionFunc(drag,d)
%
% Inputs:
%   drag -    [2XN]    - dragForce mean and variance
%   genome - the genome of the individual
%   d    -             - domain struct 
%
% Outputs:
%    fitness   - [1XN] - Fitness value (higher is better)
%    predValue - [1XN] - Predicted drag force (mean)
%

%------------- BEGIN CODE --------------
% FV = d.expressRight(genome);
% [penalties,invalid] = penalty(FV,d);
% 
% if(any(invalid))
%     disp(['Penatly calculation failed for ' num2str(sum(invalid)) ' out of ' num2str(size(genome,1)) ' Evaluations']);
%     disp(genome(invalid,:));
% end

fitness = (drag(:,1)*d.muCoef) - (drag(:,2)*d.varCoef);% ...
%     + (penalties ./ d.constraintVolumeBase); % better fitness is lower fitness  
predValue{1} = drag(:,1);
predValue{2} = drag(:,2);
%predValue{3} = penalties;

%------------- END OF CODE --------------