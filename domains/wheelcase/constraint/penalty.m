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
penalties = nan(1,nSamples);
invalid = logical(false(1,nSamples));
turningVolume = d.steeringSpace;

for i = 1:nSamples
%     verts = samples{i}.vertices;
%     inside = inpolyhedron(d.steeringSpace,verts);
%     penalties(i,1) = sum(inside)/size(inside,1);
try
    [verts,faces] = mesh_boolean(turningVolume.vertices,turningVolume.faces,...
        samples(i).vertices,samples(i).faces,'minus',...
        'BooleanLib','libigl');%,'Debug',true);
    [verts,tetra,~] = tetgen(verts,faces);%,'Verbose',true);
    penalties(1,i) = sum(volume(verts,tetra));
catch
    invalid(1,i) = true;
%     disp(['Constraint calculation crashed for i=' num2str(i) ' returning NaN']);
end
end

end