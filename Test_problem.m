%%% INSTRUCTIONS
% Load Initialize_for_testing.
% Do not load any data.
% Load background and SLS backreflection.
% Set model parameters in the graphical user interface
% Set other parameters in the Inputs section. They all have to be cell arrays
% with the same number of elements.
%%%%


sm = m.s_models{1};
fq = @(a,wl,n) 4.*pi.*n./wl .* sind(a./2);

%%%  Inputs -----------------------------

angles = (15:155)';

amplitudes = {0.3;...
              0.1};

wl = {404;...
      642};
  
wl_e = {0;...
        0};

ri = {1.342;...
      1.332};
  
ri_e = {0.00;...
        0.00};

bg = {3e-6;...
      1e-6};
  
bg_e = {0;...
        0};
  
% Scaling for the Poisson noise  
nl = {1e8;...
      1e8};     

%%% --------------------------------------

q_nominal = cellfun(fq,repmat({angles},numel(wl),1),wl,ri,'UniformOutput',0);

wl = cellfun(@plus,wl,wl_e,'UniformOutput',0);
ri = cellfun(@plus,ri,ri_e,'UniformOutput',0);
bg_actual = cellfun(@plus,bg,bg_e,'UniformOutput',0);

q = cellfun(fq,repmat({angles},numel(wl),1),wl,ri,'UniformOutput',0);

for i = 1:numel(q)
   
    m.sls_br.set_param('wl_val',wl{i});
    m.sls_br.set_param('ri_val',ri{i});
    m.bg.set_param_vector(bg_actual{i});
    
    ih = 1:numel(m.handles);
    
    intst = zeros(numel(angles),10);
    bg_intst = zeros(numel(angles),10);
    
    if isempty(m.sls_br)
        
        ps = 1 + numel(m.bg.enabled);
        
    else
        
        ps = 1 + numel(find(m.bg.enabled)) + numel(find([m.sls_br.enabled]));
            
    end
    
    p = m.get_total_parameter_vector;
    p(ps) = amplitudes{i};
    
    m.set_total_parameter_vector(p);
    
    intst_j = m.total_scattered_intensity(150,ih,q{i});
    bg_j = repmat(bg{i},numel(angles),1);
    
    for j = 1 :100
            
        % Add artificially scaled Poisson noise to the intensity
        intst_je = intst_j.*nl{i};
        e = poissrnd(intst_je);
        intst_je = (intst_je + e)./nl{i};

        intst(:,j) = intst_je;
        
        % Add artificially scaled Poisson noise to the background
        bg_je = bg_j.*nl{i};
        e = poissrnd(bg_je);
        bg_je = (bg_je + e)./nl{i};
        
        bg_intst(:,j) = bg_je;
        
    end
    
    std_intst = std(intst,0,2);
    std_bg = std(bg_intst,0,2);
    
    c = cov(bsxfun(@minus,intst,m.total_scattered_intensity(150,ih,q{i})));
    intst_m = mean(intst,2);
    bg_intst_m = mean(bg_intst,2);
    
    intst_m = intst_m - bg_intst_m;
    std_total = sqrt(std_intst.^2 + std_bg.^2);
    
    % Scale to the amplitudes
    
    r = [q_nominal{i} intst_m std_total];    
    
    save(['q_' num2str(wl{i}-wl_e{i}) ' nl_' num2str(nl{i}) '.txt'],'r','-ascii');
    
end