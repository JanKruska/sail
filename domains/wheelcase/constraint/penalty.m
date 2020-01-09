function penalties = penalty(samples,d)
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

parfor i = 1:nSamples
%     verts = samples{i}.vertices;
%     inside = inpolyhedron(d.steeringSpace,verts);
%     penalties(i,1) = sum(inside)/size(inside,1);
    [verts,faces] = mesh_boolean(d.steeringSpace.vertices,d.steeringSpace.faces,samples(i).vertices,samples(i).faces,'minus');
    [verts,tetra,~] = tetgen(verts,faces);%,'Verbose',true);
    penalties(1,i) = sum(volume(verts,tetra));
end

end