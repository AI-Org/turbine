function [sigList nameList unitList] = loadcartsignalsU(fileListIn,signalListIn)
%This function grabs a set of signals from a set of data files

sigList = [];
nameList = [];
unitList = [];
disp('CART universal signal loader')

%Start by making sure both inputs are lists
if ~iscell(fileListIn)
    fileList = {fileListIn};
else
    fileList = fileListIn;
end

if ~iscell(signalListIn)
    signalList = {signalListIn};
else
    signalList = signalListIn;
end



for f = 1:length(fileList)
    disp(['Loading file ' num2str(f) '........'])
    dat = loadcartU(fileList{f});
    hdr = loadcarthdrU(fileList{f});
    sigListInner = [];
    nameListInner = {};
    unitListInner = {};
    for s = 1:length(signalList)
        for ss = 1:size(hdr,1)
            if(strcmp(hdr{ss,1},signalList{s}))
                sigListInner = [sigListInner;dat(:,ss)'];
                nameListInner = [nameListInner;hdr{ss,1}];
                unitListInner = [unitListInner,hdr{ss,2}];
            end
        end
    end
    sigList = [sigList sigListInner];
    nameList = nameListInner;
    unitList = unitListInner;
end