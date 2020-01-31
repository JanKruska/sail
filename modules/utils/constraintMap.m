function [constraint] = constraintMap(genomes,d)

constraint = nan([size(genomes,1),size(genomes,2)]);
for i=1:size(genomes,1)
    for j=1:size(genomes,2)
        if(~any(isnan(genomes(i,j,:))))
            constraint(i,j) = penalty(d.expressRight(genomes(i,j,:)),d);
        end
    end
end