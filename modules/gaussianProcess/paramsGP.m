function p = paramsGP(nInputs)
%paramsGP - Creates Gaussian Process parameter struct
%Optional file header info (to give more details about the function than in the H1 line)
%Optional file header info (to give more details about the function than in the H1 line)
%Optional file header info (to give more details about the function than in the H1 line)
%
% Syntax:  [output1,output2] = function_name(input1,input2,input3)
%
% Inputs:
%    input1 - Description
%    input2 - Description
%    input3 - Description
%
% Outputs:
%    output1 - Description
%    output2 - Description
%
% Example: 
%    Line 1 of example
%    Line 2 of example
%    Line 3 of example
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: OTHER_FUNCTION_NAME1,  OTHER_FUNCTION_NAME2

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: adam.gaier@h-brs.de
% Jun 2016; Last revision: 02-Jun-2016

%------------- BEGIN CODE --------------

p.covfunc   = @covSEiso;             
p.hyp.cov   = [log(0.5);0];%log(ell); log(sigma)

p.meanfunc  = {@meanConst};  
p.hyp.mean  = 0;

p.likfunc   = @likGauss;     
p.hyp.lik   = log(1); % log(sigma)

p.functionEvals = 100;      % function evals to optimize hyperparams


%------------- END OF CODE --------------