function [allDeforms] = createDeforms(deformVals,ffdP)
%CREATEDEFORMS Summary of this function goes here
%   Detailed explanation goes here



allDefs = cat(4,ffdP.x,ffdP.y,ffdP.z);

allDeforms = permute(repmat(allDefs,[1 1 1 1 ffdP.nDeforms]),[5 1 2 3 4]);

%Patter x-coord,y-coord,z-coord,direction(x=1,y=2,z=3),value
key = [2,2,1,3,1;
    2,3,1,3,2;
    2,4,1,3,3;
    2,5,1,3,4;
    
    3,2,1,3,5;
    3,3,1,3,6;
    3,4,1,3,7;
    3,5,1,3,8;
    
    4,2,1,3,9;
    4,3,1,3,10;
    4,4,1,3,11;
    4,5,1,3,12;
    
    5,2,1,3,13;
    5,3,1,3,14;
    5,4,1,3,15;
    5,5,1,3,16;
    
    6,2,1,3,17;
    6,3,1,3,18;
    6,4,1,3,19;
    6,5,1,3,20;
    ];

for i = 1:size(key,1)
    allDeforms(:,key(i,1),key(i,2),key(i,3),key(i,4)) = deformVals(:,key(i,5));
end
end

