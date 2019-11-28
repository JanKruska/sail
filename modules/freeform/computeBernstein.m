function [ffdP] = computeBernstein(ffdP)
%COMPUTEBERNSTEIN Summary of this function goes here
%   Detailed explanation goes here
%% Compute Bernstein polynomials
    % These won't change if we keep deforming the same shape, so we can
    % save the results and skip all the computation in later runs.
    nDimX = ffdP.nDimX;
    nDimY = ffdP.nDimY;
    nDimZ = ffdP.nDimZ;
    % Scale to bounding box of deformation
    meshPoints = scale(ffdP.meshPoints,ffdP);
    
    validIdxs = find(all((meshPoints>=0 & meshPoints<=1),2));
    nMeshPoints = size(validIdxs,1);
    validPoints = meshPoints(validIdxs,:);
    
    % Preallocate
    bernstein_x = zeros(ffdP.nDimX,nMeshPoints);
    bernstein_y = zeros(ffdP.nDimY,nMeshPoints);
    bernstein_z = zeros(ffdP.nDimZ,nMeshPoints);
    
    % Compute Bernstein polynomials
    for i = 1:nDimX
        aux1 = (1-validPoints(:,1)) .^(nDimX-i);
        aux2 = (  validPoints(:,1)) .^(i-1);
        bernstein_x(i,:) = nchoosek(nDimX-1, i-1) .* (aux1' .* aux2');
    end
    
    for i = 1:nDimY
        aux1 = (1-validPoints(:,2)) .^(nDimY-i);
        aux2 = (  validPoints(:,2)) .^(i-1);
        bernstein_y(i,:) = nchoosek(nDimY-1, i-1) .* (aux1' .* aux2');
    end
    
    for i = 1:nDimZ
        aux1 = (1-validPoints(:,3)) .^(nDimZ-i);
        aux2 = (  validPoints(:,3)) .^(i-1);
        bernstein_z(i,:) = nchoosek(nDimZ-1, i-1) .* (aux1' .* aux2');
    end
    
    %Unscale all point that wont be modified by ffd
% meshPoints(setdiff(1:end,validIdxs),1) = meshPoints(setdiff(1:end,validIdxs),1).*ffdP.xHeight+ffdP.xOrigin;
% meshPoints(setdiff(1:end,validIdxs),2) = meshPoints(setdiff(1:end,validIdxs),2).*ffdP.yHeight+ffdP.yOrigin;
% meshPoints(setdiff(1:end,validIdxs),3) = meshPoints(setdiff(1:end,validIdxs),3).*ffdP.zHeight+ffdP.zOrigin;
    
    %% Save Precomputable
%     ffdP.allDefs = allDefs;
%     ffdP.defValKey = defValKey;
%     ffdP.ffdDof = ffdDof;
%     ffdP.mesh_points = meshPoints;
    ffdP.bernstein_x = bernstein_x;
    ffdP.bernstein_y = bernstein_y;
    ffdP.bernstein_z = bernstein_z;
    ffdP.validIdxs = validIdxs;
    %ffdP.meshPoints = meshPoints;
end

