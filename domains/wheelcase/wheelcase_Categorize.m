function feature = wheelcase_Categorize(samples, d)
%wheelcase_Categorize - Categorizes samples along domain Features
%
% Inputs:
%    samples        - [n X d.dof]Sample genomes to categorize
%	 d 				- Domain struct
% Outputs:
%    feature  - [n X d.nDims] categorization of each sample
% Author: Jan Kruska

nSamples= size(samples,1);
feature = nan(nSamples,2);

%First feature: width
%Second feature: x of widest point
for i = 1:size(samples)
   FV = d.expressRight(samples(i,:));%due to symmetry only one deformation necessary for categorization
   [width,idx] = max(FV.vertices(:,2));
   feature(i,:) = [width, FV.vertices(idx,1)];
end


feature = (feature-d.featureMin)./(d.featureMax-d.featureMin);%scale to range [0;1]
feature(feature>1) = 1; feature(feature<0) = 0;%Scale if outside feature bounds

end
