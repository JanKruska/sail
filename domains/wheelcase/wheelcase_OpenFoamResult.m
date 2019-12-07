function fitness = wheelcase_OpenFoamResult(x, stlFileName,openFoamFolder)
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
fitness = nan;

% Create STL
stlwrite(stlFileName, x);

% Run SnappyHexMesh and OpenFOAM
[~,~] = system(['touch ' openFoamFolder 'start.signal']);
[err, out] = system(['(cd '   openFoamFolder '; ./Allrun)']);

if(err~=0)
   disp(['ERROR in Allrun' newline out]);
   errorFolder = ['error' int2str(randi(100,1)) '/'];
   system(['mkdir ' openFoamFolder errorFolder])
   save([openFoamFolder errorFolder 'error.mat']);
   system(['mv ' openFoamFolder 'log* ' openFoamFolder errorFolder]);
else
	% Wait for results
	resultOutputFile = [openFoamFolder 'result.dat'];
	tic;
	while ~exist([openFoamFolder 'mesh.timing'] ,'file')
		display(['Waiting for Meshing: ' seconds2human(toc)]);
		pause(10);
		if (toc > 300); fitness = nan; return; end;
	end
	%display(['|----| Meshing done in ' seconds2human(toc)]);

	tic;
	while ~exist([openFoamFolder 'all.timing'] ,'file')
		display(['Waiting for CFD: ' seconds2human(toc)]);
		pause(10);
		if (toc > 300); fitness = nan; return; end;
	end
	disp(['|----| CFD done in ' num2str(fscanf(fopen([openFoamFolder 'all.timing'],'r'),'%d')) ' seconds']);

	if exist(resultOutputFile, 'file')
		disp(resultOutputFile);
		result = importdata(resultOutputFile);
		cD = result.data(:,3);
		fitness = -mean(cD(100:200));
		disp(fitness);
		if fitness > 30 % Sanity check to prevent model destruction
			disp(['|-------> Drag Force calculated as ' num2str(fitness) ' (returning NaN)']);
			fitness = nan; 
			save([openFoamFolder  'error' int2str(randi(1000,1)) '.mat'], 'x');
		else
			disp(['|-------> Drag Force calculated as ' num2str(fitness)]);
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
    
