% list of video game purchases in 2019
% 
% [ma] Feb 2019
%clear variables
myGames = {'Tetris Effect', 'Far Cry New Dawn', 'Night in the Woods', ...
    'Shadow of the TR', 'ACO:Helix credits', 'RDR2',...
    'Absolute Drift', 'Mutant Year Zero', 'Surviving Mars','DragonBall FighterZ',...
    'Superhot VR', 'Killzone SF', 'Days Gone', 'Blood and Truth VR',...
    'CTR', 'Control','Ni No Kuni 2','EA Access','The Order 1886','Man of Medan',...
    'Medievil','SWJFO', 'Erica', 'Metro Exodus','Rage2', 'Concrete Genie', ...
    'Goose', 'PS NOW'}';
    
   

whichMonth = {'January', 'February', 'February',...
    'February', 'March','March',...
    'May', 'May', 'May', 'May',...
    'May', 'June', 'June', 'June',...
    'July', 'August','September','September','October','October', ...
    'October','November', 'November', 'December', 'December', 'December',...
    'December', 'December'}';

digorphys = {'Digital','Physical','Digital',...
    'Digital','Digital','Digital',...
    'Digital','Digital','Digital','Digital',...
    'Digital','Digital','Digital','Physical',...
    'Digital','Physical','Digital','Digital','Digital','Digital',...
    'Digital','Digital','Digital','Digital','Digital','Digital',...
    'Digital','Digital',}';

%check month
thismonth = str2double(datestr(now,5));
    
myCost = [34.99 31.99 11.99 34.99 15.99 39.99 3.99 18.99 19.99 24.99 11.99 11.99 46 29.99, ...
    34.99 44.99 12.99 19.99 8.99 12.99 24.99 53.99 8.99 12.99 12.99 15.99 11.99 49.99]';

figure('Position', [100 100 800 400])
myfontsize = 16;
g = gramm('x', whichMonth, 'y', myCost, 'color', myGames);
g.geom_point('alpha', 0.8);
g.set_text_options('font', 'Menlo', 'base_size', myfontsize)
g.set_names('x',[], 'y', 'Cost (£)','color', 'Month')
%g.axe_property('YLim', [0 140])
%g.geom_jitter('alpha', 0.8)
g.set_point_options('markers', {'o'} ,'base_size',15)
%g.no_legend()
g.set_order_options('x', 0,'color',0)
g.draw()

fprintf('\nTotal spent this year: £%.2f\n',sum(myCost));
fprintf('\nMean monthly spend so far: £%.2f\n',sum(myCost)./12);



    

A = cellfun(@(x) x(1:3),digorphys,'UniformOutput',false);

% lengths
D = length(cell2mat(strfind(A,'Dig')));
P = length(cell2mat(strfind(A,'Phy')));
%H = length(cell2mat(strfind(A,'Har')));
X = [D;P;length(A)-D-P];

% indexing for costings
digIdx = contains(A,'Dig');
phyIdx = contains(A,'Phy');
%harIdx = contains(A,'Har');

% make a cost string
digCost = [' £' num2str(sum(myCost(digIdx)))];
phyCost = [' £' num2str(sum(myCost(phyIdx)))];
%harCost = [' £' num2str(sum(myCost(harIdx)))];

separateCost = [digCost; phyCost];

% now load up the pie
figure
mypie = pie(X);
pText = findobj(mypie,'Type','text');
percentValues = get(pText,'String'); 
txt = {'Digital sales: ','Physical sales: '};
combinedtxt = strcat(txt(:),percentValues(1:2), separateCost); % hack to ignore hardware here
pText(1).String = combinedtxt(1);
pText(2).String = combinedtxt(2);
%pText(3).String = combinedtxt(3);

% custom coloarmap
mycmap = [102,194,165;252,141,98;141,160,203];
mycmap = mycmap./256;
colormap(mycmap)

firstguy = ['Annual cost: £' num2str(round(sum(myCost))) ];
secguy = ['Monthly cost: £' num2str(round(sum(myCost)./thismonth)) ];

text(0.5,-1,  firstguy);
text(0.5,-1.2,   secguy);


%% games2020

clear variables
myGames = {'Nintendo Switch', 'Switch accessories','Pokemon Shield', 'Luigis Mansion 3',...
    'Astral Chain', 'Gris','Celeste', ...
    'Black Future 88', 'Super Crush KO', 'VA-11-HALL-A','Katana Zero', 'Journey TTSP', ...
    'Thronebreaker',...
    'The Division 2','Gamepass','Transistor','NiNoKuni','Nintendo other','Gamepass','Forza Lego','Cyberpunk controller',...
    'AC Odyssey','AC Odyssey Helix','Maneater',...
    'TLOU2','Ghost of Tsushima','Hotline Miami','Gamepass','Snakeybus','Control dlc','Red Strings Club','Vanquish/Bayo',...
    'Pokemon dlc','PSplus','Nintendo topup','Below','Manifold Garden','Resident Evil 2','PSPlus','THPS',...
    'Spiritfarer','Obra Dinn','Void Bastards','FFVII Remake','FFVII','FFVIII','FFIX','FFX11','Switcher','Division WONY',...
    'Little Hope','PS5','Miles Morales','AC Valhalla','Astro Playroom'};

