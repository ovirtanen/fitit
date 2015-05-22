function br_switch_callback(obj,hObject,callbackdata)
%BR_SWITCH_CALLBACK Callback for toggling SLS back reflection

obj.model.initialize_sls_backreflection(1.332,658);
obj.view.update_axes();

end