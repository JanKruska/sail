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

    % to which bin does a cube belong? depends on the selected features
    nSamples= size(samples,1);
    feature = nan(nSamples,2);
    
    feature(:,1) = max(samples,[],2);
    feature(:,2) = max(samples,[],2) - min(samples,[],2);
    
feature = (feature-d.featureMin)./(d.featureMax-d.featureMin);
feature(feature>1) = 1; feature(feature<0) = 0;