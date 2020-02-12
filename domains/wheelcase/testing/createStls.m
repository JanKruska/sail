function stls = createStls(predMap,d)
%stls = struct(size(predMap.genes,1),size(predMap.genes,2));
for i = 1:size(predMap.genes,1)
    for j = 1:size(predMap.genes,2)
        genome = squeeze(predMap.genes(i,j,:))';
        if(~any(isnan(genome)))
            stls(i,j) = d.express(genome);
        end
    end
end
end