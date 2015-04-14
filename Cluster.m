% FitIt cluster script for fitting computationally intensive scattering
% models on data
%


% Initialize --------------------------------------------------------------

% Distribution
dist = DST_Gaussian();

% Scattering model
sm = SM_Core_shell(dist);

m = Model(sm);

c = Controller(m,'cluster');

% Parallel options --------------------------------------------------------

if isa(sm,'Parallel_capable')
    
    % GPU capability
    % sm.enable_gpu();
    
    % Multiple worker capability
    % parpool(4);
    % sm.enable_par();
    
end

% Load and save paths -----------------------------------------------------

data_paths = {'Example data sets/HAM-0,0-60C-2m-const-KPS-0,3143 cleaned.txt';...
              'Example data sets/HAM-0,0-60C-2m-const-KPS-0,3143 cleaned.txt'};
          
save_paths = {'Testit/test1.txt';...
              'Testit/test2.txt'};

% Set initial guesses -----------------------------------------------------

p = {[0.079494 60.8574 0.81046 1 402.1756 9.4612];...
     [0.079494 60.8574 0.81046 1 402.1756 9.4612]};
 
 % Set fixed parameters
 
pf = {[0 0 0 1 0 0];...
      [0 0 0 1 0 0]};
          
% Check inputs ------------------------------------------------------------
          
if numel(data_paths) ~= numel(save_paths)
    
    error('Unequal number of load and save paths.');
    
elseif numel(unique(save_paths)) ~= numel(save_paths)
    
    error('Some results will be overwritten');
    
elseif numel(p) ~= numel(data_paths)
    
    error('Wrong number of initial guesses.');
    
elseif numel(pf) ~= numel(data_paths)
    
    error('Wrong number of fixed states.');
    
end

f = @(x) numel(x);
b = cellfun(f,p);

if not(all(b == (numel(sm.p_name_strings) + numel(dist.p_name_strings))))
   
    error('Parameter vectors have wrong number of paramters.')
    
end

b = cellfun(f,pf);

if not(all(b == (numel(sm.p_name_strings) + numel(dist.p_name_strings))))
   
    error('Fixed values vectors have wrong number of paramters.')
    
end

f = @(x) exist(x);
b = cellfun(f,data_paths);

if not(all(b == 2))

    error('All load paths are not valid.');
    
end

b = cellfun(f,save_paths);

if not(all(b == 0))

    error('Saved data will be overwritten!');
    
end

% Creates empty files to the save location.
f = @(x) fopen(x,'w');
fids = cellfun(f,save_paths);

if any(fids == -1)
   
    inds = find(fids == -1);
    error(['Save path(s) ' num2str(inds) ' are invalid.']);
    
end

f = @(x) fclose(x);
cellfun(f,num2cell(fids));

% Do the actual calculation -----------------------------------------------

for i = 1:numel(data_paths)
    
    % load dataset
    rd = c.fr.read_files(data_paths(i));
    d = c.raw_data_to_array(rd);
    m.remove_experimental_data();
    c.add_data_set_to_model(d{1});
    
    % set initial guess
    sm.set_param_vector(p{i});
    
    % set fixed values
    sm.set_fixed_vector(pf{i});
    
    % do the fit
    p_fit = m.lsq_fit();
    m.set_total_parameter_vector(p_fit);
    
    % save results
    c.save_data(save_paths{i});
    
end
