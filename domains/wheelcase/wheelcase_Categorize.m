function feature = wheelcase_Categorize(samples, d)
%wheelcase_Categorize - Categorizes samples along domain Features
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
   FV = d.expressRight(samples(i,:));
   [width,idx] = max(FV.vertices(:,2));
   feature(i,:) = [width, FV.vertices(idx,1)];
end

% for i = 1:size(samples)
%     second = samples(i,3);
%     third = samples(i,4);
%     fourth = samples(i,5);
%     fifth = samples(i,6);
%     
%     if (second>0 && third>0) % deformation to inside
%         completeWidth = 0;
%     elseif (second>0 && third<0)
%         width1 = abs(third);
%         width2 = abs(third)
%         completeWidth = width1*2;
%     elseif (second<0 && third>0)
%         width1 = abs(second);
%         completeWidth = width1*2;
%     else
%         width1 = abs(second);
%         width2 = abs(third);
%         completeWidth = max(width1,width2)*2;
%     end
%     
%     if (fifth<0)
%         maxHeight = 0;
%     else
%         maxHeight = fifth;
%     end
%     feature(i,:) = [completeWidth, maxHeight];

feature = (feature-d.featureMin)./(d.featureMax-d.featureMin);
feature(feature>1) = 1; feature(feature<0) = 0;

end
