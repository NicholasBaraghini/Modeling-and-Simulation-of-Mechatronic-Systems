
%% lumped parameter convective heat transfer equation:

rho = 6450;          % mass density of SMA wire[kgm-3]
c_heat = 837.36;     % specific heat of SMA wire [Jkg-1C-1] o (0.2calg-1C-1) 
lo = 0.96;           % undeformed SMA wire length in 100% A state [m]
do = 5e-4;           % cross-sectional diameter of undeformed SMA wire [m]
h = 70;              % convection heat transfer coefficient [Wm-2C-1] (NOT SURE)
v = 24;              % voltage across SMA wire [V]
R = 4.3;             % SMA electric resistance per unit lenght [Ohm/m]
L = 0;               % SMA electric Inductance [H]
i = 0.8;               % current through SMA wire [A]
T_amb = 20;          % ambient temperature [C]
Area_sup = 6.28e-4;  % External Surface Area of the SMA wire per unit length [m2/m]

Initial_temperature = T_amb;
%% Hysteresis Model Parameters

Initial_Rm = 1;

mu_minus =    57;
mu_plus =     72;
sigma_minus = 1.6;
sigma_plus =  1.5;
ni_minus =    1;
ni_plus =     1;

A_start_LT = 68;    % Austenite Starting Low-Temperature [C]
A_end_LT   = 78;    % Austenite Ending Low-Temperature [C]
M_start_LT = 52;    % Martensite Starting Low-Temperature [C]
M_end_LT   = 42;    % Martensite Ending Low-Temperature [C]

A_start_HT = 88;    % Austenite Starting High-Temperature [C]
A_end_HT   = 98;    % Austenite Ending High-Temperature [C]
M_start_HT = 72;    % Martensite Starting High-Temperature [C]
M_end_HT   = 62;    % Martensite Ending High-Temperature [C]

%% Mechanical Model Parameters

Spring_Stiff = 12;      % Fixed Spring Stiffness [N/m]
Slider_Friction = 0.11; % Dinamic Friction of the Slider [N/(m/s)]
Slider_Mass = 0.02;     % Mass of the Slider []
Em = 34;         % Martensite Young Modulus[GPa]
Ea = 79;         % Austenite Young modulus [GPa]
k1 = 0.0204;     % first coefficient of the polinomio to fit the relation Lo(Rm)
k2 = 0.01293;    % second coefficient of the polinomio to fit the relation Lo(Rm)

%% Electrical Model Parameters

p1 = 9.2e-7; % [Ohm*m] 
p2 = 8.4e-7; % [Ohm*m] 
p3 = 0.2499; % [C-1]

q1 = 3.4e-8;  % [Ohm*m] 
q2 = 5.7e-10; % [Ohm*m / C]

m3 = 70; % [C]
n3 = 3;  % [C]

a0 = 8.7e-7;   % [Ohm*m]
a1 = 4.8e-8;   % [Ohm*m / C]
a2 = -7.8e-9;  % [Ohm*m / C2]
a3 = 7e-10;    % [Ohm*m / C3]
a4 = 3.7e-11;  % [Ohm*m / C4]


%% INverter Parameters

%SUPPLY SYSTEM (battery)
SupplyVoltage=80;
SupplyInternalResistance=0.4;
SupplyInternalInductance=0.4e-3;

%CONVERTER 4quadrantDC/DC
ConverterMAXoutCurrent=1.4;
CarrierFrequency=1e-3;
SampleTime=1e-8;

%CAPACITANCE  ( ALC10S1104DL )
Capacitance=10e-3;

%DIODE (CRS20I40A)
DiodeResistance=285.71428571;
DiodeVfm=0.43;

%N-MOSFET (BSD316SN)
MosfetResistance=160e-3;







%% Parameters to compute eps_o, eps_r, eps:
Delta = 4.425e-2;   % Spring Deformation 100% Austenite phase[m]
k = 58.19;          % Bias Spring Constant [Nm-1]

ET = 826;           % elasticity of fully twinned martensite[GPa]
Ed = 1680;          % elasticity of detwinned martensite[GPa]

eps_ym = 0.1;       % yield strain of twinned martensite
eps_dm = 0.15;      % minimum strain of detwinned martensite

%eps_o = 0.5*(1-sqrt(1-((16*k*Delta)/(pi*Ea*(do^2)))));           % strain caused by pretension load in 100% state
%eps_r = 1;           % strain caused by – phase transformation
eps = 0.105; % 0.105 Max Value of strain %eps_o + eps_r; % total strain

%sig_o = Ea*eps_o; % pretension load stress due to bias spring [MPa];