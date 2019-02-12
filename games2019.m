% list of video game purchases in 2019
% 
% [ma] Feb 2019
clear variables
myGames = {'Tetris Effect', 'Far Cry New Dawn', 'Night in the Woods'}';
whichMonth = {'January', 'February', 'February'}';
myCost = [34.99 31.99 11.99]';

figure('Position', [100 100 800 400])
myfontsize = 16;
g = gramm('x', myGames, 'y', myCost, 'color', whichMonth);
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
fprintf('\nMean spend this year: £%.2f\n',mean(myCost));