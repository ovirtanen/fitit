function display_about_box(obj)
%DISPLAY_ABOUT_BOX Displays the about dialog box


msg = {'FitIt',...
       ['version ' num2str(obj.version)],...
       '',...
       'Written by',...
       'Otto Virtanen',...
       'virtanen@pc.rwth-aachen.de',... 
       '',...
       'Copyright Otto Virtanen 2015'};

msgbox(msg);


end

