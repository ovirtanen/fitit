function save_data(obj,varargin)
%SAVE_DATA Fetches the relevant information from the Model and writes it to
%user specified text file.
%
%   save_data() opens save dialog to specify save destination
%   save_data(file_path) saves the file to destination specified by
%   file_path
%
%

% Copyright (c) 2015, 2016, Otto Virtanen
% All rights reserved.

m = obj.model;
ds = m.data_sets;
nc = m.nc;

n_smodels = numel(obj.model.s_models);
n_data_sets = numel(ds);

pa = Print_array(2 + 3.*n_data_sets + 8.*n_smodels);


if n_data_sets == 0 % only calculated model
    
    % A bit crappy, but model q values are not saved anywhere expect the
    % si_axes
    op = findobj(obj.view.gui.Children,'Tag','output_panel');
    si = findobj(op.Children,'Tag','si_axes');
    xl = si.XLim;
    
    qfit = linspace(1e-4,xl(2),200);
    
    pa.add_data(qfit,'q fit','nm-1');
    pa.add_data(m.total_scattered_intensity(nc,1:numel(m.handles),qfit),'Intensity','cm-1');   

elseif n_data_sets == 1 && ~all(cellfun(@isempty,{ds.q_exp ds.i_exp ds.std_exp})) % one data set with empirical data
    
    pa.add_data(ds.q_exp,'q experimental','nm-1');
    pa.add_data(ds.i_exp,'Intensity','cm-1');
    pa.add_data(ds.std_exp,'STD','cm-1');
    
    % Fit
    if ds.is_smeared
        qfit = ds.q_exp;
    else
        qfit = linspace(1e-4,max(ds.q_exp),200);
    end
    pa.add_data(qfit,'q fit','nm-1');
    pa.add_data(m.total_scattered_intensity(nc,ds.active_handles,qfit),'Intensity','cm-1');


elseif n_data_sets > 1
    
    for i = 1:numel(ds)
        
        pa.add_data(ds(i).q_exp,['q experimental ' num2str(i)],'nm-1');
        pa.add_data(ds(i).i_exp,['Intensity ' num2str(i)],'cm-1');
        pa.add_data(ds(i).std_exp,['STD ' num2str(i)],'cm-1');

        % Fit
        if ds(i).is_smeared
            qfit = ds(i).q_exp;
        else
            qfit = linspace(1e-4,max(ds(i).q_exp),200);
        end
        pa.add_data(qfit,['q fit ' num2str(i)],'nm-1');
        pa.add_data(m.total_scattered_intensity(nc,ds(i).active_handles,qfit),['Intensity ' num2str(i)],'cm-1');
        
    end % for
    
    
end % if


for i = 1:numel(m.s_models)

       
    sm = m.s_models{i};
            
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

    [rpsd,psd,~] = sm.dist.psd(nc,sm.dist.get_param_vector);
    
    pa.add_data(rpsd,'Radius','nm');
    pa.add_data(psd,'PSD','');

end % for

br = obj.model.sls_br;

% add backreflection data if it is enabled
if not(isempty(br)) && any([br.enabled])
   
    for i = 1:numel(br)
    
        params = {'Refractive index';...
                  'Wave length (nm)';...
                  'eta'};
        values = {br(i).refr_index;...
                  br(i).w_length;...
                  br(i).eta{2}};

        pa.add_data(params,['SLS Backreflection' num2str(i)],'');
        pa.add_data(values,['Fit values ' num2str(i)],'');
   
    end
    
end

pindarray = obj.fw.addParray(pa);

switch nargin
    
    case 1
        
        obj.fw.saveToFile(pindarray);
        
    case 2
        
        path = varargin{1};
        
        % throws FitIt:InvalidSavePath
        obj.fw.writeToFile(pindarray,path);
        
    otherwise
        
        error('Invalid number of inargs.');
    
    
end


obj.fw.deleteParrays();

end

