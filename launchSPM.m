% add SPM path correctly
pathCell = regexp(path, pathsep, 'split');
onPath = any(strcmp('/Users/ppzma/Documents/spm12', pathCell));
if onPath == 1
    spm_rmpath
end
addpath /Users/ppzma/Documents/spm12
disp('adding spm12 path')
%marsbar
%addpath(genpath('/Users/ppzma/Documents/spm12/toolbox/marsbar-0.44'));
%addpath(genpath('/Users/ppzma/Documents/spm12/toolbox/marsbar-aal-0.2'));
addpath(genpath('/Users/ppzma/Documents/spm12/toolbox/ArtRepair'));
addpath(genpath('/Users/ppzma/Documents/spm12/toolbox/jubrain-anatomy-toolbox'));
spm
