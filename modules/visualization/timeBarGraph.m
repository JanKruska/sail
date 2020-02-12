function timeBarGraph(data,edges)
    bins = discretize(data,edges);
    [number,id]=hist(bins,unique(bins));
%     for i = 1:size(id,2)
%         id(1,i) = edges(id(1,i));
%     end
    
    
    binlabels = arrayfun(@(x)([num2str(edges(x)) ' - ' num2str(edges(x+1))]),id,'UniformOutput',false);
    
    
    
    
    
    binlabels = categorical(binlabels);
    %binlabels = reordercats(binlabels,binlabels);
    bar(binlabels,number);
    ylabel('Number of occurences');
end