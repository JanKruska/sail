function [acqFunction] = escooter_CreateAcqFunc(gpModel,d) 
    acqFunction = @(x)escooter_AcquisitionFunc(predictGP(gpModel{1},x), d);
end