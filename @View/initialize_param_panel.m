function p = initialize_param_panel(obj,prnt,source,tag)
%INITIALIZE_P_PANEL Initializes parameter panel for the GUI
%
%   p = initialize_param_panel(p,source,tag), creates and aligns uicontrols
%   and fetches the values for the uicontrols from the Model
%
%   Parameters
%   prnt            Parent Figure
%   source          Scattering_model or Distribution instance used for
%                   initialization
%   tag             UI tag for the panel
%
%   Returns
%   p               Panel with elements specified by source
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

if not(any([isa(source,'Scattering_model') isa(source,'Distribution')]))
   
    error('Source object has to be either a Scattering_model or Distribution instance.');
    
end

parent = prnt;

name = source.name;
pdescriptions = source.p_name_strings;
tags = Scattering_model.param_ids_to_tags(source.p_ids,'gui');


[nrows,ncols] = size(pdescriptions);
[srows,scols] = size(tags);

if not(all([ncols == 1 nrows == srows scols == 5]))
   
    error('Inputs have wrong dimensions.');
    
end

%%% Panel size and properties

% Horizontal spacers
p_text_width = 120;                                 %px
h_spacer = obj.spacers.p_h_spacer;                  %px
slider_width = obj.spacers.p_slider_width;          %px
box_width = obj.spacers.p_box_width;                %px

% Vertical spacers
v_spacer = obj.spacers.p_v_spacer;                  %px
element_height = obj.spacers.p_element_height;      %px
p_title_spacer = obj.spacers.p_title_spacer;        %px

p_width = 10 * h_spacer + p_text_width + slider_width + 4 * box_width;
p_height = p_title_spacer + (numel(pdescriptions) + 1) * element_height + (numel(pdescriptions) + 2) * v_spacer;

p = uipanel('Parent',parent,...
            'Units','pixels',...
            'Position',[0 0 p_width p_height]);
        
p.Tag = tag;
p.Title = [name ' Parameters'];
p.Visible = 'off';

% Initialize children

vpos = p_height - (p_title_spacer + v_spacer + element_height);
lpos = 5 .* h_spacer + p_text_width + slider_width;
uicontrol('Parent',p,'Position',[lpos vpos box_width element_height],'Tag','min_txt','Style','text','String','Min');

lpos = lpos + h_spacer + box_width;
uicontrol('Parent',p,'Position',[lpos vpos box_width element_height],'Tag','val_txt','Style','text','String','Val');

lpos = lpos + h_spacer + box_width;
uicontrol('Parent',p,'Position',[lpos vpos box_width element_height],'Tag','max_txt','Style','text','String','Max');

for i = 1:nrows
    % h_spacers in this section affect the panel width
    %
    % Callbacks have to be implemented as anonymous functions, otherwise
    % the self-reference obj will interfere with the callback syntax that
    % expects only two arguments, hObject and callbackdata
    
    pdesc = pdescriptions{i};
    trow = tags(i,:);
    vpos = p_height - (i+1) .* (v_spacer + element_height) - p_title_spacer;
    
    lpos = h_spacer;
    uicontrol('Parent',p,'Position',[lpos vpos p_text_width element_height],'Tag',[pdesc '_txt'],'Style','text','String',pdesc);
    
    lpos = lpos + h_spacer + p_text_width;
    sldr = uicontrol('Parent',p,'Position',[lpos vpos-2 p_text_width element_height],'Tag',trow{1},'Style','slider');
    sldr.Callback = @(hObject,callbackdata) obj.controller.slider_callback(hObject,callbackdata);
    
    lpos = lpos + 3.* h_spacer + slider_width;
    eb_min = uicontrol('Parent',p,'Position',[lpos vpos box_width element_height],'Tag',trow{2},'Style','edit');
    eb_min.Callback = @(hObject,callbackdata) obj.controller.edit_box_callback(hObject,callbackdata);
    v = source.get_param(eb_min.Tag);
    eb_min.String = num2str(v);
    sldr.Min = v;
    
    
    lpos = lpos + h_spacer + box_width;
    eb_val = uicontrol('Parent',p,'Position',[lpos vpos box_width element_height],'Tag',trow{3},'Style','edit');
    eb_val.Callback = @(hObject,callbackdata) obj.controller.edit_box_callback(hObject,callbackdata);
    v = source.get_param(eb_val.Tag);
    eb_val.String = num2str(v);
    sldr.Value = v;
    
    
    lpos = lpos + h_spacer + box_width;
    eb_max = uicontrol('Parent',p,'Position',[lpos vpos box_width element_height],'Tag',trow{4},'Style','edit');
    eb_max.Callback = @(hObject,callbackdata) obj.controller.edit_box_callback(hObject,callbackdata);
    v = source.get_param(eb_max.Tag);
    eb_max.String = num2str(v);
    sldr.Max = v;
    
    
    lpos = lpos + 2 .* h_spacer + box_width;
    chck = uicontrol('Parent',p,'Position',[lpos vpos box_width element_height],'Tag',trow{5},'Style','checkbox','String','fixed');
    chck.Callback = @(hObject,callbackdata) obj.controller.check_box_callback(hObject,callbackdata);
    v = source.get_param(chck.Tag);
    chck.Value = v;

end % for

end

