function match_br_to_ds(obj,nds)
%MATCH_BR_TO_DS Set the number of SLS_Backreflections to match the
%number of loaded datasets

Lib.inargtchck(nds,@(x) all([numel(nds) == 1 isfloat(x) x >= 1 rem(x,1) == 0]));

brs = obj.sls_br;

if isempty(brs)
    
    return;
    
end

%% Change the number of SLS_Backreflections

if nds < numel(brs)
    
    delta = numel(brs) - nds;
    
    brs = brs(1:end-delta);
    
    obj.sls_br = brs;
    
elseif nds > numel(brs)
    
    delta = nds - numel(brs);
    
    brlast = brs(end);
    
    ri = brlast.refr_index;
    wl = brlast.w_length;
    eta = brlast.eta{2};
    
    for i = 1:delta
       
        obj.initialize_sls_backreflection(ri,wl,eta,1);
        
    end
    
    
else % no need to adjust
    
    return;
    
end


end

