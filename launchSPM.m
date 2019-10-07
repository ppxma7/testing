% add SPM path correctly
pathCell = regexp(path, pathsep, 'split');
onPath = any(strcmp('/Users/ppzma/Documents/spm12', pathCell));
if onPath == 1
    spm_rmpath
end
addpath /Users/ppzma/Documents/spm12
disp('adding spm12 path')
spm
