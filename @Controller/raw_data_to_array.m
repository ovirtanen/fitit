function d = raw_data_to_array(obj,c)
%RAW_DATA_TO_ARRAY Maps raw data by File_reader.read_files() to double
%arrays
%   
% d = raw_data_to_array(c)

% Data file should be a three column text file where the first column is q 
% (in inverse nanometers), second column the intensity and the third column
% the standard deviation of the intensity values. The first rows can be
% column headers, e.g. names and units. 
%
%   Parameters
%   c       Cell array where each cell holds one imported text file as cell
%           array of strings row wise
%
%   Returns
%   d       Cell array where each cell holds a three column double array,
%           the columns corresponding to q, intensity and std.
%
% Throws
% FitIt:InvalidFileStructure:No numeric data recognized.
% FitIt:InvalidFileStructure:Data structure not recognized.
%  
% Rethrows
% FitIt:UIException:Open dialog cancelled.
%

%c = obj.fr.read_files(ms);

d = cell(numel(c),1);

for j = 1:numel(c)

    rc = c{j};

    datastart = 1;

    for i = 1:numel(rc)
    
        if not(isempty(str2num(char(rc(i)))))
       
            datastart = i;
            break;
        
        end
    
    end % for

    if datastart == numel(rc)
   
        err = MException('FitIt:InvalidFileStructure',...
            'No numeric data recognized.');
        throw(err);
    
    end % if

    d{j} = str2num(char(rc(datastart:end)));

    [~,cols] = size(d{j});

    if (cols == 2)
   
        warning('Only two columns, STD appears to be missing. Using STD = 1.');
        
    elseif not(cols == 3)
        
        err = MException('FitIt:InvalidFileStructure',...
            'Data structure not recognized.');
        throw(err);
      
    end % if
    
end % for

end

