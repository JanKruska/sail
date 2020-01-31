function viewMapImprovements(mapUnconstrained, mapConstrained, d)
    mapImprovements = mapConstrained - mapUnconstrained;
    mapImprovements(mapImprovements>0) = nan;
    viewMap(mapImprovements,d);
end