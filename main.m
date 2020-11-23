
% add full directory to path
addpath(genpath(pwd));

% read parameters from config file
config = loadjson('config.json.multi');

% define variables
time = config.number_time_points;
ts = h5read(config.ts,'/timeseries');

[x,y] = size(ts);               % number samples/nodes


if x == time 
    n = y
    
else 
    n = x
    
    ts = ts';
end

z = zscore(ts);                 % z-score

[u,v] = find(triu(ones(n),1));  % get edges
a = z(:,u).*z(:,v);             % edge ts products

% write output as csv files
dlmwrite(config.outets,'edgetimeseries');