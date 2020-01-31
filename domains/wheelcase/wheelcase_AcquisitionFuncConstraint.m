function [fitness,predValue] = wheelcase_AcquisitionFuncConstraint(drag,genome,d)
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
FV = d.expressRight(genome);
[penalties,invalid] = penalty(FV,d);
% 
if(any(invalid))
    disp(['Penatly calculation failed for ' num2str(sum(invalid)) ' out of ' num2str(size(genome,1)) ' Evaluations']);
    %disp(genome(invalid,:));
    %genome(invalid,:)
    %d.invalidPenalties = cat(1,d.invalidPenalties,);
    [error,out] = system('du -c error/ | cut -f1 | tail -n 1');
    if(error == 0 && str2double(out)<2^10^3) %error folder less than 1 gig
        save(['error/' datestr(now,'yyyy-mm-dd_HH-MM') '.mat'],'drag','genome','invalid');
        save('error/domain.mat','d');
    end
end

fitness = (drag(:,1)*d.muCoef) - (drag(:,2)*d.varCoef) ...
    + (penalties .* d.conCoef ./ d.constraintVolumeBase); % better fitness is lower fitness  
predValue{1} = drag(:,1);
predValue{2} = drag(:,2);
predValue{3} = (penalties ./ d.constraintVolumeBase);

%------------- END OF CODE --------------