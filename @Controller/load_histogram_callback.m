function load_histogram_callback(obj,hObject,callbackdata)
%LOAD_HISTOGRAM_CALLBACK Callback for loading custom histogram as
%PSD distribution

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

try 
    
    d = obj.import_histogram_data(); 
    
catch ME
   
    if strcmp(ME.message,'Open dialog cancelled.')
        
        return;
        
    elseif strcmp(ME.message,'Data structure not recognized.')
        
        errstr = 'Data file does not seem to have three columns. There should be only three columns: q(nm^(-1)), intensity and std.';
    
        errordlg(errstr,'Invalid parameter','modal');
        
        return;
        
    elseif strcmp(ME.message,'No numeric data recognized.')
        
        errstr = 'Data file does not seem to contain numeric data.';
    
        errordlg(errstr,'Invalid parameter','modal');
        
        return;
        
    else rethrow(ME)
        
    end % if
    
end % try-catch


dst = DST_Histogram(d(:,1),d(:,2));

obj.swap_distribution(dst);


end

