function [penalties,invalid] = penalty(samples,d)
%penalty - calculates constraint penalty for all samples
% Inputs:
%   samples - 1xn array containing FV structs of wheelcases
%    d - domain description struct
%
% Outputs:
%    penalties - 1xn penalties
%

nSamples = size(samples,2);
penalties = nan(nSamples,1);
invalid = logical(false(nSamples,1));
turningVolume = d.steeringSpace;

parfor i = 1:nSamples
try
    [verts,faces] = mesh_boolean(turningVolume.vertices,turningVolume.faces,...
        samples(i).vertices,samples(i).faces,'minus',...
        'BooleanLib','libigl');%,'Debug',true);
    [verts,tetra,~] = tetgen(verts,faces);%,'Verbose',true);
    penalties(i,1) = sum(volume(verts,tetra));
catch e
    invalid(i,1) = true;
%    fprintf(1,'Penalty calculation crashed with an error of type %s! The message was:\n%s',e.identifier,e.message);
%     disp(['Constraint calculation crashed for i=' num2str(i) ' returning NaN']);
end
end

end