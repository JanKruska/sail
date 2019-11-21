function [vertices] = position_vertices(ffdParams)
%The position of the vertices of the FFD bounding box.
vertices = [ffdParams.boxOrigin;
    (rotation_Matrix(ffdParams)*diag(ffdParams.boxLength))'];
end

