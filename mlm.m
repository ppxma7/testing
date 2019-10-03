% save current mrLoadRet view
%
% [ma] march 2019
clc
curfolder = cd;
% need to give absolute path, otherwise MATLAB will search entire path
fileExisting = exist(fullfile(curfolder,'mrLastView.mat'),'file') == 2;

if fileExisting == 1 %logical
    
    % check if mrLoadRet window is open
    v = viewGet([],'view',1);
    if ~isempty(v)
        mrSaveView(v);
    else
        error('Dude, open up mrLoadRet')
    end
else
    % check we are in the correct folder
    error('I can''t see mrLastView, check your folder')
end

clear fileExisting v