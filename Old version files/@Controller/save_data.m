function save_data(obj)
%SAVE_DATA Fetches the relevant information from the Model and writes it to
%user specified text file.

pa = Print_array(7);
m = obj.model;

if m.is_data_loaded() % emprical data loaded
    
    pa.add_data(m.q,'q','nm-1');
    pa.add_data(m.intensity,'Intensity','cm-1');
    pa.add_data(m.std,'STD','cm-1');
    
end % if

pa.add_data(m.qfit,'q','nm-1');
pa.add_data(m.fit,'Intensity','cm-1');

pa.add_data(m.rpd,'Radius','nm');
pa.add_data(m.pd,'PD','a.u.');

pa.add_data(m.rpsd,'Radius','nm');
pa.add_data(m.psd,'PSD','PSD(R)');

params = {'        Decay rate';...
          '            Max PD';...
          '    Fuzziness (nm)';...
          '         Amplitude';...
          '  Mean radius (nm)';...
          'Polydispersity (%)'};
      
pa.add_data(params,'Fit parameters','');
pa.add_data(m.get_all_fit_param('literal'),'Fit values','');

fw = FileWriter(obj,'.txt');
pind = fw.addParray(pa);
fw.saveToFile(pind);
delete(fw);

end

