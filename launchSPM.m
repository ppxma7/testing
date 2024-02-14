%% add SPM path correctly

% check which mac we are using to get the correct username
whichMac = char(java.lang.System.getProperty('user.name'));
if strcmpi(whichMac,'spmic')
    spmdir = '/Users/spmic/Documents/MATLAB/spm/';
elseif strcmpi(whichMac,'ppzma')
    spmdir = '/Users/ppzma/Documents/spm12/';
else
    error('this is setup for ppzma or spmic - check username in launchSPM.m')
end

fprintf('\nSPM12 dir is: %s\n',spmdir)

% check if spm path is already loaded, otherwise remove it and relaunch it
pathCell = regexp(path, pathsep, 'split');
onPath = any(contains(pathCell,spmdir));
if onPath == 1
    spm_rmpath
end

% addpaths
addpath(spmdir)
addpath(genpath([spmdir 'toolbox/ArtRepair']));
%addpath(genpath([spmdir 'toolbox/jubrain-anatomy-toolbox']));

disp('adding spm path')

% now launch it
spm
