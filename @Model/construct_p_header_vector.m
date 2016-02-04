function phv = construct_p_header_vector(obj,b_std)
%CONSTRUCT_P_HEADER_VECTOR Constructs cell string vector of parameter headers
%   
%   phv = construct_p_header_vector(obj)
%
% Parameters
% b_std         true or false depending if standard deviation fields should
%               be included after each parameter header
%
% Returns
% phv           Cell string vector holding the p_name_strings for all the
%               parameters loaded to Model

% Copyright (c) 2015,2016, Otto Virtanen
% All rights reserved.

%% Backgrounds

h_bg = obj.bg.p_name_strings;
h_bg = h_bg(logical(obj.bg.enabled));

%% Backreflections

if isempty(obj.sls_br)
    
    h_br = {};
    
else
    
    h_br = {'BR fraction'};
    h_br = repmat(h_br,1,numel(obj.sls_br));
    h_br = h_br(logical([obj.sls_br.enabled]));
    
end


%% Scattering model & distribution

% works also if there are multiple s_models
h = cellfun(@(x) [x.p_name_strings(:); x.dist.p_name_strings(:)], obj.s_models,'UniformOutput',false);
h = cat(1,h{:});

phv = cat(1,h_bg,h_br,h);

if b_std
   
    s = repmat({'Std'},1,numel(phv));
    phv = [phv(:)';s(:)'];
    phv = phv(:);
    
end

phv = cellfun(@(x) ['"' x '"'],phv,'UniformOutput',false);

end

