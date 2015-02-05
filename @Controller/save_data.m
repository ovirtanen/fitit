function save_data(obj)
%SAVE_DATA Fetches the relevant information from the Model and writes it to
%user specified text file.

m = obj.model;
ds = m.data_sets;

n_smodels = numel(obj.model.s_models);
n_data_sets = numel(ds);

pa = Print_array(2 + 3.*n_data_sets + 8.*n_smodels);


if n_data_sets == 1 && ~all(cellfun(@isempty,{ds.q_exp ds.i_exp ds.std_exp})) % one data set with empirical data
    
    pa.add_data(ds.q_exp,'q experimental','nm-1');
    pa.add_data(ds.i_exp,'Intensity','cm-1');
    pa.add_data(ds.std_exp,'STD','cm-1');

    %{ 
    % multiple data sets are not supported at this time
elseif n_data_sets > 1
    
    for i = 1:numel(ds)
        
        pa.add_data(ds(i).q_exp,['q data set ' num2str(i)],'nm-1');
        pa.add_data(ds(i).i_exp,'Intensity','cm-1');
        pa.add_data(ds(i).std_exp,'STD','cm-1');
        
    end % for
    %}
    
elseif n_data_sets > 1
    
    error('Multiple data_sets are not supported yet.');
    
end % if

pa.add_data(ds.q_mod,'q','nm-1');
pa.add_data(m.total_scattered_intensity(100,ds.q_mod),'Intensity','cm-1');

for i = 1:numel(m.s_models)

    if numel(m.s_models) == 1
       
        sm = m.s_models;
        
    else
        
        sm = m.s_models(1);
        
    end
    
    params = sm.p_name_strings(:);
    
    pa.add_data(params,sm.name,'');
    pa.add_data(sm.get_param_vector,'Fit values','');
    
    if isa(sm,'Scattering_model_spherical')
       
       [rprf,prf] = sm.radial_profile();
       pa.add_data(rprf,'Radial points','nm');
       pa.add_data(prf,'Contrast','');
        
    end

    params = sm.dist.p_name_strings(:);
    
    pa.add_data(params,sm.dist.name,'');
    pa.add_data(sm.dist.get_param_vector,'Fit values','');

    [rpsd,psd,~] = sm.dist.psd(100,sm.dist.get_param_vector);
    
    pa.add_data(rpsd,'Radius','nm');
    pa.add_data(psd,'PSD','');

end % for

pind = obj.fw.addParray(pa);
obj.fw.saveToFile(pind);
obj.fw.deleteParrays();

end

