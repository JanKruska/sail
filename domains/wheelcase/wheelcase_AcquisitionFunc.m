function [fitness,predValue] = wheelcase_AcquisitionFunc(drag,genome,d)
%wheelcase_AcquisitionFunc - Infill criteria based on uncertainty and fitness
%
% Syntax:  [fitness, dragForce] = wheelcase_AcquisitionFunc(drag,d)
%
% Inputs:
%   drag -    [2XN]    - dragForce mean and variance
%   genome -           - the genome of the individual
%   d    -             - domain struct 
%
% Outputs:
%    fitness   - [1XN] - Fitness value (lower is better)
%    predValue - [1XN] - Predicted drag force (mean), Predicted drag force
%    (variance), constraint (if applicable)
%
%Author: Jan Kruska
%------------- BEGIN CODE --------------
FV = d.expressRight(genome);
if(d.conCoef==0)
    fitness = (drag(:,1)*d.muCoef) - (drag(:,2)*d.varCoef);
    predValue{1} = drag(:,1);
    predValue{2} = drag(:,2);
else
    [penalties,invalid] = penalty(FV,d);
    if(any(invalid))
        disp(['Penalty calculation failed for ' num2str(sum(invalid)) ' out of ' num2str(size(genome,1)) ' Evaluations']);
        %disp(genome(invalid,:));
        %genome(invalid,:)
        %d.invalidPenalties = cat(1,d.invalidPenalties,);
        
        %Save errors for later examination of cause
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
    predValue{3} = (penalties ./ d.constraintVolumeBase .* d.conCoef);
end

%------------- END OF CODE --------------