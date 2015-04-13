function d = import_data(obj,ms)
%IMPORT_DATA Import data using GUI
%
%   d = import_data(ms)
%
%   Parameters
%   ms          Multiselect, either 'on' or 'off'
%
%   Returns
%   d           Cell array, each cell holding a measurement data as three
%               column array

p = obj.fr.get_file_paths(ms);

c = obj.fr.read_files(p);

d = obj.raw_data_to_array(c);

end

