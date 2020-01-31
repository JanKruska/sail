function [result,numOutliers] = removeOutliers(array)
    dims = size(array);
    flattened = reshape(array,[numel(array),1]);
    [flattened,TF] = filloutliers(flattened,nan);
    result = reshape(flattened,dims);
    numOutliers = sum(TF);
end