function d = wheelcase_Domain(varargin)
%velo_Domain - Wheelcase Domain Parameters 
% Returns struct with default for all settings of Wheelcase domain
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
nCases   = parse.Results.nCases;
config = parse.Results.config;
d.caseStart = parse.Results.caseStart;

%------------- BEGIN CODE --------------

d.name = ['wheelcase_'];
rmpath( genpath('domains'));
addpath(genpath('domains/wheelcase/'));
%Add only the chosen config
rmpath(genpath('domains/wheelcase/configs/'));
addpath(genpath(['domains/wheelcase/configs/' config]))

% - Scripts 
% Common to any representations
d.preciseEvaluate   = 'wheelcase_PreciseEvaluate';    %
d.categorize        = 'wheelcase_Categorize';         %
d.createAcqFunction = 'wheelcase_CreateAcqFunc';      %
d.validate          = 'wheelcase_ValidateChildren';

% - Alternative initialization
d.loadInitialSamples = false;
d.initialSampleSource= '';

%Sobol parameters
d.sobolScale = @(x)wheelcase_SobolScale(x);



stl = stlread('domains/wheelcase/ffd/combined_180.stl');
ffdPLeft = makeFfdParameters(stl,['domains/wheelcase/configs/' config '/ffd_config_left.prm']);
ffdPRight = makeFfdParameters(stl,['domains/wheelcase/configs/' config '/ffd_config_right.prm']);
d.express = @(x)wheelcase_Express(x,ffdPLeft,ffdPRight);
d.base = stl.vertices;

d.dof = 6;

% - Feature Space
d.featureRes = [25 25];
d.nDims      = length(d.featureRes);
d.featureMin = [0 0];
d.featureMax = [4 0.2];
d.featureLabels = {'velo width', 'velo height'}; % {X label, Y label}
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
 d.baseFolder = ['~/Code/sail/domains/wheelcase/pe/v1906/'];
% %------------- END OF CODE --------------
