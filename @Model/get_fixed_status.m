function b = get_fixed_status(obj)
%GET_FIXED_STATUS Returns "fixed" checkbox states as logical array
%   b = get_fixed_status()

b = logical(cell2mat(obj.fit_param(:,4)));

end

