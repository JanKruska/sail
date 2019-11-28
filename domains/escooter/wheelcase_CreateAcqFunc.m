function [acqFunction] = wheelcase_CreateAcqFunc(gpModel,d) 
    acqFunction = @(x)wheelcase_AcquisitionFunc(predictGP(gpModel{1},x), d);
end