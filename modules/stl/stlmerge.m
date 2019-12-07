function FV = stlmerge(first,second)
    FV.vertices = cat(1,first.vertices,second.vertices);
    FV.faces = cat(1,first.faces,second.faces+size(first.vertices,1));
end