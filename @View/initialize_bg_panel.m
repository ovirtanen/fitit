function p = initialize_bg_panel(obj,p)
%INITIALIZE_BG_PANEL Initializes the background parameter panel for GUI
%   

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

parent = p;
source = obj.model.bg;
pdescriptions = source.p_name_strings;
tags = Scattering_model.param_ids_to_tags(source.p_ids,'gui');

[nrows,ncols] = size(pdescriptions);
[srows,scols] = size(tags);

if not(all([ncols == 1 nrows == srows scols == 5]))
   
    error('Inputs have wrong dimensions.');
    
end

%%% Panel size and properties

% Horizontal spacers
h_spacer = obj.spacers.p_h_spacer;                  %px
onoff_box_width = obj.spacers.p_onoff_box_width;    %px
slider_width = obj.spacers.p_slider_width;          %px
box_width = obj.spacers.p_box_width;                   %px

% Vertical spacers
v_spacer = obj.spacers.p_v_spacer;                  %px
element_height = obj.spacers.p_element_height;      %px
p_title_spacer = obj.spacers.p_title_spacer;        %px

p_width = 10 * h_spacer + onoff_box_width + slider_width + 4 * box_width;
%p_height = p_title_spacer + 2.*element_height + 4 * v_spacer;
p_height = p_title_spacer + (numel(pdescriptions) + 1) * element_height + (numel(pdescriptions) + 2) * v_spacer;

p = uipanel('Parent',parent,...
            'Units','pixels',...
            'Position',[0 0 p_width p_height]);       
       
p.Tag = 'bg_panel';
p.Title = source.name;
p.Visible = 'off';


% Initialize children

vpos = p_height - (p_title_spacer + v_spacer + element_height);
lpos = 5 .* h_spacer + onoff_box_width + slider_width;
u1 = uicontrol('Parent',p,'Position',[lpos vpos box_width element_height],'Tag','bg_min_txt','Style','text','String','Min');


lpos = lpos + h_spacer + box_width;
u2 = uicontrol('Parent',p,'Position',[lpos vpos box_width element_height],'Tag','bg_val_txt','Style','text','String','Val');

lpos = lpos + h_spacer + box_width;
u3 = uicontrol('Parent',p,'Position',[lpos vpos box_width element_height],'Tag','bg_max_txt','Style','text','String','Max');

for i = 1:nrows
    % h_spacers in this section affect the panel width
    
    trow = tags(i,:);
    %vpos = p_height - 2 .* (v_spacer + element_height) - p_title_spacer;
    vpos = p_height - (i+1) .* (v_spacer + element_height) - p_title_spacer;

    if nrows == 1
        bg_txt = 'BG not substracted';
    else
        bg_txt = ['BG' num2str(i) ' not substracted'];
    end
    lpos = h_spacer;
    u4 = uicontrol('Parent',p,'Position',[lpos vpos onoff_box_width element_height],'Tag',['bgonoff' num2str(i) '_chck'],'Style','checkbox','String',bg_txt);
    u4.Callback = @(hObject,callbackdata) obj.controller.bg_enable_callback(hObject,callbackdata);
    u4.Value = source.enabled(i);

    lpos = lpos + h_spacer + onoff_box_width;
    sldr = uicontrol('Parent',p,'Position',[lpos vpos-2 onoff_box_width element_height],'Tag',trow{1},'Style','slider');
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

    % leave toggle button enabled
    
    if u4.Value
        
        sldr.Enable = 'on';
        eb_min.Enable = 'on';
        eb_val.Enable = 'on';
        eb_max.Enable = 'on';
        chck.Enable = 'on';
        
    else

        sldr.Enable = 'off';
        eb_min.Enable = 'off';
        eb_val.Enable = 'off';
        eb_max.Enable = 'off';
        chck.Enable = 'off';
    
    end
    
end % for

end

