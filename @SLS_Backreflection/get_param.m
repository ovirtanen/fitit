function p = get_param(obj,tag)
%GET_PARAM Get parameter according to the GUI tag

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

% remove id number

tag(regexp(tag,'\d')) = [];

% find value

if strcmp(tag,'wl_val')
    
    p = obj.w_length;
    
elseif strcmp(tag,'ri_val')
    
    p = obj.refr_index;
    
elseif strcmp(tag,'eta_min')
    
    p = obj.eta{1};
    
elseif strcmp(tag,'eta_val')
    
    p = obj.eta{2};
    
elseif strcmp(tag,'eta_max')
    
    p = obj.eta{3};
    
elseif strcmp(tag,'eta_chck')
    
    p = obj.eta{4};
    
else
    
    error('Edit box type not recognized.');
    
end


end

