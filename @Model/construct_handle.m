function h = construct_handle(obj)
%CONSTRUCT_HANDLE Constructs a function handle for lsqfit
% Apparently fit parameters for lsqcurvefit cannot be fixed by giving
% identical upper and lower bounds. Therefore fixing has to be done by
% modifying the function handle that is given to lsqcurvefit, i.e. leaving
% the fixed paramters out of the function handle and direct them to get the
% parameters directly from Model.fit_param.
%
%
%                           Param order   Call order (*facepalm)
% sd          Skin depth          1           4
% pd          pd of core          2           5
% epds        Max pd of skin      3           6
% fuzz        Fuzziness           4           7
% amplitude   Amplitude           5           2
% meanr       Mean of the PSD     6           8
% pdist       Polydispersity      7           9

% All parameters fixed:
% @(prm,q)scattered_intensity(q,a,nc,rfrac,vcore,vskin,fuzz,psd_m,psd_w)
% All paramters bound:
%                                  1   2      3      4      5      6      7      8     9
% @(prm,q) obj.scattered_intensity(q,prm(5),obj.nc,prm(1),prm(2),prm(3),prm(4),prm(6),prm(7));


freef = not(obj.get_fixed_status());
nfree = num2cell(1:nnz(freef));

prms = {'sd_val',...
        'pd_val',...
        'epds_val',...
        'fuzz_val',...
        'amplitude_val',...
        'meanr_val',...
        'pdisp_val'};

indexes = cellfun(@obj.get_fit_param_index,prms,'UniformOutput',0);

f = @(x) ['obj.fit_param{' num2str(x) '}'];

call = cellfun(f,indexes,'UniformOutput',0);

f = @(x) ['prm(' num2str(x) ')'];

freeprms = cellfun(f,nfree,'UniformOutput',0);

call(freef) = freeprms;

str = ['@(prm,q) obj.scattered_intensity(q,' call{5} ',obj.nc,' call{1} ',' call{2} ',' call{3} ',' call{4} ',' call{6} ',' call{7} ')'];

h = eval(str);


end

