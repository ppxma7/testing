% randomiser for pokemon
function[]=randomon(myseed)
% reuse same seed to keep list same

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

%rng(42)

% 18 types
types = {'Normal','Fighting','Flying','Poison',...
    'Ground','Rock','Bug','Ghost', 'Steel','Fire',...
    'Water','Grass','Electric','Psychic','Ice',...
    'Dragon','Dark','Fairy'};

msize = numel(types);
Jim = types(randperm(msize)); % this creates the permutation
Michael = types(randperm(msize));

% this implies there are no replacemtns e.g. no repeats of using hte same
% team again

% table
varTypes = {'cell','cell'};
varNames = {'Jim','Michael'};
T = table('Size',[18 2],'VariableTypes',varTypes,'VariableNames',varNames); %preallocate
% now fill!
T.Jim = Jim(:);
T.Michael = Michael(:);

%writetable(T,'/Users/ppzma/The University of Nottingham/Michael_Sue - Touchmap - Touchmap/behavioural/cv_table.csv')

%table(Jim,Michael)
T


