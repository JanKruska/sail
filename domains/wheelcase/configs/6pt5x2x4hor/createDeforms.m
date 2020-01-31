function [allDeforms] = createDeforms(deformVals,ffdP,side)
%CREATEDEFORMS Summary of this function goes here
%   Detailed explanation goes here



nDeforms = size(deformVals,1);
allDefs = cat(4,ffdP.x,ffdP.y,ffdP.z);

allDeforms = permute(repmat(allDefs,[1 1 1 1 nDeforms]),[5 1 2 3 4]);
if(strcmp(side,'left'))
%Left
deformVals(:,7:12) = -deformVals(:,7:12);%y's inverted on right side
%Patter x-coord,y-coord,z-coord,direction(x=1,y=2,z=3),value
key = [2,1,2,1,1;
    3,1,2,1,2;
    4,1,2,1,3;
    2,1,3,1,4;
    3,1,3,1,5;
    4,1,3,1,6;
    
    2,1,2,2,7;
    3,1,2,2,8;
    4,1,2,2,9;
    2,1,3,2,10;
    3,1,3,2,11;
    4,1,3,2,12;
    
    2,1,2,3,13;
    3,1,2,3,14;
    4,1,2,3,15;
    2,1,3,3,16;
    3,1,3,3,17;
    4,1,3,3,18;
    ];

elseif(strcmp(side,'right'))
%Right
key = [2,2,2,1,1;
    3,2,2,1,2;
    4,2,2,1,3;
    2,2,3,1,4;
    3,2,3,1,5;
    4,2,3,1,6;
    
    2,2,2,2,7;
    3,2,2,2,8;
    4,2,2,2,9;
    2,2,3,2,10;
    3,2,3,2,11;
    4,2,3,2,12;
    
    2,2,2,3,13;
    3,2,2,3,14;
    4,2,2,3,15;
    2,2,3,3,16;
    3,2,3,3,17;
    4,2,3,3,18;
    ];
end
for i = 1:size(key,1)
    allDeforms(:,key(i,1),key(i,2),key(i,3),key(i,4)) = deformVals(:,key(i,5));
end
end

