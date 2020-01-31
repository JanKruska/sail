function test_penalty()

if batchStartupOptionUsed
    parpool;
end

p = gcp('nocreate'); % If no pool, do not create new one.
if isempty(p)
    poolsize = 1;
else
    poolsize = p.NumWorkers;
end

%% Add all files to path
addpath(genpath('~/Code/sail/'));
addpath(genpath('~/Code/matlabExtensions/'));
cd ~/Code/sail

d = wheelcase_Domain('config','2pt4x2x3hor');


nSamples = 2^14;
%samples = zeros(1,nSamples);
%[stl.vertices,stl.faces] = readSTL('domains/wheelcase/ffd/wheelcase_right_remesh.stl','JoinCorners',true);
rng(17011998);
deformVals = rand(nSamples,d.dof);

% for i = 1:nSamples
%     samples(i) = stl;
% end
tic;
samples = d.expressRight(deformVals);
time = toc;

disp(['FFD on ' num2str(nSamples) ' Samples with ' num2str(poolsize) ' Threads took ' num2str(time) ' seconds'])


tic;
penalties = penalty(samples,d);
time = toc;

disp(['Evaluating ' num2str(nSamples) ' Samples with ' num2str(poolsize) ' Threads took ' num2str(time) ' seconds'])

save('test_penalty.mat','d','samples','penalties');
end