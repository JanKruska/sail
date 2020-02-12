function viewImprovementOverGens(percImproved)
%Filter out empty columns
    percImproved = percImproved(:,sum(percImproved,1)~=0);
    graphs = zeros(size(percImproved));
    for i=1:size(graphs,1)
        if(i<6)
            lowerend=1;
        else
            lowerend=i-5;
        end
        if(i>(size(graphs,1)-5))
           upperend = size(graphs,1);
        else
           upperend = i+5; 
        end
        graphs(i,:) = mean(percImproved(lowerend:upperend,:),1);
    end
    err = std(graphs,0,2);
    shadedErrorBar([],graphs',{@mean,@std});
    
    xlabel('Generations');
    ylabel('% of improved children');
end