function d = escooter_Domain(varargin)
%escooter_Domain - E-Scooter Domain Parameters 
% Returns struct with default for all settings of escooter domain
% including hyperparameters, and strings indicating functions for
% representation and evaluation.
%
%
%Optional Inputs
%	nCases		- number of OpenFoamCases, that can be evaluated in parallel
%	config		- configuration to use, name of folder in ./configs/ which contains configuration specific files

% Author: Jan Kruska
%------------- Input Parsing ------------
parse = inputParser;
parse.addOptional('nCases'  , 10);
parse.addOptional('caseStart', 1);
parse.addOptional('config','config1');

parse.parse(varargin{:});
d.nCases   = parse.Results.nCases;
config = parse.Results.config;
d.caseStart = parse.Results.caseStart;

%------------- BEGIN CODE --------------

d.name = ['escooter_'];
rmpath( genpath('domains'));
addpath(genpath('domains/escooter/'));
% Add only the chosen config
rmpath(genpath('domains/escooter/configs/'));
addpath(genpath(['domains/escooter/configs/' config]))

% - Scripts 
% Common to any representations
d.preciseEvaluate   = 'escooter_PreciseEvaluate';    %
d.categorize        = 'escooter_Categorize';         %
d.createAcqFunction = 'escooter_CreateAcqFunc';      %
d.validate          = 'escooter_ValidateChildren';

% - Alternative initialization
d.loadInitialSamples = false;
d.initialSampleSource= '';

[stl.vertices,stl.faces] = readSTL('domains/escooter/ffd/deformable_component.stl','JoinCorners',true);
ffdP = makeFfdParameters(stl,['domains/escooter/configs/' config '/ffd_config.prm']);
d.express = @(x)escooter_Express(x,ffdP);
[d.base.vertices,d.base.faces] = readSTL('domains/escooter/ffd/CFD_Model_V2.5.stl','JoinCorners',true);

d.dof = getDof();

% - Feature Space
d.featureRes = [25 25];
d.nDims      = length(d.featureRes);
d.featureMin = [80 -160];
d.featureMax = [220 -410];
d.featureLabels = {'lowest point', 'x-Pos of lowest Point'}; % {X label, Y label}
d.extraMapValues = {'cD','confidence'};

% - GP Models
d.gpParams(1)= paramsGP(d.dof); % Drag Force
d.gpParams(2)= paramsGP(d.dof); % Lift
d.nVals = 2; % number of values of interest

% Acquisition function
d.varCoef = 2;  % variance weight
d.muCoef  = 1;  % mean weight 

% Cluster
% % Cases are executed and stored here (cases are started elsewhere)
 d.openFoamFolder = ['/scratch/jkrusk2s/sailCFD/']; 
 d.baseFolder = ['~/Code/sail/domains/escooter/pe/v1906/'];
% %------------- END OF CODE --------------
