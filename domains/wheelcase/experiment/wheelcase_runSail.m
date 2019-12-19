function wheelcase_runSail(varargin)
% Runs SAIL velomobile optimization on cluster - [RUN THROUGH QSUB]
%
% Syntax:  [output1,output2] = function_name(input1,input2,input3)
%

% Author: Jan Kruska

%------------- BEGIN CODE --------------
parse = inputParser;
parse.addOptional('nCases'  , 1);
parse.addOptional('caseStart', 1);
parse.addOptional('config','config1');

parse.addOptional('gens',6);

parse.parse(varargin{:});
nCases   = parse.Results.nCases;
config = parse.Results.config;
caseStart = parse.Results.caseStart;
gens = parse.Results.gens;

id = getenv('SLURM_JOB_ID');

disp([nCases caseStart]);

%% Parallelization Settings
if batchStartupOptionUsed
    parpool;
end
% Ensure Randomness of Randomness
% RandStream.setGlobalStream(RandStream('mt19937ar','Seed','shuffle'));

% % Create Temp Directory for Multithreading
% tmpdir = getenv('TMPDIR');
% if isempty(tmpdir);tmpdir='/tmp';end
% myCluster.JobStorageLocation  = tmpdir;
% myCluster.HasSharedFilesystem = true;

%% Add all files to path
addpath(genpath('~/Code/sail/'));
addpath(genpath('~/Code/matlabExtensions/'));
cd ~/Code/sail

nRuns = 1;
for iRun = 1:nRuns

%% Algorithm hyperparameters 
	p = sail;               % loads default hyperparameters
	 p.nInitialSamples   = 60;   
	 p.nAdditionalSamples= 10;    
	 p.nTotalSamples	 = 1000;       
	  
	 p.nChildren         = 2^5;
	 p.nGens             = 2^gens;
	 
	 p.display.illu      = false;  
	 
	 p.data.mapEval      = false;   % produce intermediate prediction maps?
	 p.data.mapEvalMod   = 250;      % how often? (in samples)     
     p.data.predMapRes   = [25 25];  
	 
% Domain hyperparameters 
d = wheelcase_Domain(...
    'nCases',nCases,...
    'caseStart',caseStart,...
    'config',config);

% Use Dummy Evaluation 
d.preciseEvaluate = 'wheelcase_DummyPreciseEvaluate';
 
%% Run SAIL
runTime = tic;
disp('Running SAIL')
rmCaseFolders(d);
makeCaseFolders(d);
output = sail(p,d);
disp(['Runtime: ' seconds2human(toc(runTime))]);

%% Create New Prediction Map from produced surrogate

% Adjust hyperparameters
p.nGens = 2*p.nGens;
 
predMap = createPredictionMap(...
            output.model,...               % Model for evaluation
            output.model{1}.trainInput,... % Initial solutions
            p,d,'featureRes',p.data.predMapRes);     % Hyperparameters
               
save(['sail' num2str(id) '_' int2str(iRun) '.mat'],'output','p','d','predMap');

foundDesigns = reshape(predMap.genes,[p.data.predMapRes(1)*p.data.predMapRes(2),d.dof]);
%trueFit = feval(d.preciseEvaluate,foundDesigns,d);

%save(['sail' num2str(id) '_' int2str(iRun) '.mat'],'output','p','d','predMap','trueFit');
rmCaseFolders(d);
end

%------------- END OF CODE --------------
