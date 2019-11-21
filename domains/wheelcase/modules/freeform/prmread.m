function [ffdP] = prmread(file)
%READ Summary of this function goes here
%   Detailed explanation goes here
sectionHeader = '(?<!\[).*(?=\])';
%%Code
    if ~exist(file,'file')
        error(['File ''%s'' not found. If the file is not on MATLAB''s path' ...
               ', be sure to specify the full path to the file.'], file);
    end
    
    fid = fopen(file,'r');    
    if ~isempty(ferror(fid))
        error(lasterror); %#ok
    end
    
    content = textscan(fid,'%s','Delimiter',{'\n'},'CommentStyle','#');
    
    keyValuePairs = {};%cell(size(content{1,1},1),2);
    key='';
    ctr = 1;
    for i = 1:size(content{1,1})
        line = content{1,1}{i,1};
        
        isExpression = ~isempty(regexp(line,'[:=]', 'once'));
        if(isExpression)
            if(~isempty(key))
                keyValuePairs(ctr,:) = {key,value};
                ctr = ctr + 1;
            end
            %Next Pair
            split = regexp(line,':','split');
            key = split{1};
            value = split{2};
        elseif(~isempty(key) && isempty(regexp(line,sectionHeader, 'once')))%There is a previous line to append to
            value = [value ' ' line];                                   %and the current line is not a section header
        end
    end
    keyValuePairs(ctr,:) = {key,value};
    
    for i = 1:size(keyValuePairs,1)
        switch(keyValuePairs{i,1})
            case 'n control points x'
                ffdP.nDimX = str2double(keyValuePairs{i,2});
            case 'n control points y'
                ffdP.nDimY = str2double(keyValuePairs{i,2});
            case 'n control points z'
                ffdP.nDimZ = str2double(keyValuePairs{i,2});
            case 'box length x'
                ffdP.xHeight = str2double(keyValuePairs{i,2});
            case 'box length y'
                ffdP.yHeight = str2double(keyValuePairs{i,2});
            case 'box length z'
                ffdP.zHeight = str2double(keyValuePairs{i,2});
            case 'box origin x'
                ffdP.xOrigin = str2double(keyValuePairs{i,2});
            case 'box origin y'
                ffdP.yOrigin = str2double(keyValuePairs{i,2});
            case 'box origin z'
                ffdP.zOrigin = str2double(keyValuePairs{i,2});
            case 'rotation angle x'
                ffdP.rotationAngleX = str2double(keyValuePairs{i,2});
            case 'rotation angle y'
                ffdP.rotationAngleY = str2double(keyValuePairs{i,2});
            case 'rotation angle z'
                ffdP.rotationAngleZ = str2double(keyValuePairs{i,2});
            case 'parameter x'
                ffdP.x = parameterMatrix(keyValuePairs{i,2},ffdP);
            case 'parameter y'
                ffdP.y = parameterMatrix(keyValuePairs{i,2},ffdP);
            case 'parameter z'
                ffdP.z = parameterMatrix(keyValuePairs{i,2},ffdP);
                
        end
    end
end

function matrix = parameterMatrix(table,ffdP)
    matrix = zeros(ffdP.nDimX,ffdP.nDimY,ffdP.nDimZ);
    numbers = string(regexp(table, '\d+.\d+|\d+', 'match'));
    for i = 1:4:size(numbers,2)
        matrix(str2double(numbers(1,i))+1,...
            str2double(numbers(1,i+1))+1,...
            str2double(numbers(1,i+2))+1) = str2double(numbers{1,i+3});
    end
end