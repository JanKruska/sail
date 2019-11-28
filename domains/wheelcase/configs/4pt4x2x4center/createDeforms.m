function [allDeforms] = createDeforms(deformVals,ffdP,side)
%CREATEDEFORMS Summary of this function goes here
%   Detailed explanation goes here



allDefs = cat(4,ffdP.x,ffdP.y,ffdP.z);

allDeforms = permute(repmat(allDefs,[1 1 1 1 ffdP.nDeforms]),[5 1 2 3 4]);
if(strcmp(side,'left'))
%Left
%Patter x-coord,y-coord,z-coord,direction(x=1,y=2,z=3),value
key = [2,1,2,1,1;
    3,1,2,1,2;
    2,1,3,1,3;
    3,1,3,1,4;
    
    2,1,2,2,5;
    3,1,2,2,6;    
    2,1,3,2,7;
    3,1,3,2,8;
    
    2,1,2,3,9;
    3,1,2,3,10;
    2,1,3,3,11;
    3,1,3,3,12;
    ];

elseif(strcmp(side,'right'))
%Right
deformVals(5:8) = -deformVals(5:8);%y's inverted on right side
key = [2,2,2,1,1;
    3,2,2,1,2;
    2,2,3,1,3;
    3,2,3,1,4;
    
    2,2,2,2,5;
    3,2,2,2,6;
    2,2,3,2,7;
    3,2,3,2,8;
    
    2,2,2,3,9;
    3,2,2,3,10;
    2,2,3,3,11;
    3,2,3,3,12;
    ];
end
for i = 1:size(key,1)
    allDeforms(:,key(i,1),key(i,2),key(i,3),key(i,4)) = deformVals(:,key(i,5));
end
end

