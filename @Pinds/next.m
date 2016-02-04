function [pinds,type] = next(obj)
%NEXT Returns the next total parameter vector indices and species type in
%the iterator.
%   
%   [pinds,type] = next()
%
% Returns
% pinds         Vector containing the next set of parameter indices for
%               total parameter vector p
% type          Type string for the pinds, e.g. "SM_Background" if the
%               indices are for the SM_Background parameters
%
% Throws
% PINDS:IndexOutOfBounds    if calling the function when the object
%                           has been exhausted.

i = obj.iterator_index;

if i > obj.n_species
   
    msgID = 'PINDS:IndexOutOfBounds';
    msg = 'Pinds instance has been exhausted.';
    EM = MException(msgID,msg);
    throw(EM);
    
end

pinds = obj.pind_arrays{i};
type = obj.pind_types{i};

obj.iterator_index = obj.iterator_index + 1; 

end

