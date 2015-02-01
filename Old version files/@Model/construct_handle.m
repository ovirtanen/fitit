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
% dr          decay rate          1           4
% epds        Max pd of skin      2           5
% fuzz        Fuzziness           3           6
% amplitude   Amplitude           4           2
% Burr a      Size factor         5           7
% Burr b      Parameter b         6           8
% Burr c      Parameter c         7           9

% All parameters fixed:
% @(prm,q)scattered_intensity(q,a,nc,tau,vskin,fuzz,psd_m,psd_w)
% All paramters bound:
%                                  1   2      3      4      5      6      7      8      9      
% @(prm,q) obj.scattered_intensity(q,prm(4),obj.nc,prm(1),prm(2),prm(3),prm(5),prm(6),prm(7));


freef = not(obj.get_fixed_status());
nfree = num2cell(1:nnz(freef));

prms = {'dr_val',...
        'epds_val',...
        'fuzz_val',...
        'amplitude_val',...
        'a_val',...
        'c_val',...
        'k_val'};

indexes = cellfun(@obj.get_fit_param_index,prms,'UniformOutput',0);

f = @(x) ['obj.fit_param{' num2str(x) '}'];

call = cellfun(f,indexes,'UniformOutput',0);

f = @(x) ['prm(' num2str(x) ')'];

freeprms = cellfun(f,nfree,'UniformOutput',0);

call(freef) = freeprms;

str = ['@(prm,q) obj.scattered_intensity(q,' call{4} ',obj.nc,' call{1} ',' call{2} ',' call{3} ',' call{5} ',' call{6} ',' call{7} ')'];

h = eval(str);

end

