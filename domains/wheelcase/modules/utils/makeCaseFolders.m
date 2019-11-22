function makeCaseFolders(d)
for iCase = 1:d.nCases
    openFoamFolder = [d.openFoamFolder 'case' int2str(iCase+d.caseStart-1) '/'];
    system(['mkdir -p ' openFoamFolder]);
    system(['cp -af ' d.baseFolder '. ' openFoamFolder]);
end
end