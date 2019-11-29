function [FV] = escooter_Express(deformVals, ffdPLeft,ffdPRight)
%escooter_Express - Expresses a genome by performing ffd on base stl

% deformVals - Genomes of samples

% deformVals = (deformVals*2)-1;

nDeforms = size(deformVals,1);
ffdPLeft.nDeforms = nDeforms;
ffdPRight.nDeforms = nDeforms;

deformsLeft = createDeforms(deformVals,ffdPLeft,'left');
deformsRight = createDeforms(deformVals,ffdPRight,'right');

%left and right bounds should not overlap or this wont work as expected
leftShifts = performffd(ffdPLeft,deformsLeft);
rightShifts = performffd(ffdPRight,deformsRight);

%Apply ffd shifts to all Points inside the ffd box
for i = 1:nDeforms
    FV(i).vertices = ffdPLeft.meshPoints;
    FV(i).vertices(ffdPLeft.validIdxs,:) = FV(i).vertices(ffdPLeft.validIdxs,:)...
        + leftShifts(i).vertices;
    FV(i).vertices(ffdPRight.validIdxs,:) = FV(i).vertices(ffdPRight.validIdxs,:)...
        + rightShifts(i).vertices;
    FV(i).faces = ffdPLeft.faces;
end

end

