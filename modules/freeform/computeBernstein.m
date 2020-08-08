function [ffdP] = computeBernstein(ffdP)
%computeBernstein compute Bernstein polynomials for Free-Form Deformation
% These won't change if we keep deforming the same shape, so we can
% save the results and skip all the computation in later runs.
%% Compute Bernstein polynomials
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

aux = cell(nDimX,nDimY,nDimZ);
for j = 1:nDimY
    for k = 1:nDimZ
        bernstein_yz = bernstein_y(j,:) .* bernstein_z(k,:);
        for i = 1:nDimX
            aux{i,j,k} = bernstein_x(i,:) .* bernstein_yz;
        end
    end
end
    
    %% Save Precomputable
%     ffdP.allDefs = allDefs;
%     ffdP.defValKey = defValKey;
%     ffdP.ffdDof = ffdDof;
%     ffdP.mesh_points = meshPoints;
    ffdP.bernstein_x = bernstein_x;
    ffdP.bernstein_y = bernstein_y;
    ffdP.bernstein_z = bernstein_z;
    ffdP.validIdxs = validIdxs;
    ffdP.aux = aux;
    %ffdP.meshPoints = meshPoints;
end

