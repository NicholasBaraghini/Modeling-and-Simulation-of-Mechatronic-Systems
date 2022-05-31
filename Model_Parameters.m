clear
Simulink.defineIntEnumType('ElectricalInputType', {'voltage', 'current'},[0;1]);
%% lumped parameter convective heat transfer equation:

Tdb = 0.0002;
delta_step = 0.8;
delta_ramp = 1-delta_step;

%(optimal_step_param*delta_step + optimal_ramp_param*delta_ramp)

rho = (5392.4*delta_step + 4835.5*delta_ramp);   %6450;                % mass density of SMA wire[kgm-3]
c_heat = (530.21*delta_step + 446.67*delta_ramp);   %837.36;           % specific heat of SMA wire [Jkg-1C-1] o (0.2calg-1C-1) 
lo = 1-0.0137;                                                          % undeformed SMA wire length in 100% A state [m]
diameter = 5e-4;                                                       % cross-sectional diameter of undeformed SMA wire [m]
h =  (39.765*delta_step + 28.06*delta_ramp);   %40;                    % convection heat transfer coefficient [Wm-2C-1] (NOT SURE)
T_amb = (26.221*delta_step + 26.843*delta_ramp);  %24;                 % ambient temperature [C]
Area_sup = 6.28e-4;                                                    % External Surface Area of the SMA wire per unit length [m2/m]

Initial_temperature = (25.147*delta_step + 26.734*delta_ramp);
%% Hysteresis Model Parameters

Initial_Rm = 1;

mu_minus =   (52.26*delta_step + 52.208*delta_ramp);    %49.4;
mu_plus =    (56.727*delta_step + 56.131*delta_ramp);   %58.1848087777376;
sigma_minus =(8.711*delta_step + 8.5833*delta_ramp);    %8;
sigma_plus = (7.9951*delta_step + 8*delta_ramp);        %6;

%% Mechanical Model Parameters

L_init = 1.0;                                                                    %SMA Initial Length [m]

Spring_Stiff = (61.517*delta_step + 39.085*delta_ramp);   %75.6023360705349;     % Fixed Spring Stiffness [N/m]
Slider_Friction = (2.6643*delta_step + 0.84475*delta_ramp);   %1.98377011594776; % Dinamic Friction of the Slider [N/(m/s)]
Slider_Mass = (0.020002*delta_step + 0.020016*delta_ramp);   %0.035;             % Mass of the Slider [kg]
Em = (45*delta_step + 45*delta_ramp);   %34;                                     % Martensite Young Modulus[GPa]
Ea = (75.896*delta_step + 80.942*delta_ramp);   %79;                             % Austenite Young modulus [GPa]
k1 = 0.0149669;                                                                  % first coefficient of the polinomio to fit the relation Lo(Rm)
k2 = 0.001293;                                                                   % second coefficient of the polinomio to fit the relation Lo(Rm)

%% Electrical Model Parameters
SupplyVoltage = (25.001*delta_step + 25.988*delta_ramp);   %24;
R = (3.1232*delta_step + 2.1253*delta_ramp);   %4.3;                   % SMA electric resistance per unit lenght [Ohm/m]
L = 0;                                                                 % SMA electric Inductance [H]
i = 0.8;                                                               % current through SMA wire [A]
%% Conversions
% Volt to Position(m)
qVP = -0.003866;
mVP = 0.020563;

%% Workbench
potentiometer_max = 1.0;    % [V] Maximum voltage 
potentiometer_min = 0.3;    % [V] Minimum voltage

% PWM limits
duty_max = 0.2;
duty_min = 0;

%% Control System Parameters
PropotionalGain = 950;
IntegralGain = 0.275;
DerivativeGain = 13.5;











 %% ____Load Experimental Data To Parameter Refinment____
% Step 
% load('SensorInput_Step01.mat');
% load('SensorPosition_Step01.mat');
% load('SensorVoltage_Step01.mat');

% Ramp
% load('SensorInput_Ramp01.mat');
% load('SensorPosition_Ramp01.mat');
% load('SensorVoltage_Ramp01.mat');

% Square 0.2 
% load('SensorInput_Step02.mat');
% load('SensorPosition_Step02.mat');
% load('SensorVoltage_Step02.mat');

% Square 0.2 First Run
% load('SensorInput_Step03_PR.mat');
% load('SensorPosition_Step03_PR.mat');
% load('SensorVoltage_Step03_PR.mat');

% Square 0.2 Second Run
% load('SensorInput_Step04_SR.mat');
% load('SensorPosition_Step04_SR.mat');
% load('SensorVoltage_Step04_SR.mat');

% Square 0.1  triggered 10sec shutted down 30sec
% load('SensorInput_Step05_SR.mat');
% load('SensorPosition_Step05_SR.mat');
% load('SensorVoltage_Step05_SR.mat');

