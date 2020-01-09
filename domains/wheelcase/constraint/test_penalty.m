function test_penalty()

if batchStartupOptionUsed
    parpool;
end


%% Add all files to path
addpath(genpath('~/Code/sail/'));
addpath(genpath('~/Code/matlabExtensions/'));
cd ~/Code/sail


nSamples = 1024;
%samples = zeros(1,nSamples);
d = wheelcase_Domain();
[stl.vertices,stl.faces] = readSTL('domains/wheelcase/ffd/wheelcase_right_remesh.stl','JoinCorners',true);


for i = 1:nSamples
    samples(i) = stl;
end

tic;
penalties = penalty(samples,d);
time = toc;

p = gcp('nocreate'); % If no pool, do not create new one.
if isempty(p)
    poolsize = 1;
else
    poolsize = p.NumWorkers;
end
disp(['Evaluating ' num2str(nSamples) ' Samples with ' num2str(poolsize) ' Threads took ' num2str(time) ' seconds'])

save('test_penalty.mat','d','stl','penalties');
end