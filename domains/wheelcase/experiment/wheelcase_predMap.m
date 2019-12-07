function wheelcase_predMap(file)

load(file);
makeCaseFolders(d);
%% Create New Prediction Map from produced surrogate

% Adjust hyperparameters
p.nGens = 2*p.nGens;
 
predMap = createPredictionMap(...
            output.model,...               % Model for evaluation
            output.model{1}.trainInput,... % Initial solutions
            p,d,'featureRes',p.data.predMapRes);     % Hyperparameters
               
save(['sail' num2str(id) '_' int2str(iRun) '.mat'],'output','p','d','predMap');

foundDesigns = reshape(predMap.genes,[p.data.predMapRes(1)*p.data.predMapRes(2),d.dof]);
trueFit = feval(d.preciseEvaluate,foundDesigns,d);

rmCaseFolders(d);
makeCaseFolders(d);
save(['sail' num2str(id) '_' int2str(iRun) '.mat'],'output','p','d','predMap','trueFit');
rmCaseFolders(d);
end