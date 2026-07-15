clear
clc
#-----------------------------------------------------------
# SIMULATION OF Rectifier capacitor filter circuit - 1 phase
#-----------------------------------------------------------
tstep  = 1e-6;
tfinal = 60e-3;

t_span = 0:tstep:tfinal;
x0 = [0; 0];  # initial conditions: iL=0, vo=0

opts = odeset('RelTol',1e-6, 'AbsTol',1e-9, 'MaxStep',tstep*10);
[t, x] = ode45(@(t,x) model(x,t,[]), t_span, x0, opts);

iL = x(:,1);
vo = x(:,2);
vs = abs(325*sin(2*pi*50*t));

figure(1); clf;
plot(t, vs, 'r', t, vo, 'b', t, iL, 'k', 'LineWidth', 1.5);
legend('vs (V)', 'vo (V)', 'iL (A)');
xlabel('Time (s)');
ylabel('Amplitude');
title('1-Phase Rectifier Capacitor Filter Simulation');
grid on;