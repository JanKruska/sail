function [figHandle, layoutHandle] = compareMaps(mapUnconstrained, mapConstrained, d, varargin)
%computeFitness - Computes fitness with penalties from drag, lift, area
%
% Syntax:  viewMap(predMap.fitness, d)
%
% Inputs:
%   mapMatrix   - [RXC]  - scalar value in each bin (e.g. fitness)
%   d           - struct - Domain definition
%
% Outputs:
%   figHandle   - handle of resulting figure
%   imageHandle - handle of resulting map image
%
%
% Example:
%    p = sail;
%    d = af_Domain;
%    output = sail(d,p);
%    d.featureRes = [50 50];
%    predMap = createPredictionMap(output.model,p,d);
%    viewMap(predMap.fitness,d)
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: createMap, updateMap, createPredictionMap

% Author: Jan Kruska

%------------- BEGIN CODE --------------
parse = inputParser;
parse.addOptional('flip'  , false);
parse.addOptional('removeOutliers', false);

parse.parse(varargin{:});
flip = parse.Results.flip;
rmOutliers = parse.Results.removeOutliers;

mapRes = size(mapUnconstrained);
for i=1:length(mapRes)
    edges{i} = linspace(0,1,mapRes(i)+1); %#ok<AGROW>
end
%Resize to fit 2 plots
x0=500;
y0=500;
width=1000;
height=400;
set(gcf,'position',[x0,y0,width,height])

if rmOutliers
   [mapUnconstrained,num] = removeOutliers(mapUnconstrained);
   if num~=0
       disp(['Removed ' num2str(num) ' Outliers from unconstrained Map']);
   end
   [mapConstrained,num] = removeOutliers(mapConstrained);
   if num~=0
       disp(['Removed ' num2str(num) ' Outliers from constrained Map']);
   end
end
%get min and max value for coloring
bottom = min(cat(1,mapUnconstrained,mapConstrained),[],'all','omitnan');
top = max(cat(1,mapUnconstrained,mapConstrained),[],'all','omitnan');





layoutHandle = tiledlayout(1,2);
nexttile;

%%First map
yOffset = [-0.5 -0.0 0];
imgHandle = imagesc(flipud(rot90(mapUnconstrained))); fitPlot = gca;

if flip
    imgHandle = imagesc(fliplr(rot90(rot90(mapUnconstrained)))); fitPlot = gca;
end


set(imgHandle,'AlphaData',~isnan(imgHandle.CData)*1)
xlab = xlabel([d.featureLabels{1} '\rightarrow']);
ylab = ylabel(['\leftarrow ' d.featureLabels{2} ]);
set(ylab,'Rotation',90,'Position',get(ylab,'Position')-yOffset)
title('Unconstrained');


xticklabels = num2str(edges{2}',2);
if length(xticklabels)>10
    keep = false(1,length(xticklabels));
    keep(1:round(length(xticklabels)/10):length(xticklabels)) = true;
    xticklabels(~keep,:)= ' ';
end

yticklabels = num2str(edges{1}(end:-1:1)',2);
if length(yticklabels)>10
    keep = false(1,length(yticklabels));
    keep(1:round(length(yticklabels)/10):length(yticklabels)) = true;
    yticklabels(~keep,:)= ' ';
end
xticklabels = {}; yticklabels = {};
set(fitPlot,...
    'XTickLabel',xticklabels,...
    'XTick', linspace(0.5,d.featureRes(2)+0.5,d.featureRes(2)+1), ...
    'YTickLabel',yticklabels,...
    'YTick', linspace(0.5,d.featureRes(1)+0.5,d.featureRes(1)+1),...
    'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-',...
    'xcolor', 'k', 'ycolor', 'k'...
    )

caxis manual
caxis([bottom top]);
% colorbar;
axis square


%Second map
nexttile;
imgHandle = imagesc(flipud(rot90(mapConstrained))); fitPlot2 = gca;
if flip
    imgHandle = imagesc(fliplr(rot90(rot90(mapUnconstrained)))); fitPlot = gca;
end

set(imgHandle,'AlphaData',~isnan(imgHandle.CData)*1)
xlab = xlabel([d.featureLabels{1} '\rightarrow']);
ylab = ylabel(['\leftarrow ' d.featureLabels{2} ]);
set(ylab,'Rotation',90,'Position',get(ylab,'Position')-yOffset)
title('Constrained');


xticklabels = num2str(edges{2}',2);
if length(xticklabels)>10
    keep = false(1,length(xticklabels));
    keep(1:round(length(xticklabels)/10):length(xticklabels)) = true;
    xticklabels(~keep,:)= ' ';
end

yticklabels = num2str(edges{1}(end:-1:1)',2);
if length(yticklabels)>10
    keep = false(1,length(yticklabels));
    keep(1:round(length(yticklabels)/10):length(yticklabels)) = true;
    yticklabels(~keep,:)= ' ';
end
xticklabels = {}; yticklabels = {};
set(fitPlot2,...
    'XTickLabel',xticklabels,...
    'XTick', linspace(0.5,d.featureRes(2)+0.5,d.featureRes(2)+1), ...
    'YTickLabel',yticklabels,...
    'YTick', linspace(0.5,d.featureRes(1)+0.5,d.featureRes(1)+1),...
    'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-',...
    'xcolor', 'k', 'ycolor', 'k'...
    )

caxis manual
caxis([bottom top]);
colorbar;
axis square
figHandle = fitPlot;

%------------- END OF CODE --------------