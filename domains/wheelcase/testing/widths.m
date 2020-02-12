function w = widths(stls)
w = nan(size(stls));
for i = 1:size(stls,1)
    for j = 1:size(stls,2)
        if(~isempty(stls(i,j).vertices))
            w(i,j) = max(stls(i,j).vertices(:,2));
        end
    end
end
end