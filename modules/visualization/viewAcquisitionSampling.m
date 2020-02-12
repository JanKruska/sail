function viewAcquisitionSampling(samples,d)
    
categories = feval(d.categorize,samples,d);
scatter(categories(:,1),categories(:,2),16,'filled');

yOffset = [-0.5 -0.0 0];
title('Samples chosen for Evaluation');
xlab = xlabel([d.featureLabels{1} '\rightarrow']);
ylab = ylabel(['\leftarrow ' d.featureLabels{2} ]);
% set(ylab,'Rotation',90,'Position',get(ylab,'Position')-yOffset)
axis equal
end