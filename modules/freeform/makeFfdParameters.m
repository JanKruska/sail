function ffdP = makeFfdParameters(stl,prmfile)
    ffdP = prmread(prmfile);
    ffdP.meshPoints = stl.vertices;
    ffdP.faces = stl.faces;
    ffdP = computeBernstein(ffdP);
end