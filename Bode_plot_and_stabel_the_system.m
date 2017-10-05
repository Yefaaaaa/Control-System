%% Unstabel system
Gp = tf([100],[1,10.1,1,0])
bode(Gp)
grid on
%% Check phase margin and gain margin
[Gm, Pm, Wgm, Wpm] = margin(Gp)

%% Stable the system  -- keep phase but change gain
% Gp*Gc Gc < Gm
% Method 1: change the gain(apply proportional control to shift the crossover frequency)
Gc = 0.05
bode(Gp)
grid on
hold on 
bode(Gp*Gc)
hold off

%% check new sytem phase margin and gain margin
[Gm, Pm, Wgm, Wpm] = margin(Gp*Gc)


%% Add controller to stable  -- keep gain but change phase 
% Lag conpemsation control to decrease gain above a certain frequency range
Gc = tf([0.02,0.0005],[1,0.0005])
bode(Gp)
grid on
hold on 
bode(Gp*Gc)
hold off

%% check new sytem phase margin and gain margin
[Gm, Pm, Wgm, Wpm] = margin(Gp*Gc)

%% Add controller to stable -- boost the phase and keep gain
% Lead compensation control in boost phase at crossover frequency
Gc = tf([1,2],[1,4])
bode(Gp)
grid on
hold on 
bode(Gp*Gc)
hold off

%% check new sytem phase margin and gain margin
[Gm, Pm, Wgm, Wpm] = margin(Gp*Gc)




