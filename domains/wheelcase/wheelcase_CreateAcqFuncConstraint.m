function [acqFunction] = wheelcase_CreateAcqFuncConstraint(gpModel,d) 
    acqFunction = @(x)wheelcase_AcquisitionFuncConstraint(predictGP(gpModel{1},x),x, d);
end