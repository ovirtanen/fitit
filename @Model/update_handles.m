function update_handles(obj)
%UPDATE_HANDLES Creates a handle set for calculating the total scattered
%intensity. Implements special features such as SLS backreflection and q
%smearing due to instrument resolution function.
%   
% update_handles()
%
% Structure of the parameter vector
% 
% p = 
%   [bg1 bg2 .. bgn br1 br2 .. brm p1 p2 ..pk]'
%
% There can be maximum numel(Model.data_sets) backgrounds and
% backreflections. Some of them or all of them might not be present in p if
% they are not enabled.
%

% Copyright (c) 2015, 2016, Otto Virtanen
% All rights reserved.

%% Some technicalities
pnd = Pinds(obj);
ds = obj.data_sets;
nds = 1: max([1 numel(ds)]); % Dataset indices, minimum one pseudo-dataset
sms = obj.s_models;

%% SLS_Backreflection stack
br_stack = cell(numel(ds),1);

if not(isempty(obj.sls_br))
    
    br_stack_index = 1:max([1 numel(ds)]);
    br_stack_index = br_stack_index(logical([obj.sls_br.enabled]));
    
end

%% Individual 'active handles' list for each dataset
active_handles = cell(numel(nds),1);

%% Master handle list for Model
handles = cell(pnd.n_species.*numel(nds),1); % maximum number of handles, might need trimming at the end
i_handle = 1;

%% Iterate trough all species present in the Model
for i = 1 : pnd.n_species
   
    [p_indices, type] = pnd.next();
    
    switch type
    
        case 'SM_Background'
            % There is maximum one SM_Background instance even if more than
            % one backgrounds are enabled. If no backgrounds are enabled,
            % Pinds will not return SM_Background related data.
            
            p_indices_orig = p_indices;
            
            for j = nds(logical(obj.bg.enabled))
                % Potentially all the datasets have to be processed at one 
                % time, see above. If more than one dataset has been loaded
                % but the background has not been enabled for all of them,
                % only the affected datasets will be processed.
                
                % Remove BG terms that are not for this dataset from
                % p_indices
                spr = obj.bg.scale_param_rows(logical(obj.bg.enabled));
                spr(j) = [];
               
                p_indices(spr) = [];
               
                h = @(nc,q,p) obj.bg.scattered_intensity(j,p(p_indices));
                
                % Update Model handle list and dataset active_handles list
                handles{i_handle} = h;
                active_handles{j} = [active_handles{j} i_handle];
                
                i_handle = i_handle + 1;
                
                % Restore p_indices that were mutilated
                p_indices = p_indices_orig;
                
            end
              
        case 'SLS_Backreflection'
            % Store SLS_Backreflection data to a stack for processing
            % simultaneously with Scattering_model instances.
            
            br_stack{br_stack_index(1)} = p_indices;
            br_stack_index(1) = [];
            
        case 'Scattering_model'
            % There might be more than one scattering model. 
            
            sm = sms{1};
            p_indices_orig = p_indices;
            
            for j = nds
               % If multiple datasets of the same sample but different
               % instrumental settings have been loaded, each dataset needs
               % its own handle (or handles if backreflection is active).

               % Remove amplitude terms that are not for this dataset from
               % p_indices
               spr = sm.scale_param_rows;
               spr(j) = [];
               
               p_indices(spr) = [];
               
               h = @(nc,q,p) sm.scattered_intensity(nc,q,p(p_indices));
               
               % Update Model handle list and dataset active_handles list
               handles{i_handle} = h;
               active_handles{j} = [active_handles{j} i_handle];
                
               i_handle = i_handle + 1;
               
               % *** SLS_BACKREFLECTION -----------------------------------
               % Check if SLS_Backreflection has been enabled for this
               % dataset and create a handle for it if necessary.
               % Backreflection shares model parameters with the actual
               % scattering model but with reflected q.
               
               if numel(br_stack) >= j && not(isempty(br_stack{j})) % if it's in the stack, it has been enabled
                  
                   fq = @(x) obj.sls_br(j).q_brefl(x);
                   
                   eta_index = br_stack{j};
                   h = @(nc,q,p) p(eta_index).* sm.scattered_intensity(nc,fq(q),p(p_indices));
                   
                   % Update Model handle list and dataset active_handles list
                   handles{i_handle} = h;
                   active_handles{j} = [active_handles{j} i_handle];
                
                   i_handle = i_handle + 1;
                   
               end
                
               % Restore p_indices that were mutilated
               p_indices = p_indices_orig;
               
            end % for
            
            sms{1} = []; % Remove the processed scattering model from the list
            
        otherwise
            
            error('Unrecognized type');
             
    end % switch
    
end % for

%% Assing handle sets to their right places

if not(isempty(ds)) 
   
    for j = nds
       
        ds(j).set_active_handles(active_handles{j});
        
    end
    
end

filter = cellfun(@isempty,handles);
obj.handles = handles(not(filter));

end