% Square 0.2 triggered 10sec shutted down 15sec
% load('SensorInput_Step06_SR.mat');
% load('SensorPosition_Step06_SR.mat');
% load('SensorVoltage_Step06_SR.mat');

% Square 0.1 triggered 10sec shutted down 15sec
% load('SensorInput_Step07_SR.mat');
% load('SensorPosition_Step07_SR.mat');
% load('SensorVoltage_Step07_SR.mat');

% Triangle
% load('SensorInput_Ramp02.mat');
% load('SensorPosition_Ramp02.mat');
% load('SensorVoltage_Ramp02.mat');


% Time = SensorPosition.time;
% Position = SensorPosition.signals.values;
% Position = (Position-(Position(1)*ones(size(Position))));
% Voltage = SensorVoltage.signals.values;
% InputTime = BeagleBoneInput_DutyCycle.time;
% InputDuty = BeagleBoneInput_DutyCycle.signals.values;
% ExpPosition = [Time, Position];
% 
% figure();
% plot(Time, Position)
% figure();
% plot(InputTime, InputDuty)





%% ____Plot Control Refence Tracking Results____ 

%% Scalinata Refence Tracking 
type = 'Scalinata Signal';
% Experimental Data
load('WEY_CONTROLLO_ScalinataReference.mat')
load('WEY_CONTROLLO_ScalinataResponseOUT.mat')
ReferenceTime = Reference.time;
ReferencePosition = Reference.signals.values;
SensorTime = PositionSignal.time;
SensorPosition = PositionSignal.signals.values;

% Model Data
load('WEY_CONTROLLO_ScalinataReference_MODEL.mat')
load('WEY_CONTROLLO_ScalinataResponseOUT_MODEL.mat')
ReferenceTime_MODEL = out.ReferenceModel.time;
ReferencePosition_MODEL = out.ReferenceModel.signals.values;
DisplacementTime_MODEL = out.PositionModel.time;
Displacement_MODEL = out.PositionModel.signals.values;

% Model Data + Noise
load('WEY_CONTROLLO_ScalinataReference_MODEL_NOISE.mat')
load('WEY_CONTROLLO_ScalinataResponseOUT_MODEL_NOISE.mat')
ReferenceTime_MODEL_NOISE = out.ReferenceModel.time;
ReferencePosition_MODEL_NOISE = out.ReferenceModel.signals.values;
DisplacementTime_MODEL_NOISE = out.PositionModel.time;
Displacement_MODEL_NOISE = out.PositionModel.signals.values;

%% Seno Refence Tracking
% type = 'Seno Signal';
% % Experimental Data
% load('WEY_CONTROLLO_SenoReference.mat')
% load('WEY_CONTROLLO_SenoResponseOUT.mat')
% ReferenceTime = Reference.time;
% ReferencePosition = Reference.signals.values;
% SensorTime = PositionSignal.time;
% SensorPosition = PositionSignal.signals.values;
% 
% % Model Data
% load('WEY_CONTROLLO_SenoReference_MODEL.mat')
% load('WEY_CONTROLLO_SenoResponseOUT_MODEL.mat')
% ReferenceTime_MODEL = out.ReferenceModel.time;
% ReferencePosition_MODEL = out.ReferenceModel.signals.values;
% DisplacementTime_MODEL = out.PositionModel.time;
% Displacement_MODEL = out.PositionModel.signals.values;
% 
% % Model Data + Noise
% load('WEY_CONTROLLO_SenoReference_MODEL_NOISE.mat')
% load('WEY_CONTROLLO_SenoResponseOUT_MODEL_NOISE.mat')
% ReferenceTime_MODEL_NOISE = out.ReferenceModel.time;
% ReferencePosition_MODEL_NOISE = out.ReferenceModel.signals.values;
% DisplacementTime_MODEL_NOISE = out.PositionModel.time;
% Displacement_MODEL_NOISE = out.PositionModel.signals.values;

