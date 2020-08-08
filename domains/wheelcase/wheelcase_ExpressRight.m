function [FV] = wheelcase_ExpressRight(deformVals,ffdP)
%wheelcase_ExpressRight - Expresses a genome by performing ffd on base stl
% Only deforms the right wheelcase
%
% Because all deformations are symmetric for right/left deforming both sides
% is unnecessary for some calculations, like categorization or
% constraint
%
% Inputs:
%    deformVals     - genome
%	 ffdP           - FFD Parameters
% Outputs:
%    FV             - Struct containing vertices and faces for the deformed
%    shape
% Author: Jan Kruska

% deformVals - Genomes of samples
deformVals = genomeScale(deformVals);
nDeforms = size(deformVals,1);
deforms = createDeforms(deformVals,ffdP,'right');

shifts = performffd(ffdP,deforms);

%Apply ffd shifts to all points inside the ffd box
for i = 1:nDeforms
    FV(i).vertices = ffdP.meshPoints;
    FV(i).vertices(ffdP.validIdxs,:) = ffdP.meshPoints(ffdP.validIdxs,:)...
        + shifts(i).vertices;
    FV(i).faces = ffdP.faces;
end

end

