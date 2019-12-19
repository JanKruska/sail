function [value] = wheelcase_PreciseEvaluate(nextObservations, d)
%wheelcase_PreciseEvaluate - Send velomobile shapes in parallel to OpenFOAM func
%
% Syntax:  [observation, value] = af_InitialSamples(p)
%
% Inputs:
%    nextObservations - [NX1] of FV structs - Samples to evaluate
%    d                - domain description struct
%     .openFoamFolder 
%
% Outputs:
%    value(:,1)  - [nObservations X 1] drag force
%------------- BEGIN CODE --------------
folderBaseName = d.openFoamFolder;

% Divide individuals to be evaluated by number of cases
nObs    = size(nextObservations,1);
nCases  = d.nCases;
nRounds = ceil(nObs/d.nCases);
caseStart = d.caseStart;
tic
value = nan(nObs,1);
for iRound=0:nRounds-1
    PEValue = nan(nCases,1);
    % Evaluate as many samples as you have cases in a batch
    parfor iCase = 1:nCases
        obsIndx = iRound*nCases+iCase;          
        if obsIndx <= nObs
            openFoamFolder = [folderBaseName 'case' int2str(iCase+caseStart-1) '/']
            PEValue(iCase) = wheelcase_OpenFoamResult(...
               d.express(nextObservations(obsIndx,:)),...
               [openFoamFolder 'constant/triSurface/all_deformed.stl'],...
               openFoamFolder);
        end
    end  
    disp(['Round ' int2str(iRound) ' -- Time so far ' seconds2human(toc)])
   
    % Assign results of batch 
    obsIndices = 1+iRound*nCases:nCases+iRound*nCases;
    filledIndices = obsIndices(obsIndices<=nObs);
    value(filledIndices) = PEValue(1:length(filledIndices));
end
nonConstraintIdxs = or(nextObservations(:,3) > -1.5, nextObservations(:,3) > -0.2);
value(nonConstraintIdxs) = value(nonConstraintIdxs) + 1;

%------------- END OF CODE --------------