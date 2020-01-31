function [seq] = genomeScale(seq)

if(size(seq,2)==6)
    %Scale genes mapped to y
    seq(:,[3,4]) = seq(:,[3,4]) .* 3 - 1;
    %Scale genes mapped to x,z
    seq(:,[1,2,5,6]) = seq(:,[1,2,5,6]) .* 1 - 0.5;
elseif(size(seq,2)==12)
    %Scale genes mapped to y
    seq(:,5:8) = seq(:,5:8) .* 2 - 1;
    %Scale genes mapped to x,z
    seq(:,[1:4,9:12]) = seq(:,[1:4,9:12]) .* 0.4 - 0.2;
elseif(size(seq,2)==18)
    %Scale genes mapped to y
    seq(:,7:12) = seq(:,7:12) .* 3 - 1;
    %Scale genes mapped to x,z
    seq(:,[1:6,13:18]) = seq(:,[1:6,13:18]) .* 1 - 0.5;
end
end