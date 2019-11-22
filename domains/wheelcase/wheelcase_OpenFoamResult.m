function dragF = wheelcase_OpenFoamResult(x, stlFileName,openFoamFolder)
%wheelcase_OpenFoamResult - Evaluates a single shape in OpenFOAM
%
% Syntax:  [observation, value] = af_InitialSamples(p)
%
% Inputs:
%    x              - Sample genome to evaluate
%    stlFileName    - Target to place expressed genome
%    openFoamFolder - OpenFOAM case folder
%
% Outputs:
%    drag F  - [1X1] drag force result
%
%------------- BEGIN CODE --------------
dragF = nan;

% Create STL
stlwrite(stlFileName, x);

% Run SnappyHexMesh and OpenFOAM
[~,~] = system(['touch ' openFoamFolder 'start.signal']);
[err, out] = system(['(cd '   openFoamFolder '; ./Allrun)']);

if(err~=0)
   disp(['ERROR in Allrun' newline out]);
   save([openFoamFolder  'error' int2str(randi(100,1)) '.mat']);
else
	% Wait for results
	resultOutputFile = [openFoamFolder 'result.dat'];
	tic;
	while ~exist([openFoamFolder 'mesh.timing'] ,'file')
		display(['Waiting for Meshing: ' seconds2human(toc)]);
		pause(10);
		if (toc > 300); dragF = nan; return; end;
	end
	display(['|----| Meshing done in ' seconds2human(toc)]);

	tic;
	while ~exist([openFoamFolder 'all.timing'] ,'file')
		display(['Waiting for CFD: ' seconds2human(toc)]);
		pause(10);
		if (toc > 300); dragF = nan; return; end;
	end
	display(['|----| CFD done in ' seconds2human(toc)]);

	if exist(resultOutputFile, 'file')
		disp(resultOutputFile);
		result = importdata(resultOutputFile);
		cD = result.data(:,3);
		dragF = -mean(cD(100:200));
		disp(dragF);
		if dragF > 30 % Sanity check to prevent model destruction
			disp(['|-------> Drag Force calculated as ' num2str(dragF) ' (returning NaN)']);
			dragF = nan; 
			save([openFoamFolder  'error' int2str(randi(1000,1)) '.mat'], 'x');
		else
			disp(['|-------> Drag Force calculated as ' num2str(dragF)]);
		end
	else
		save([openFoamFolder  'error' int2str(randi(100,1)) '.mat']);    
	end
end

system(['touch ' openFoamFolder 'done.signal']);
[err, out] = system(['(cd '   openFoamFolder '; ./Allclean)']);
if(err~=0)
   disp(['ERROR in Allclean' newline out]); 
end
    
