function [pinds,type] = get(obj,index)
%GET Returns the total parameter vector indices and species type for
%specified species.
%
%   [pinds,type] = get(index)
%   
% Parameters
% index         Index of the queried species
% 
% Returns
% pinds         Vector containing the set of parameter indices for
%               total parameter vector p for the specified species
% type          Type string for the pinds, e.g. "SM_Background" if the
%               indices are for the SM_Background parameters
%
%
% Throws
% PINDS:IndexOutOfBounds    if calling the function if index is larger than
%                           the number of species
%

if index > obj.n_species || index < 1
   
    msgID = 'PINDS:IndexOutOfBounds';
    msg = 'Index out of bounds.';
    EM = MException(msgID,msg);
    throw(EM);
    
end

pinds = obj.pind_arrays{index};
type = obj.pind_types{index};


end

