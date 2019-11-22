function rmCaseFolders(d)
for iCase = 1:d.nCases
    openFoamFolder = [d.openFoamFolder 'case' int2str(iCase+d.caseStart-1) '/'];
    system(['rm -rf ' openFoamFolder])
end
end