% list of video game purchases in 2019
% 
% [ma] Feb 2019
clear variables
myGames = {'Tetris Effect', 'Far Cry New Dawn', 'Night in the Woods', ...
    'Shadow of the TR', 'ACO:Helix credits', 'RDR2',...
    'Absolute Drift', 'Mutant Year Zero', 'Surviving Mars','DragonBall FighterZ',...
    'Superhot VR', 'Killzone SF', 'Days Gone', 'Blood and Truth VR',...
    'CTR', 'Control','Ni No Kuni 2','EA Access','The Order 1886','Man of Medan'}';

whichMonth = {'January', 'February', 'February',...
    'February', 'March','March',...
    'May', 'May', 'May', 'May',...
    'May', 'June', 'June', 'June',...
    'July', 'August','September','September','October','October'}';

%check month
thismonth = str2double(datestr(now,5));

myCost = [34.99 31.99 11.99 34.99 15.99 39.99 3.99 18.99 19.99 24.99 11.99 11.99 46 29.99, ...
    34.99 44.99 12.99 19.99 8.99 12.99]';

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
fprintf('\nMean monthly spend so far: £%.2f\n',sum(myCost)./thismonth);