gamesCompleted = {'Pokemon Shield','Luigis Mansion 3','Astral Chain','Gris',...
    'VA-11-HALL-A','Journey TTSP','The Division 2','Transistor','Quantum Break','Celeste','Hotline Miami',...
    'Gears4','Gears5','Red Strings Club','TLOU2','Control dlc','Pokemon dlc','Ghost of Tsushima','Snakeybus','Resident Evil 2',...
    'Divison WONY','Little Hope','Astro Playroom','Switcher'};
    

console = {'Nintendo','Nintendo','Nintendo','Nintendo',...
    'Nintendo','Nintendo',...
    'Nintendo','Nintendo','Nintendo','Nintendo','PS4',...
    'Nintendo',...
    'PS4','Xbox','Nintendo','Nintendo','Xbox','Xbox','Xbox',...
    'Xbox','Xbox','Xbox',...
    'PS4','PS4','Nintendo','Nintendo','Nintendo','Xbox','Nintendo','PS4','Nintendo','PS4',...
    'Nintendo','PS4','Nintendo','PS4','PS4','PS4','PS4','PS4',...
    'Nintendo','PS4','Nintendo','Nintendo','Nintendo','Nintendo','Nintendo','Nintendo','Nintendo',...
    'PS4','PS4','PS5','PS5','PS5','PS5'}';
    
   

whichMonth = {'January', 'January', 'January',...
    'January', 'January','January','January', 'January', 'January','January', 'January', 'January','January',...
    'February','February','March','April','April','April','April','April',...
    'May','May','May',...
    'June','June', 'June','June','July','July','July','July','July','July','August','August','August','August', 'August',...
    'September','September','September','October','October','October','October','October','October','October',...
    'October','October','November','November','November','November'}';

digorphys = {'Hardware','Hardware','Physical','Physical',...
    'Physical','Digital',...
    'Digital','Digital','Digital','Digital','Digital','Digital',...
    'Digital',...
    'Digital','Digital','Digital','Digital','Digital','Digital','Digital','Digital','Digital','Digital','Hardware',...
    'Digital','Digital','Digital',...
    'Digital','Digital','Digital','Digital','Digital','Digital','Digital',...
    'Digital','Digital','Digital','Digital','Digital','Digital','Digital','Digital',...
    'Digital','Physical','Digital','Digital','Digital','Digital','Digital',...
    'Digital','Digital','Hardware','Physical','Physical','Digital'}';
    
    
    

%check month
thismonth = str2double(datestr(now,5));
    
myCost = [199.99 76 44.99 44.99 19.99 7.99 17.99 10.34 12.99,...
    14.99 12.99 25 16.99 7.99 7.99 15.49 33.49 23 7.99 14.39 59.99,...
    38.99 7.99 28 54.99 0 14 10.99 26.67 16 16.65 19.99 16.15 6.99,...
    50 29.48 13.49 22.49 37.49 36.99 21 17.99 24.99 32.99 7 7 7 20 35 7.99,...
    12.50 449.99 49.99 48 0]';

mycmap = [228,26,28;55,126,184;77,175,74];
mycmap = mycmap./256;

figure('Position', [100 100 800 400])
myfontsize = 16;
g = gramm('x', whichMonth, 'y', myCost, 'color', myGames);
g.geom_jitter('alpha', 0.8,'dodge',0.5);
g.set_text_options('font', 'Menlo', 'base_size', myfontsize)
g.set_names('x',[], 'y', 'Cost (£)','color', 'Month')
%g.axe_property('YLim', [0 140])
%g.geom_jitter('alpha', 0.8)
g.set_point_options('markers', {'o'} ,'base_size',15)
%g.no_legend()
g.set_order_options('x', 0)
%g.set_color_options('map',mycmap);
g.draw()

fprintf('\nTotal spent this year: £%.2f\n',sum(myCost));
fprintf('\nMean monthly spend so far: £%.2f\n',sum(myCost)./thismonth);


%% digital versus physical
% shorten 
A = cellfun(@(x) x(1:3),digorphys,'UniformOutput',false);

% lengths
D = length(cell2mat(strfind(A,'Dig')));
P = length(cell2mat(strfind(A,'Phy')));
H = length(cell2mat(strfind(A,'Har')));
X = [D;P;length(A)-D-P];

% indexing for costings
digIdx = contains(A,'Dig');
phyIdx = contains(A,'Phy');
harIdx = contains(A,'Har');

% make a cost string
digCost = [' £' num2str(sum(myCost(digIdx)))];
phyCost = [' £' num2str(sum(myCost(phyIdx)))];
harCost = [' £' num2str(sum(myCost(harIdx)))];

separateCost = [digCost; phyCost; harCost];

% now load up the pie
mypie = pie(X);
pText = findobj(mypie,'Type','text');
percentValues = get(pText,'String'); 
txt = {'Digital sales: ','Physical sales: ','Hardware sales: '};
combinedtxt = strcat(txt(:),percentValues(:), separateCost); 
pText(1).String = combinedtxt(1);
pText(2).String = combinedtxt(2);
pText(3).String = combinedtxt(3);

% custom coloarmap
mycmap = [102,194,165;252,141,98;141,160,203];
mycmap = mycmap./256;
colormap(mycmap)

firstguy = ['Annual cost: £' num2str(round(sum(myCost))) ];
secguy = ['Monthly cost: £' num2str(round(sum(myCost)./thismonth)) ];

text(0.5,-1,  firstguy);
text(0.5,-1.2,   secguy);

%% completionist

% myphys = digorphys;
% mydig = digorphys;
% ampDex = strcmpi(mydig,'Digital');
% mydig(~ampDex)={''}; % logical indexing of a cell array
% mydig = mydig(~cellfun('isempty',mydig));





