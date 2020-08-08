function [FV] = wheelcase_Express(deformVals, ffdPLeft,ffdPRight)
%wheelcase_Express - Expresses a genome by performing ffd on base stl

% deformVals - Genomes of samples

deformVals = genomeScale(deformVals);

nDeforms = size(deformVals,1);
ffdPLeft.nDeforms = nDeforms;
ffdPRight.nDeforms = nDeforms;

deformsLeft = createDeforms(deformVals,ffdPLeft,'left');
deformsRight = createDeforms(deformVals,ffdPRight,'right');

%left and right bounds should not overlap or this wont work as expected
leftShifts = performffd(ffdPLeft,deformsLeft);
rightShifts = performffd(ffdPRight,deformsRight);

%Apply ffd shifts to all points inside the ffd box
for i = 1:nDeforms
    FV(i).vertices = ffdPLeft.meshPoints;
    FV(i).vertices(ffdPLeft.validIdxs,:) = FV(i).vertices(ffdPLeft.validIdxs,:)...
        + leftShifts(i).vertices;
    FV(i).vertices(ffdPRight.validIdxs,:) = FV(i).vertices(ffdPRight.validIdxs,:)...
        + rightShifts(i).vertices;
    FV(i).faces = ffdPLeft.faces;
end

end

