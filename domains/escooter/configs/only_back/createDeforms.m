function [allDeforms] = createDeforms(deformVals,ffdP)
%CREATEDEFORMS Summary of this function goes here
%   Detailed explanation goes here



allDefs = cat(4,ffdP.x,ffdP.y,ffdP.z);

allDeforms = permute(repmat(allDefs,[1 1 1 1 ffdP.nDeforms]),[5 1 2 3 4]);

%Patter x-coord,y-coord,z-coord,direction(x=1,y=2,z=3),index in genome
key = [
    6,1,1,3,1;
    6,2,1,3,2;
    6,3,1,3,3;
    6,4,1,3,4;
    6,5,1,3,5;
    6,6,1,3,6;
    ];

for i = 1:size(key,1)
    allDeforms(:,key(i,1),key(i,2),key(i,3),key(i,4)) = deformVals(:,key(i,5));
end
end

