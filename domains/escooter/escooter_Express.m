function [FV] = escooter_Express(deformVals, ffdP)
%escooter_Express - Expresses a genome by performing ffd on base stl
% deformVals - Genomes of samples

nDeforms = size(deformVals,1);
ffdP.nDeforms = nDeforms;

deforms = createDeforms(deformVals,ffdP);

shifts = performffd(ffdP,deforms);

%Apply ffd shifts to all Points inside the ffd box
for i = 1:nDeforms
    FV(i).vertices = ffdP.meshPoints;
    FV(i).vertices(ffdP.validIdxs,:) = FV(i).vertices(ffdP.validIdxs,:)...
        + shifts(i).vertices;
    FV(i).faces = ffdP.faces;
end

end

