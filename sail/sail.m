function [output] = sail(p,d)
%SAIL - Surrogate Assisted Illumination Algorithm
% Main run script of SAIL algorithm
%
% Syntax:  [output] = sail(p)   
%
% Inputs:
%   p  - struct - Hyperparameters for algorithm, visualization, and data gathering
%   d  - struct - Domain definition
%    * - sail with no arguments to return default parameter struct
%
% Outputs:
%    output - output struct with fields:
%               .output.model{1}             - gpModels produced by SAIL
%               .output.model{1}.trainInput  - input samples
%               .output.model{1}.trainOutput - sample results
%               .p - parameter struct (for data keeping)
%               .* - other parameters recorded throughout run
%
% Example: 
%    p = sail;                                  % Load default parameters
%    p.nTotalSamples = 80;                      % Edit default parameters
%    d = af_Domain;                             % Load domain parameters
%    output = sail(d,p);                        % Run SAIL algorithm
%    predMap = createPredictionMap(output.model,p,d);
%    viewMap(predMap.fitness, p, d)             % View Prediction Map   
%
%
% Other m-files required: 
%   defaultParamSet, initialSampling, trainGP,
%   createMap, nicheCompete, updateMap, mapElites, sobolset
%
% Other submodules required: map-elites, gpml-wrapper
%
% MAT-files required: if loading initial samples "d.initialSampleSource"
%
% See also: runSail, createPredictionMap, mapElites

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: adam.gaier@h-brs.de
% Nov 2016; Last revision: 01-Aug-2017

%------------- BEGIN CODE --------------

if nargin==0; output = defaultParamSet; return; end

%% 0 - Produce Initial Samples
if ~d.loadInitialSamples
    [observation, value] = initialSampling(d,p.nInitialSamples);
else
    load(d.initialSampleSource);
    randomPick = randperm(10000,p.nInitialSamples);
    observation = observation(randomPick,:);
    value = value(randomPick,:);
end
nSamples = size(observation,1);


%% Acquisition Loop
while nSamples <= p.nTotalSamples
    
    %% 1 - Create Surrogate and Acquisition Function
    % Surrogate models are created from all evaluated samples, and these
    % models are used to produce an acquisition function. 
    
    disp(['PE ' int2str(nSamples) ' | Training Surrogate Models']); 
    parfor iModel = 1:size(value,2)
       gpModel{iModel} = trainGP(observation, value(:,iModel), d.gpParams(iModel))
    end
    acqFunction = feval(d.createAcqFunction, gpModel, d);                                         
    
    %% 2 - Initialize MAP with Initial Samples
    % A map is constructed using the evaluated samples are tested with the
    % acquisition function and placed in a map as the initial population.

    % Evaluate data set with acquisition function
    [fitness,predValues] = acqFunction(observation);
    
    % Place Best Samples in Map with Predicted Fitness
    obsMap = createMap(d.featureRes, d.dof, d.extraMapValues);
    [replaced, replacement] = nicheCompete(observation, fitness, obsMap, d);
    obsMap = updateMap(replaced,replacement,obsMap,fitness,observation,...
                        predValues,d.extraMapValues);
       
    %% 3 - Illuminate Acquisition Map
    % An acquisition map is created by using MAP-Elites to optimize the
    % acquisition function in every bin.
    
    disp(['PE: ' int2str(nSamples) '| Illuminating Acquisition Map']);
    acqMap = mapElites(acqFunction,obsMap,p,d);

    %% 3.2 - Save data for Analysis
    %feval(d.saveData);

    %% 4 - Select Infill Samples
    % The next samples to be tested are chosen from the acquisition map,
    % this is done with a sobol sequence to even sample the map in the
    % feature dimensions. When evaluated solutions don't converge the next
    % in bin in the sobol set is chosen.
    
    % At first iteration initialize sobol sequence for sample selection
    if nSamples == p.nInitialSamples    
        sobSet  = scramble(sobolset(d.nDims,'Skip',1e3),'MatousekAffineOwen');
        sobPoint= 1;
    end   
    
    % On Final illumination, no infill
    if nSamples == p.nTotalSamples; break; else
        
        newValue = nan(p.nAdditionalSamples, size(value,2)); % new values will be stored here
        noValue = any(isnan(newValue),2);
        
        while any(any(noValue))
            nNans = sum(noValue);
            nextGenes = nan(nNans,d.dof); % Create one 'blank' genome for each NAN
            
            % Identify (grab indx of NANs)
            nanIndx = 1:p.nAdditionalSamples;  nanIndx = nanIndx(noValue);
            
            % Replace with next in Sobol Sequence
            newSampleRange = sobPoint:(sobPoint+nNans-1);
            mapLinIndx = sobol2indx(sobSet,newSampleRange,d, acqMap.edges);
            [chosenI,chosenJ] = ind2sub(d.featureRes, mapLinIndx);
            for iGenes=1:nNans % Pull out chosen genomes from map
                nextGenes(iGenes,:) = acqMap.genes(chosenI(iGenes),chosenJ(iGenes),:);
            end
            
            % Evaluate
            measuredValue = feval(d.preciseEvaluate, nextGenes, d);
            
            % Assign found values
            newValue(nanIndx,:) = measuredValue;
            noValue = any(isnan(newValue),2);
            nextObservation(nanIndx,:) = nextGenes;         %#ok<AGROW>
            sobPoint = sobPoint + length(newSampleRange);   % Increment sobol sequence for next samples
        end
        
        % Add evaluated solutions to data set
        value = cat(1,value,newValue);
        observation = cat(1,observation,nextObservation);
        nSamples  = size(observation,1);
    end
end % end acquisition loop

output.p = p;
output.model = gpModel;
end




