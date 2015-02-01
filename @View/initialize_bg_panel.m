function p = initialize_bg_panel(obj,p)
%INITIALIZE_BG_PANEL Initializes the background parameter panel for GUI
%   

parent = p;
source = obj.model.bg;
tags = Scattering_model.param_ids_to_tags(source.p_ids,'gui');

%%% Panel size and properties

% Horizontal spacers
h_spacer = 4;           %px
onoff_box_width = 120;  %px
slider_width = 120;     %px
box_width = 60;         %px

% Vertical spacers
v_spacer = 4;           %px
element_height = 20;    %px
p_title_spacer = 10;    %px

p_width = 10 * h_spacer + onoff_box_width + slider_width + 4 * box_width;
p_height = p_title_spacer + 2.*element_height + 4 * v_spacer;

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

% h_spacers in this section affect the panel width


vpos = p_height - 2 .* (v_spacer + element_height) - p_title_spacer;
    
lpos = h_spacer;
u4 = uicontrol('Parent',p,'Position',[lpos vpos onoff_box_width element_height],'Tag','bgonoff_chck','Style','checkbox','String','BG not substracted');
u4.Callback = @(hObject,callbackdata) obj.controller.bg_enable_callback(hObject,callbackdata);
u4.Value = 0;

lpos = lpos + h_spacer + onoff_box_width;
sldr = uicontrol('Parent',p,'Position',[lpos vpos-2 onoff_box_width element_height],'Tag',tags{1},'Style','slider');
sldr.Callback = @(hObject,callbackdata) obj.controller.slider_callback(hObject,callbackdata);


lpos = lpos + 3.* h_spacer + slider_width;
eb_min = uicontrol('Parent',p,'Position',[lpos vpos box_width element_height],'Tag',tags{2},'Style','edit');
eb_min.Callback = @(hObject,callbackdata) obj.controller.edit_box_callback(hObject,callbackdata);
v = source.get_param(eb_min.Tag);
eb_min.String = num2str(v);
sldr.Min = v;

    
lpos = lpos + h_spacer + box_width;
eb_val = uicontrol('Parent',p,'Position',[lpos vpos box_width element_height],'Tag',tags{3},'Style','edit');
eb_val.Callback = @(hObject,callbackdata) obj.controller.edit_box_callback(hObject,callbackdata);
v = source.get_param(eb_val.Tag);
eb_val.String = num2str(v);
sldr.Value = v;

    
lpos = lpos + h_spacer + box_width;
eb_max = uicontrol('Parent',p,'Position',[lpos vpos box_width element_height],'Tag',tags{4},'Style','edit');
eb_max.Callback = @(hObject,callbackdata) obj.controller.edit_box_callback(hObject,callbackdata);
v = source.get_param(eb_max.Tag);
eb_max.String = num2str(v);
sldr.Max = v;

    
lpos = lpos + 2 .* h_spacer + box_width;
chck = uicontrol('Parent',p,'Position',[lpos vpos box_width element_height],'Tag',tags{5},'Style','checkbox','String','fixed');
chck.Callback = @(hObject,callbackdata) obj.controller.check_box_callback(hObject,callbackdata);
v = source.get_param(chck.Tag);
chck.Value = v;

%Background is supported only for one dataset for now

switch numel(obj.model.data_sets)
    
    case 1  % leave toggle button enabled
        
        sldr.Enable = 'off';
        eb_min.Enable = 'off';
        eb_val.Enable = 'off';
        eb_max.Enable = 'off';
        chck.Enable = 'off';
        
    otherwise % disable all
        
        p.Enable = 'off';
    
end % switch

end

