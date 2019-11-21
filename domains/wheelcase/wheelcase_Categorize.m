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

    % to which bin does a cube belong? depends on the selected features
    nSamples= size(samples,1);
    feature = nan(nSamples,2);
    
    for i = 1:size(samples)
        second = samples(i,2);
        third = samples(i,3);
        fourth = samples(i,4);
        fifth = samples(i,5);

        if (second>0 && third>0) % deformation to inside
            completeWidth = 0;
        elseif (second>0 && third<0)
            width1 = abs(third);
            % width2 = abs(third)
            completeWidth = width1*2;
        elseif (second<0 && third>0)
            width1 = abs(second);
            completeWidth = width1*2;
        else
            width1 = abs(second);
            width2 = abs(third);
            completeWidth = max(width1,width2)*2;
        end
        if (fifth<0)
            maxHeight = 0;
        else
            maxHeight = fifth;
        end
        feature(i,:) = [completeWidth, maxHeight];
    end
    