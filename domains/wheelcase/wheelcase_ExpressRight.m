function [FV] = wheelcase_ExpressRight(deformVals,ffdP)
%wheelcase_Express - Expresses a genome by performing ffd on base stl

% deformVals - Genomes of samples

deformVals = genomeScale(deformVals);

nDeforms = size(deformVals,1);
ffdP.nDeforms = nDeforms;

deforms = createDeforms(deformVals,ffdP,'right');

%left and right bounds should not overlap or this wont work as expected
shifts = performffd(ffdP,deforms);

%Apply ffd shifts to all Points inside the ffd box
for i = 1:nDeforms
    FV(i).vertices = ffdP.meshPoints(ffdP.validIdxs,:)...
        + shifts(i).vertices;
end

end

