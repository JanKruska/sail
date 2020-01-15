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
d.nCases   = parse.Results.nCases;
d.config = parse.Results.config;
d.caseStart = parse.Results.caseStart;

%------------- BEGIN CODE --------------

d.name = ['wheelcase_'];
rmpath( genpath('domains'));
addpath(genpath('domains/wheelcase/'));
%Add only the chosen config
rmpath(genpath('domains/wheelcase/configs/'));
addpath(genpath(['domains/wheelcase/configs/' d.config]))

% - Scripts 
% Common to any representations
d.preciseEvaluate   = 'wheelcase_PreciseEvaluate';    %
d.categorize        = 'wheelcase_Categorize';         %
d.createAcqFunction = 'wheelcase_CreateAcqFunc';      %
d.validate          = 'wheelcase_ValidateChildren';

% - Alternative initialization
d.loadInitialSamples = false;
d.initialSampleSource= '';


[stl.vertices,stl.faces] = readSTL('domains/wheelcase/ffd/combined_180.stl','JoinCorners',true);
ffdPLeft = makeFfdParameters(stl,['domains/wheelcase/configs/' d.config '/ffd_config_left.prm']);
ffdPRight = makeFfdParameters(stl,['domains/wheelcase/configs/' d.config '/ffd_config_right.prm']);
d.express = @(x)wheelcase_Express(x,ffdPLeft,ffdPRight);
d.base = stl.vertices;

%Right wheelcase & Steering space needed for maximum steering angle, used
%for constraint
[stl.vertices,stl.faces] = readSTL('domains/wheelcase/ffd/wheelcase_right_remesh.stl','JoinCorners',true);
ffdPWheelcase = makeFfdParameters(stl,['domains/wheelcase/configs/' d.config '/ffd_config_right.prm']);
d.expressRight = @(x)wheelcase_ExpressRight(x,ffdPWheelcase);

[d.steeringSpace.vertices,d.steeringSpace.faces] = readSTL('domains/wheelcase/ffd/turning_volume.stl','JoinCorners',true);
d.constraintVolumeBase = 1.6E6;

d.dof = getDof();

% - Feature Space
d.featureRes = [25 25];
d.nDims      = length(d.featureRes);
d.featureMin = [300 -600];
d.featureMax = [450 200];
% d.featureLabels = {'velo width', 'velo height'}; % {X label, Y label}
d.featureLabels = {'velo width', 'Y-Pos of widest point'}; % {X label, Y label}
d.extraMapValues = {'cD','confidence','constraint'};

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
