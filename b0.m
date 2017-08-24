function[] = b0(T)

if ieNotDefined('T'), T = 1; end

gprot = 5.585694702; % wikipedia g-factor_physics
g_unitsofu = gprot ./2; 

% hyperphysics.phy-astr.gsu.edu/hbase/Nuclear/nspin.html
% nuclear magneton J/T
mu_prot = 5.05084e-27;
mu_prot_ev = 3.15245e-8;

% planck
h = 6.626070040e-34; % wikipedia Planck constant Js
h_ev = 4.135667662e-15; % "" eV
hbar = h_ev ./ (2*pi);

% hyperphysics.phy-astr.gsu.edu/hbase/Nuclear/nmr.html
wspin = (2*g_unitsofu*mu_prot_ev*T) / hbar ;
vfreq = wspin ./ (2*pi); %Hz
inmhz = vfreq * 1e-6; %MHz
fprintf('Larmor freq (in MHz): %.3f\n', inmhz)

end

