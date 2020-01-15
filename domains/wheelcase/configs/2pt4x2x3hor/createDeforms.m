function [allDeforms] = createDeforms(deformVals,ffdP,side)
%CREATEDEFORMS Summary of this function goes here
%   Detailed explanation goes here



nDeforms = size(deformVals,1);
allDefs = cat(4,ffdP.x,ffdP.y,ffdP.z);

allDeforms = permute(repmat(allDefs,[1 1 1 1 nDeforms]),[5 1 2 3 4]);
if(strcmp(side,'left'))
%Left
%Patter x-coord,y-coord,z-coord,direction(x=1,y=2,z=3),value
key = [2,1,2,1,1;
    3,1,2,1,2;
    2,1,2,2,3;
    3,1,2,2,4;
    2,1,2,3,5;
    3,1,2,3,6;
    ];

elseif(strcmp(side,'right'))
%Right
deformVals(3:4) = -deformVals(3:4);%y's inverted on right side
key = [2,2,2,1,1;
    3,2,2,1,2;
    2,2,2,2,3;
    3,2,2,2,4;
    2,2,2,3,5;
    3,2,2,3,6;
    ];
end
for i = 1:size(key,1)
    allDeforms(:,key(i,1),key(i,2),key(i,3),key(i,4)) = deformVals(:,key(i,5));
end
end

