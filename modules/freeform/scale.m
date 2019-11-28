function points = scale(points,ffdP)
    points(:,1) = (points(:,1)-ffdP.xOrigin)./ffdP.xHeight;
    points(:,2) = (points(:,2)-ffdP.yOrigin)./ffdP.yHeight;
    points(:,3) = (points(:,3)-ffdP.zOrigin)./ffdP.zHeight;
end