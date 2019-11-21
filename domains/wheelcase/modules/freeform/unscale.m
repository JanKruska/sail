function points = unscale(points,ffdP)
    points(:,1) = points(:,1).*ffdP.xHeight+ffdP.xOrigin;
    points(:,2) = points(:,2).*ffdP.yHeight+ffdP.yOrigin;
    points(:,3) = points(:,3).*ffdP.zHeight+ffdP.zOrigin;
end