
%% lumped parameter convective heat transfer equation:
Initial_temperature = 100;

rho = 6450;          % mass density of SMA wire[kgm-3]
c_heat = 837.36;     % specific heat of SMA wire [Jkg-1C-1] o (0.2calg-1C-1) 
Lo = 0.98;           % undeformed SMA wire length in 100% state [m]
do = 5e-4;           % cross-sectional diameter of undeformed SMA wire [m]
h = 70;              % convection heat transfer coefficient [Wm-2C-1] (NOT SURE)
v = 24;              % voltage across SMA wire [V]
R = 4.3;             % SMA electric resistance per unit lenght [Ohm/m]
i = 0.8;               % current through SMA wire [A]
T_amb = 20;          % ambient temperature [C]
Area_sup = 6.28e-4;  % External Surface Area of the SMA wire per unit length [m2/m]

%% Hysteresis Model Parameters

Initial_Rm = 1;

mu_minus =    57;
mu_plus =     72;
sigma_minus = 6;
sigma_plus =  6;
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














%% Parameters to compute eps_o, eps_r, eps:
Delta = 4.425e-2;   % Spring Deformation 100% Austenite phase[m]
k = 58.19;          % Bias Spring Constant [Nm-1]
Ea = 35917;         % Elsticity of Austenite [MPa]
ET = 826;           % elasticity of fully twinned martensite[MPa]
Ed = 1680;          % elasticity of detwinned martensite[MPa]
Em = 20480;         % elasticity of fully twinned martensite[MPa]
eps_ym = 0.1;       % yield strain of twinned martensite
eps_dm = 0.15;      % minimum strain of detwinned martensite

%eps_o = 0.5*(1-sqrt(1-((16*k*Delta)/(pi*Ea*(do^2)))));           % strain caused by pretension load in 100% state
%eps_r = 1;           % strain caused by – phase transformation
eps = 0.105; % 0.105 Max Value of strain %eps_o + eps_r; % total strain

%sig_o = Ea*eps_o; % pretension load stress due to bias spring [MPa];