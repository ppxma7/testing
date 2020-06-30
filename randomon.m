% randomiser for pokemon
function[]=randomon(myseed)
% reuse same seed to keep list same
%
% ma june 2020

close all
clc

if nargin<1
    myseed = randi(1000000,1,1);
    disp(myseed)
    rng(myseed)
else
    disp(myseed)
    rng(myseed)
end


% 18 types
types = {'Normal','Fighting','Flying','Poison',...
    'Ground','Rock','Bug','Ghost', 'Steel','Fire',...
    'Water','Grass','Electric','Psychic','Ice',...
    'Dragon','Dark','Fairy'};

msize = numel(types);
Jim = types(randperm(msize)); % this creates the permutation
Michael = types(randperm(msize));

% this implies there are no replacements e.g. no repeats of using the same
% team again

% table
varTypes = {'cell','cell'};
varNames = {'Jim','Michael'};
T = table('Size',[18 2],'VariableTypes',varTypes,'VariableNames',varNames); %preallocate
% now fill!
T.Jim = Jim(:);
T.Michael = Michael(:);

writecell(T.Jim,'/Users/ppzma/Google Drive/randOM/poketable_jim.txt')
writecell(T.Michael,'/Users/ppzma/Google Drive/randOM/poketable_michael.txt')





