function p = initialize_br_panel(obj,p)
%INITIALIZE_BR_PANEL Initializes the back reflection parameter panel for GUI
%   

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

parent = p;
source = obj.model.sls_br;

%%% Panel size and properties

% Horizontal spacers
h_spacer = obj.spacers.p_h_spacer;                  %px
onoff_box_width = obj.spacers.p_onoff_box_width;    %px
slider_width = obj.spacers.p_slider_width;          %px
br_text_tag_width = obj.spacers.br_text_tag_width;   %px; WL, RI
box_width = obj.spacers.p_box_width;                   %px

% Vertical spacers
v_spacer = obj.spacers.p_v_spacer;                  %px
element_height = obj.spacers.p_element_height;      %px
p_title_spacer = obj.spacers.p_title_spacer;        %px

p_width = 10 * h_spacer + onoff_box_width + slider_width + 4 * box_width;

% FIX THIS WHEN YOU HAVE TIME
%p_height = p_title_spacer + (numel(source) + 1) * element_height + (numel(source) + 2) * v_spacer;
p_height = p_title_spacer + numel(source) .* (2.5 .* element_height +  2.* v_spacer);

p = uipanel('Parent',parent,...
            'Units','pixels',...
            'Position',[0 0 p_width p_height]);       
       
p.Tag = 'br_panel';
p.Title = 'SLS backreflection parameters';
p.Visible = 'off';
p.ButtonDownFcn = @(hObject,Callbackdata) obj.controller.minimize_panel_callback(hObject,Callbackdata);

vpos = p_height; 

for i = 1:numel(source)    
    
    vpos = vpos - (p_title_spacer + v_spacer + element_height);
    
    if numel(source) == 1
        br_txt = 'BR on';
    else
        br_txt = ['BR ' num2str(i) ' on'];
    end
    
    lpos = h_spacer;
    u1 = uicontrol('Parent',p,'Position',[lpos vpos box_width element_height],'Tag',['bronoff' num2str(i) '_chck'],'Style','checkbox','String',br_txt);
    u1.Callback = @(hObject,callbackdata) obj.controller.br_enable_callback(hObject,callbackdata);
    u1.Value = source(i).enabled;
    
    lpos = lpos + box_width + 5.*h_spacer;
    u2 = uicontrol('Parent',p,'Position',[lpos vpos-3 br_text_tag_width element_height],'Tag','wl_txt','Style','text','String','WL');
    
    lpos = lpos + br_text_tag_width + h_spacer;
    wl = uicontrol('Parent',p,'Position',[lpos vpos box_width element_height],'Tag',['wl' num2str(i) '_val'],'Style','edit');
    wl.Callback = @(hObject,callbackdata) obj.controller.br_edit_box_callback(hObject,callbackdata);
    v = source(i).w_length;
    wl.String = num2str(v);
    
    lpos = lpos + box_width + h_spacer;
    u3 = uicontrol('Parent',p,'Position',[lpos vpos-3 br_text_tag_width element_height],'Tag','wl_txt','Style','text','String','RI');
    
    lpos = lpos + br_text_tag_width + h_spacer;
    ri = uicontrol('Parent',p,'Position',[lpos vpos box_width element_height],'Tag',['ri' num2str(i) '_val'],'Style','edit');
    ri.Callback = @(hObject,callbackdata) obj.controller.br_edit_box_callback(hObject,callbackdata);
    v = source(i).refr_index;
    ri.String = num2str(v);
    
    if i == 1
    
        lpos = 5 .* h_spacer + onoff_box_width + slider_width;
        u4 = uicontrol('Parent',p,'Position',[lpos vpos box_width element_height],'Tag','br_min_txt','Style','text','String','Min');


        lpos = lpos + h_spacer + box_width;
        u5 = uicontrol('Parent',p,'Position',[lpos vpos box_width element_height],'Tag','br_val_txt','Style','text','String','Val');

        lpos = lpos + h_spacer + box_width;
        u6 = uicontrol('Parent',p,'Position',[lpos vpos box_width element_height],'Tag','br_max_txt','Style','text','String','Max');
    
    end
    % h_spacers in this section affect the panel width
    
    vpos = vpos - (v_spacer + element_height);
    lpos = h_spacer;
    
    uicontrol('Parent',p,'Position',[lpos vpos box_width element_height],'Tag',['eta' num2str(i) '_txt'],'Style','text','String',['Eta ' num2str(i)]);

    lpos = lpos + h_spacer + onoff_box_width;
    sldr = uicontrol('Parent',p,'Position',[lpos vpos-2 onoff_box_width element_height],'Tag',['eta' num2str(i) '_sldr'],'Style','slider');
    sldr.Callback = @(hObject,callbackdata) obj.controller.slider_callback(hObject,callbackdata);


    lpos = lpos + 3.* h_spacer + slider_width;
    eta_min = uicontrol('Parent',p,'Position',[lpos vpos box_width element_height],'Tag',['eta' num2str(i) '_min'],'Style','edit');
    eta_min.Callback = @(hObject,callbackdata) obj.controller.br_edit_box_callback(hObject,callbackdata);
    v = source(i).eta{1};
    eta_min.String = num2str(v);
    sldr.Min = v;


    lpos = lpos + h_spacer + box_width;
    eta_val = uicontrol('Parent',p,'Position',[lpos vpos box_width element_height],'Tag',['eta' num2str(i) '_val'],'Style','edit');
    eta_val.Callback = @(hObject,callbackdata) obj.controller.br_edit_box_callback(hObject,callbackdata);
    v = source(i).eta{2};
    eta_val.String = num2str(v);
    sldr.Value = v;


    lpos = lpos + h_spacer + box_width;
    eta_max = uicontrol('Parent',p,'Position',[lpos vpos box_width element_height],'Tag',['eta' num2str(i) '_max'],'Style','edit');
    eta_max.Callback = @(hObject,callbackdata) obj.controller.br_edit_box_callback(hObject,callbackdata);
    v = source(i).eta{3};
    eta_max.String = num2str(v);
    sldr.Max = v;


    lpos = lpos + 2 .* h_spacer + box_width;
    chck = uicontrol('Parent',p,'Position',[lpos vpos box_width element_height],'Tag',['eta' num2str(i) '_chck'],'Style','checkbox','String','fixed');
    chck.Callback = @(hObject,callbackdata) obj.controller.check_box_callback(hObject,callbackdata);
    v = source(i).eta{4};
    chck.Value = v;

    % leave toggle button enabled
    
    if u1.Value
    
        wl.Enable = 'on';
        ri.Enable = 'on';
        sldr.Enable = 'on';
        eta_min.Enable = 'on';
        eta_val.Enable = 'on';
        eta_max.Enable = 'on';
        chck.Enable = 'on';
    
    else
        
        wl.Enable = 'off';
        ri.Enable = 'off';
        sldr.Enable = 'off';
        eta_min.Enable = 'off';
        eta_val.Enable = 'off';
        eta_max.Enable = 'off';
        chck.Enable = 'off';
        
    end
    
end % for

obj.br_panel = p;

obj.realign_all_controls();

obj.br_panel.Visible = 'on';


end

