function createMapSTLs(path,predMap,d)
system(['rm ' path '*.stl']);
for i = 1:size(predMap.genes,1)
    for j = 1:size(predMap.genes,2)
        genome = squeeze(predMap.genes(i,j,:))';
        if(~any(isnan(genome)))
            stlwrite([path num2str(i) '-' num2str(j) '.stl'],d.express(genome));
        end
    end
end
end