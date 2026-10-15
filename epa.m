% =========================================================================
% UNIVERSITY WATER DISTRIBUTION NETWORK SIMULATOR (PURE MATLAB)
% =========================================================================
clear; clc; close all;

%% 1. INPUT PARAMETERS (Adjust these as needed)
% Elevation data (meters)
Elev_Reservoir = 100.0;
Elev_J1 = 85.0;
Elev_J2 = 80.0;
Elev_J3 = 75.0;
Elev_Njuki = 83.0;
Elev_Nyerere = 78.0;
Elev_Ogoola = 73.0;

% Water Demands at the Halls (converted to m^3/s)
% Example: 5 Liters per second = 0.005 m^3/s
Q_Njuki = 0.005;   
Q_Nyerere = 0.005; 
Q_Ogoola = 0.005;  

% Pipe Properties: [Length(m), Diameter(m), Hazen-Williams C-Roughness]
Pipe1_prop   = [100.0, 0.20, 100]; % Reservoir to Junction 1
Pipe2_prop   = [150.0, 0.15, 100]; % Junction 1 to Junction 2
Pipe3_prop   = [150.0, 0.10, 100]; % Junction 2 to Junction 3
A_Branch_prop = [80.0,  0.08, 100]; % J1 to Njuki Hall
B_Branch_prop = [80.0,  0.08, 100]; % J2 to Julius Nyerere Hall
C_Branch_prop = [80.0,  0.08, 100]; % J3 to James Ogoola Hall

%% 2. HYDRAULIC FLOW BALANCE (Tree Topology)
% Flows are solved directly from bottom to top
Q_C_Branch = Q_Ogoola;
Q_Pipe3    = Q_C_Branch;

Q_B_Branch = Q_Nyerere;
Q_Pipe2    = Q_Pipe3 + Q_B_Branch;

Q_A_Branch = Q_Njuki;
Q_Pipe1    = Q_Pipe2 + Q_A_Branch;

%% 3. HEAD LOSS & PRESSURE CALCULATIONS
% Function handle for Hazen-Williams head loss formula (SI Units)
% hf = 10.67 * L * Q^1.852 / (C^1.852 * D^4.87)
hf = @(L, D, C, Q) 10.67 * L * (Q^1.852) / ((C^1.852) * (D^4.87));

% Start with total head at the Source Tank (Reservoir)
Head_Reservoir = Elev_Reservoir; 

% Calculate hydraulic heads moving down the main pipeline spine
Head_J1 = Head_Reservoir - hf(Pipe1_prop(1), Pipe1_prop(2), Pipe1_prop(3), Q_Pipe1);
Head_J2 = Head_J1 - hf(Pipe2_prop(1), Pipe2_prop(2), Pipe2_prop(3), Q_Pipe2);
Head_J3 = Head_J2 - hf(Pipe3_prop(1), Pipe3_prop(2), Pipe3_prop(3), Q_Pipe3);

% Calculate hydraulic heads at the end of each branch (the Halls)
Head_Njuki   = Head_J1 - hf(A_Branch_prop(1), A_Branch_prop(2), A_Branch_prop(3), Q_A_Branch);
Head_Nyerere = Head_J2 - hf(B_Branch_prop(1), B_Branch_prop(2), B_Branch_prop(3), Q_B_Branch);
Head_Ogoola  = Head_J3 - hf(C_Branch_prop(1), C_Branch_prop(2), C_Branch_prop(3), Q_C_Branch);

% Convert Hydraulic Head to Pressure Head (Pressure = Head - Elevation)
P_J1 = Head_J1 - Elev_J1;
P_J2 = Head_J2 - Elev_J2;
P_J3 = Head_J3 - Elev_J3;

P_Njuki   = Head_Njuki - Elev_Njuki;
P_Nyerere = Head_Nyerere - Elev_Nyerere;
P_Ogoola  = Head_Ogoola - Elev_Ogoola;

%% 4. DISPLAY RESULTS IN THE COMMAND WINDOW
fprintf('===============================================\n');
fprintf('      WATER NETWORK SIMULATION RESULTS         \n');
fprintf('===============================================\n');
fprintf('PIPE FLOW RATES:\n');
fprintf('  Pipe 1 (Main Trunk)       : %.2f L/s\n', Q_Pipe1 * 1000);
fprintf('  Pipe 2 (Middle Trunk)     : %.2f L/s\n', Q_Pipe2 * 1000);
fprintf('  Pipe 3 (Lower Trunk)      : %.2f L/s\n', Q_Pipe3 * 1000);
fprintf('  A-Branch (Njuki)          : %.2f L/s\n', Q_A_Branch * 1000);
fprintf('  B-Branch (Nyerere)        : %.2f L/s\n', Q_B_Branch * 1000);
fprintf('  C-Branch (Ogoola)         : %.2f L/s\n', Q_C_Branch * 1000);
fprintf('\nNODAL PRESSURES (meters of water head):\n');
fprintf('  Junction 1                : %.2f m\n', P_J1);
fprintf('  Junction 2                : %.2f m\n', P_J2);
fprintf('  Junction 3                : %.2f m\n', P_J3);
fprintf('  NJUKI HALL                : %.2f m\n', P_Njuki);
fprintf('  JULIUS NYERERE HALL       : %.2f m\n', P_Nyerere);
fprintf('  JAMES OGOOLA HALL         : %.2f m\n', P_Ogoola);
fprintf('===============================================\n');

%% 5. VISUALIZE NETWORK PRESSURE PROFILE
figure('Color', 'w');
halls = {'Njuki Hall', 'Julius Nyerere Hall', 'James Ogoola Hall'};
pressures = [P_Njuki, P_Nyerere, P_Ogoola];

bar(pressures, 0.5, 'FaceColor', [0.2 0.6 0.8]);
ylabel('Available Pressure (meters of water)');
title('Delivery Pressure at University Halls');
set(gca, 'XTickLabel', halls);
grid on;

