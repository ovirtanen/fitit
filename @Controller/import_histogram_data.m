function d = import_histogram_data( obj )
%IMPORT_HISTOGRAM_DATA Imports user specified histogram as PSD 
%   
% d = import_data() Opens a dialog box for user to specify the data and makes
% some lazy attempts to recognize if the data is the right format. Data
% file should be a two column text file where the first column is collocation points
% for the distribution in nm, second column the PSD values. The first rows can be
% column headers, e.g. names and units. Returns two column double array
% d.
%
% Throws
% FitIt:InvalidFileStructure:No numeric data recognized.
% FitIt:InvalidFileStructure:Data structure not recognized.
%  
% Rethrows
% FitIt:UIException:Open dialog cancelled.
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

c = obj.fr.read_files('off');
c = c{1};

datastart = 1;

for i = 1:numel(c)
    
    if not(isempty(str2num(char(c(i)))))
       
        datastart = i;
        break;
        
    end
    
end % for

if datastart == numel(c)
   
    err = MException('FitIt:InvalidFileStructure',...
        'No numeric data recognized.');
    throw(err);
    
end % if

d = str2num(char(c(datastart:end)));

[~,cols] = size(d);

if not(cols == 2)
   
    err = MException('FitIt:InvalidFileStructure',...
        'Data structure not recognized.');
    throw(err);
      
end % if

end

