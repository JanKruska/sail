function [constraintsOfUnconstrained] = fullCompare(predMapUnconstrained,predMapConstrained,d,dirName,varargin)

path = ['results/' dirName '/'];

if(nargin > 4)%dont recompute constraints if provided
    constraintsOfUnconstrained = varargin{1};
else
    constraintsOfUnconstrained = constraintMap(predMapUnconstrained.genes,d) ./ 1.6E+6;
end


figure(10);
[fig,layout] = compareMaps(predMapUnconstrained.cD,predMapConstrained.cD,d);
title(layout,'Drag coefficient comparison');
saveas(gcf,[path 'dragMapComparison.eps'],'epsc');

figure(11);
boxplotCompare(predMapUnconstrained.cD,predMapConstrained.cD);
title('Drag coefficient comparison');
ylabel('ln(cD)')
saveas(gcf,[path 'dragBoxplot.eps'],'epsc');

figure(12);
[fig,layout] = compareMaps(constraintsOfUnconstrained,predMapConstrained.constraint,d);
title(layout,'Constraint comparison');
saveas(gcf,[path 'constraintMapComparison.eps'],'epsc');

figure(13);
boxplotCompare(constraintsOfUnconstrained,predMapConstrained.constraint);
title('Constraint comparison');
ylabel('Costraint volume relative to undeformed wheelcase');
saveas(gcf,[path 'constraintBoxplot.eps'],'epsc');

figure(14);
viewMapImprovements(predMapUnconstrained.cD,predMapConstrained.cD,d);
title('Fitness improvement of constrained version vs. unconstrained');
saveas(gcf,[path 'dragImprovements.eps'],'epsc');

figure(15);
viewMapImprovements(constraintsOfUnconstrained,predMapConstrained.constraint,d);
title('Constraint improvement of constrained version vs. unconstrained');
saveas(gcf,[path 'constraintImprovements.eps'],'epsc');
end