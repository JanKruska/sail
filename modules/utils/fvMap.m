function [fv] = fvMap(genomes,d)

fv = nan([size(genomes,1),size(genomes,2)]);
for i=1:size(genomes,1)
    for j=1:size(genomes,2)
        if(~any(isnan(genomes(i,j,:))))
            fv(i,j) = d.expressRight(genomes(i,j,:));
        end
    end
end