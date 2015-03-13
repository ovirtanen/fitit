function mx = max_limit(obj)
%MAX_LIMIT Maximum limit of the distribution
%  


if max(obj.rpsd) <= 1000
   
    mx = 1000;
    
else
    
    mx = max(obj.rpsd) + 500;
    
    
end % if

end

