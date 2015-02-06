function d = import_data(obj,ms)
%IMPORT_DATA Imports user specified data and stores it in Model
%   
% d = import_data() Opens a dialog box for user to specify the data and makes
% some lazy attempts to recognize if the data is the right format. Data
% file should be a three column text file where the first column is q 
% (in inverse nanometers), second column the intensity and the third column
% the standard deviation of the intensity values. The first rows can be
% column headers, e.g. names and units. Returns three column double array
% d.
%
% Throws
% FitIt:InvalidFileStructure:No numeric data recognized.
% FitIt:InvalidFileStructure:Data structure not recognized.
%  
% Rethrows
% FitIt:UIException:Open dialog cancelled.
%

c = obj.fr.read_files(ms);
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

if not(cols == 3)
   
    err = MException('FitIt:InvalidFileStructure',...
        'Data structure not recognized.');
    throw(err);
      
end % if

end

