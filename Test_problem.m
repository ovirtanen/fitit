function Test_problem(m,param,varargin)
%Test_problem Create SLS test problem for the inversion routine.
%
% Instructions: Use Load_to_workspace script to initialize object instances
% to the workspace. Choose your preferred model parameters in the GUI.
% Enable background and backreflection. Create a struct (see below) with
% the test problem parameters, and give the Model instance and the struct
% as input arguments for Test_problem.
%
% Save the exact solution and the struct for future reference.
%   
%   Test_problem(m,param)
%   Test_problem(m,param,options)
%
% Parameters
% m             Reference to a Model instance
% param         Parameter struct. Has to contain the following fields:
%
%               angles  Scattering angles. [j x 1] double
%               wl      Wavelengths in nm. More than one entry leads to
%                       creation of the same dataset with different 
%                       wavelengths (different q grid). [k x 1] double 
%               wl_e    Deviation from the nominal wl values. (Permutation)
%                       [k x 1] double
%               ri      Refractive indices of the dispersion at given 
%                       wavelengths. [k x 1] double
%               ri_e    Deviation from the nominal wl values. (Permutation)
%                       [k x 1] double
%               bg      Background scattering intensity (cm^-1). [k x 1] double
%               bg_e    Deviation from the nominal wl values. (Permutation)
%                       [k x 1] double
%               amp     Scattering amplitudes at lim q -> 0 (cm^-1).[k x 1] double
%               nl      Scalers for poisson noise. [k x 1] double
%               np      Number of datapoints measured at given angle.
%                       [1 x 1] double
%
%
% options       Additional options:
%
%               'autosave'  Save data automatically to the FitIt directory 
%                           without showing save dialog.
%
%
% Example struct:
%
%   s = 
%
%    angles: [141x1 double]
%        wl: [404 642]
%      wl_e: [-1 1]
%        ri: [1.3420 1.3320]
%      ri_e: [0.0200 0.0100]
%        bg: [3.0000e-06 1.0000e-06]
%      bg_e: [2.0000e-06 1.0000e-06]
%       amp: [0.5000 0.1000]
%        nl: [1000000 1000000]
%        np: 10
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

%% Check inputs

reqflds = {'angles';...
           'wl';...
           'wl_e';...
           'ri';...
           'ri_e';...
           'bg';...
           'bg_e';...
           'amp';...
           'nl';...
           'np'};

aoptions = {'autosave'};    % available options

if not(isa(m,'Model'))
   
    error('The first argument has to be a reference to a Model instance.');
    
elseif isa(m.data_sets,'Data_set')
    
    error('Re-initialize FitIt to workspace and do not load any data.');
    
elseif not(m.bg.enabled)
    
    error('Enable the background.');
    
elseif isa(m.sls_br,'SLS_Backreflection') && not(m.sls_br.enabled)
    
    error('Enable SLS backreflection.');
    
elseif not(isstruct(param) && numel(fields(param)) == numel(reqflds) && all(strcmp(fields(param),reqflds)))
    
    error('Invalid parameter struct.');
    
elseif not(numel(unique([numel(param.wl) numel(param.wl_e) numel(param.ri) numel(param.ri_e) numel(param.bg) numel(param.bg_e) numel(param.amp) numel(param.nl)])) == 1)
    
    error('Some struct fields have wrong number of elements.')
    
elseif not(all([param.wl >= 0 param.ri > 0 param.bg >= 0 param.amp > 0 param.nl > 0 param.np >= 1]))
    
    error('Certain struct fields have illegal values');
    
elseif numel(varargin) > 1
    
    error('Too many options.');
    
elseif not(all(strcmp(varargin,aoptions)))
    
    error('Unrecognized option(s).');
    
end


%% Collect inputs

fq = @(a,wl,n) 4.*pi.*n./wl .* sind(a./2);

%%%  Inputs -----------------------------

angles = param.angles(:);

amplitudes = num2cell(param.amp(:));

wl = num2cell(param.wl(:));

wl_e = num2cell(param.wl_e(:));

ri = num2cell(param.ri(:));

ri_e = num2cell(param.ri_e(:));

bg = num2cell(param.bg(:));

bg_e = num2cell(param.bg_e(:));

% Scaling for the Poisson noise  
nl = num2cell(param.nl(:)); 

np = param.np;

%%% --------------------------------------

q_nominal = cellfun(fq,repmat({angles},numel(wl),1),wl,ri,'UniformOutput',0);


% Add permutations

wl_actual = cellfun(@plus,wl,wl_e,'UniformOutput',0);
ri_actual = cellfun(@plus,ri,ri_e,'UniformOutput',0);
bg_actual = cellfun(@plus,bg,bg_e,'UniformOutput',0);

% Calculate the actual q

q = cellfun(fq,repmat({angles},numel(wl_actual),1),wl_actual,ri_actual,'UniformOutput',0);

% Cell arrays for data without noise
intst_j = cell(size(q));
bg_j = cell(size(q));


e = cell(size(q));      % Cell array for error vectors
rnl = cell(size(q));    % Cell array for relative noise level values

r = cell(size(q));      % Cell array for the created datasets

for i = 1:numel(q)

    m.sls_br.set_param('wl_val',wl_actual{i});
    m.sls_br.set_param('ri_val',ri_actual{i});
    m.bg.set_param_vector(bg_actual{i});

    ih = 1:numel(m.handles);

    intst = zeros(numel(angles),np);
    bg_intst = zeros(numel(angles),np);

    if isempty(m.sls_br)

        ps = 1 + numel(m.bg.enabled);

    else

        ps = 1 + numel(find(m.bg.enabled)) + numel(find([m.sls_br.enabled]));

    end

    p = m.get_total_parameter_vector;
    p(ps) = amplitudes{i};

    m.set_total_parameter_vector(p);

    intst_j{i} = m.total_scattered_intensity(150,ih,q{i});
    bg_j{i} = repmat(bg{i},numel(angles),1);

    for j = 1 : np

        % Add artificially scaled Poisson noise to the intensity
        intst_je = intst_j{i}.*nl{i};
        intst_je = poissrnd(intst_je);
        intst_je = intst_je/nl{i};

        intst(:,j) = intst_je;

        % Add artificially scaled Poisson noise to the background
        bg_je = bg_j{i}.*nl{i};
        bg_je = poissrnd(bg_je);
        bg_je = bg_je./nl{i};

        bg_intst(:,j) = bg_je;

    end

    std_intst = std(intst,0,2);
    std_bg = std(bg_intst,0,2);

    %c = cov(bsxfun(@minus,intst,m.total_scattered_intensity(150,ih,q{i})));
    intst_m = mean(intst,2);
    e{i} = intst_m - intst_j{i};
    rnl{i} = norm(e{i})./norm(intst_j{i});

    bg_intst_m = mean(bg_intst,2);

    intst_m = intst_m - bg_intst_m;
    std_total = sqrt(std_intst.^2 + std_bg.^2);

    r{i} = [q_nominal{i} intst_m std_total];    

end

if any(strcmp('autosave',varargin))
    
    path = '';
 
else
    
    path = uigetdir('','Choose directory for saving');
    
    if path == 0

        error('Aborted by the user.');

    end
    
    path = [path '/'];
    
end
         
for i = 1:numel(r)

    export = r{i};
    save([path 'q_' num2str(wl{i}) '_rnl_' num2str(rnl{i}) '.txt'],'export','-ascii');

end
        

end