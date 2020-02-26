function r = dimRegress(map,dim,degree)
clf;
num = numel(map);
r = nan;

flattened = reshape(map,[1,num]);
if(dim==1)
    indices = repmat(1:size(map,dim),[1,num/size(map,dim)]);
elseif(dim==2)
    indices = repelem(1:size(map,dim),num/size(map,dim));
end
nanIdx = isnan(flattened);
flattened = flattened(~nanIdx);
indices = indices(~nanIdx);

[p,S] = polyfit(indices,flattened,degree);
scatter(indices,flattened);
hold on;
plot(linspace(1,25),polyval(p,linspace(1,25)));
hold off;

if(degree == 1)
 [r,m,b] = regression(flattened,indices);
%  annotation('textbox',[.75 .55 .3 .3],'String',['r=' num2str(r)],'FitBoxToText','on');
end

if(dim==1)
    xlabel('Column index');
elseif(dim==2)
    xlabel('Row index');
end
end