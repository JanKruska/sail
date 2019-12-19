function penalties = penalty(samples,d)
%penalty - calculates constraint penalty for all samples
% Inputs:
%   samples - nX1 cell array containing FV structs of wheelcases
%    d - domain description struct
%
% Outputs:
%    penalties - nx1 penalties between 0(best) and 1(worst) depending on
%    how many points of the wheelcase lie inside the spaces needed for the
%    maximum turning angle
%

nSamples = size(samples,1);
penalties = nan(nSamples,1);
tic;
for i = 1:nSamples
    verts = samples{i}.vertices;
    inside = inpolyhedron(d.steeringSpace,verts);
    penalties(i,1) = sum(inside)/size(inside,1);
end
time = toc;
disp(['Evaluating ' num2str(nSamples) ' Samples took' num2str(time)])
end