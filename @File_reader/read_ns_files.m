function m = read_ns_files(obj,ms)
%READ_NS_FILES Import NanoSight (NS) ...alltracks.csv files. Imported fields
%include particle size, diffusion coefficent and boolean value whether the
%track exceeds the minimum track length set in the NS software.
%
%   m = read_ns_files(ms)
%   
%   Parameters
%   ms          'on' or 'off' for importing multiple files simultaneously
%
%   Returns
%   m           cell array containing the imported measurements. Structure
%               of m: {import1; import2; ...}. Each import contains three
%               column array [partice_size d_coeff boolean].
%
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

p = obj.get_file_paths(obj.filter_spec,ms);
m = cell(numel(p),1);

try 
    
    for i = 1 : length(p)
       
        [psize,dcoeff,bool] = File_reader.read_ns_file(p{i});
        m{i} = [psize dcoeff bool];
        
    end % for
    
catch ME
    
    fclose('all');
    rethrow(ME);
    
end

end