%% Square Refence Tracking with Amplitude 80% of the maximum displacement performed by the SMA
% type = 'Square 80% Signal';
% % Experimental Data
% load('WEY_CONTROLLO_Square08Reference.mat')
% load('WEY_CONTROLLO_Square08ResponseOUT.mat')
% ReferenceTime = Reference.time;
% ReferencePosition = Reference.signals.values;
% SensorTime = PositionSignal.time;
% SensorPosition = PositionSignal.signals.values;
% 
% % Model Data
% load('WEY_CONTROLLO_Square08Reference_MODEL.mat')
% load('WEY_CONTROLLO_Square08ResponseOUT_MODEL.mat')
% ReferenceTime_MODEL = out.ReferenceModel.time;
% ReferencePosition_MODEL = out.ReferenceModel.signals.values;
% DisplacementTime_MODEL = out.PositionModel.time;
% Displacement_MODEL = out.PositionModel.signals.values;
% 
% % Model Data + Noise
% load('WEY_CONTROLLO_Square08Reference_MODEL_NOISE.mat')
% load('WEY_CONTROLLO_Square08ResponseOUT_MODEL_NOISE.mat')
% ReferenceTime_MODEL_NOISE = out.ReferenceModel.time;
% ReferencePosition_MODEL_NOISE = out.ReferenceModel.signals.values;
% DisplacementTime_MODEL_NOISE = out.PositionModel.time;
% Displacement_MODEL_NOISE = out.PositionModel.signals.values;

%% Square Refence Tracking with Amplitude 100% of the maximum displacement performed by the SMA
% type = 'Square 100% Signal';
% % Experimental Data
% load('WEY_CONTROLLO_SquareMaxReference.mat')
% load('WEY_CONTROLLO_SquareMaxResponseOUT.mat')
% ReferenceTime = Reference.time;
% ReferencePosition = Reference.signals.values;
% SensorTime = PositionSignal.time;
% SensorPosition = PositionSignal.signals.values;
% 
% % Model Data
% load('WEY_CONTROLLO_SquareMaxReference_MODEL.mat')
% load('WEY_CONTROLLO_SquareMaxResponseOUT_MODEL.mat')
% ReferenceTime_MODEL = out.ReferenceModel.time;
% ReferencePosition_MODEL = out.ReferenceModel.signals.values;
% DisplacementTime_MODEL = out.PositionModel.time;
% Displacement_MODEL = out.PositionModel.signals.values;
% 
% % Model Data + Noise
% load('WEY_CONTROLLO_SquareMaxReference_MODEL_NOISE.mat')
% load('WEY_CONTROLLO_SquareMaxResponseOUT_MODEL_NOISE.mat')
% ReferenceTime_MODEL_NOISE = out.ReferenceModel.time;
% ReferencePosition_MODEL_NOISE = out.ReferenceModel.signals.values;
% DisplacementTime_MODEL_NOISE = out.PositionModel.time;
% Displacement_MODEL_NOISE = out.PositionModel.signals.values;

%% Trinagular Refence Tracking
% type = 'Triangle 80% Signal';
% % Experimental Data
% load('WEY_CONTROLLO_TriangularReference.mat')
% load('WEY_CONTROLLO_TrinagularResponseOUT.mat')
% ReferenceTime = Reference.time;
% ReferencePosition = Reference.signals.values;
% SensorTime = PositionSignal.time;
% SensorPosition = PositionSignal.signals.values;
% 
% % Model Data
% load('WEY_CONTROLLO_TriangularReference_MODEL.mat')
% load('WEY_CONTROLLO_TrinagularResponseOUT_MODEL.mat')
% ReferenceTime_MODEL = out.ReferenceModel.time;
% ReferencePosition_MODEL = out.ReferenceModel.signals.values;
% DisplacementTime_MODEL = out.PositionModel.time;
% Displacement_MODEL = out.PositionModel.signals.values;
% 
% % Model Data + Noise
% load('WEY_CONTROLLO_TriangularReference_MODEL_NOISE.mat')
% load('WEY_CONTROLLO_TrinagularResponseOUT_MODEL_NOISE.mat')
% ReferenceTime_MODEL_NOISE = out.ReferenceModel.time;
% ReferencePosition_MODEL_NOISE = out.ReferenceModel.signals.values;
% DisplacementTime_MODEL_NOISE = out.PositionModel.time;
% Displacement_MODEL_NOISE = out.PositionModel.signals.values;

%% Plotting
figure();
hold on;
title(type)
REF = plot(ReferenceTime,ReferencePosition);
SENS = plot(SensorTime,SensorPosition);
MOD = plot(DisplacementTime_MODEL, Displacement_MODEL);
MODN = plot(DisplacementTime_MODEL_NOISE, Displacement_MODEL_NOISE);

REF.Color = 'g';
REF.LineStyle = '--';
REF.LineWidth = 0.75;

SENS.Color = 'r';
SENS.LineStyle = '-';
SENS.LineWidth = 1;

MOD.Color = 'c';
MOD.LineStyle = ':';
MOD.LineWidth = 0.4;

MODN.Color = 'b';
MODN.LineStyle ='-';
MODN.LineWidth = 0.5;

lgd = legend({'Refernce','Slider position', 'Model Displacement', 'Model Displacement + Noise'},'Box','off');
c = lgd.TextColor;
lgd.TextColor = 'black';
xlabel('time');
ylabel('position (m)');





