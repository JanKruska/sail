function [seq] = genomeScale(seq)
% scales the genome to the desired range
% in general we want to allow strong deformations in y to deform the
% wheelcase outwards, but want to avoid strong deformaation in x & z

% seq - Sequence of numbers in range [0;1]

%First third x, next third y, last third z
num = size(seq,2)/3;
xRange = 1:num;
yRange = 1+num:2*num;
zRange = 1+2*num:3*num;

%Scale genes mapped to y
seq(:,yRange) = seq(:,yRange) .* 3 - 1;
%Scale genes mapped to x,z
seq(:,[xRange,zRange]) = seq(:,[xRange,zRange]) .* 1 - 0.5;
end