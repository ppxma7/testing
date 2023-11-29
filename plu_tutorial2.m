ccd

h = 6.626e-34; % Js
c = 3e8; % ms-1
elecVolt = 1.6e-19; % J

mystruct = struct;

mystruct1 = mystruct;
mystruct1.element = 'Oxygen';
mystruct1.eV = 1.64;
mystruct1.eJ = mystruct1.eV .* elecVolt;
mystruct1.lambda = (h.*c)./mystruct1.eJ;

mystruct2 = mystruct;
mystruct2.element = 'Sodium';
mystruct2.eV = 2.11;
mystruct2.eJ = mystruct2.eV .* elecVolt;
mystruct2.lambda = (h.*c)./mystruct2.eJ;

mystruct3 = mystruct;
mystruct3.element = 'Hydrogen';
mystruct3.eV = 2.56;
mystruct3.eJ = mystruct3.eV .* elecVolt;
mystruct3.lambda = (h.*c)./mystruct3.eJ;

mystruct4 = mystruct;
mystruct4.element = 'Iron';
mystruct4.eV = 2.89;
mystruct4.eJ = mystruct4.eV .* elecVolt;
mystruct4.lambda = (h.*c)./mystruct4.eJ;

mystruct5 = mystruct;
mystruct5.element = 'Hydrogen';
mystruct5.jumps = [0.31 0.97 2.86 13.05 0.66 2.55 12.74 1.89 12.08 10.19];
mystruct5.names = {'5to4','5to3','5to2','5to1','4to3','4to2','4to1',...
    '3to2','3to1','2to1'};
mystruct5.eJ = mystruct5.jumps .* elecVolt;
mystruct5.lambda = (h.*c)./mystruct5.eJ;

mystruct5.eJAng = mystruct5.lambda .* 1e10;

