function writeSTLs(path,stls)

for i=1:size(stls,2)
    stlwrite([path num2str(i) '.stl'],stls(i))
end