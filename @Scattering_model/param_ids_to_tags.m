function tags = param_ids_to_tags(param_names,mode)
%PARAM_IDS_TO_TAGS Transforms user specified parameter names gui tags
%   
% tags = param_ids_to_tags(param_names)
%
% Parameters
% param_names       cellstr containing the model parameter identifiers
% mode              'gui' or 'params' whether tags are needed for gui
%                   initialization or parameter initialization in Model 
%                   classes
% 
% Returns
% tags              tags for the corresponding gui elements with additional
%                   tags for background bg, which is always included
%
% Example:
% tags = param_ids_to_tags({'p1' 'p2' 'p3'},'gui') returns
% 
% tags =
%
%    'p1_sldr'    'p1_min'    'p1_val'    'p1_max'    'p1_chck'
%    'p2_sldr'    'p2_min'    'p2_val'    'p2_max'    'p2_chck'
%    'p3_sldr'    'p3_min'    'p3_val'    'p3_max'    'p3_chck'
%
% tags = param_ids_to_tags({'p1' 'p2' 'p3'},'params') returns
% 
% tags = 
%
%    'p1_min'    'p1_val'    'p1_max'    'p1_chck'
%    'p2_min'    'p2_val'    'p2_max'    'p2_chck'
%    'p3_min'    'p3_val'    'p3_max'    'p3_chck'
%

if not(iscellstr(param_names))
   
    error('Input has to be cellstring.');
    
end

p = param_names(:);

tags = cell(numel(p),5);

for i = 1:numel(p)

    tags(i,:) = expand_param_name(p{i});

end

switch mode
    
    case 'gui'
        
        return;
        
    case 'params'
        
        tags = tags(:,2:end);
    
end

end

function row = expand_param_name(name)
% expands one parameter name to 
% {'name_sldr' 'name_min' 'name_val' 'name_max' 'name_chck'}
%

row = {[name '_sldr'] [name '_min'] [name '_val'] [name '_max'] [name '_chck']};

end
