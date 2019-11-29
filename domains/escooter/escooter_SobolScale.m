function [seq] = escooter_SobolScale(seq)

if(size(seq,2)==6)
    %Scale genes mapped to y
    seq(:,[3,4]) = (seq(:,[3,4]) - 0) ./ (1 - 0) .* (0 -(-2)) + (-2);
    %Scale genes mapped to x,z
    seq(:,[1,2,5,6]) = (seq(:,[1,2,5,6]) - 0) ./ (1 - 0) .* (0.2 -(-0.2)) + (-0.2);
end
end