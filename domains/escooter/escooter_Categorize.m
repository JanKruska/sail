function feature = escooter_Categorize(samples, d)
%escooter_Categorize - Categorizes samples along domain Features
%
% Syntax:  [observation, value] = af_InitialSamples(p)
%
% Inputs:
%    samples        - [n X d.dof]Sample genomes to categorize
%	 d 				- Domain struct
% Outputs:
%    feature  - [n X d.nDims] categorization of each sample
% Author: Jan Kruska

nSamples= size(samples,1);
feature = nan(nSamples,2);

for i = 1:size(samples)
    FV = d.express(samples(i,:));
    [lowest,idx] = min(FV.vertices(:,3));
    feature(i,:) = [lowest, FV.vertices(idx,1)];
end

feature = (feature-d.featureMin)./(d.featureMax-d.featureMin);
feature(feature>1) = 1; feature(feature<0) = 0;

end