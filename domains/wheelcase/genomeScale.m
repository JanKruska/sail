function [seq] = genomeScale(seq)

if(size(seq,2)==6)
    %Scale genes mapped to y
    seq(:,[3,4]) = seq(:,[3,4]) .* 2 - 1;
    %Scale genes mapped to x,z
    seq(:,[1,2,5,6]) = seq(:,[1,2,5,6]) .* 0.4 - 0.2;
elseif(size(seq,2)==12)
    %Scale genes mapped to y
    seq(:,5:8) = (seq(:,5:8) - 0) ./ (1 - 0) .* (0 -(-2)) + (-2);
    %Scale genes mapped to x,z
    seq(:,[1:4,9:12]) = (seq(:,[1:4,9:12]) - 0) ./ (1 - 0) .* (0.2 -(-0.2)) + (-0.2);
end
end