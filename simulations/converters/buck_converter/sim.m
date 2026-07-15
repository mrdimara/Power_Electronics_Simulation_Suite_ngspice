% SIM.M - Buck Converter Simulation
% Runs the buck converter model and plots results

clear all
close all
clc

% ── Simulation Parameters ─────────────────────────────────────────────
Vin = 12;
L   = 10e-3;
C   = 100e-6;
Ro  = 10;
fs  = 10e3;
d   = 0.75;

params = [Vin, L, C, Ro, fs, d];

% ── Initial Conditions ────────────────────────────────────────────────
il0 = 0;        % initial inductor current (A)
vc0 = 0;        % initial capacitor voltage (V)
x0  = [il0; vc0];

% ── Time Vector ───────────────────────────────────────────────────────
t_start = 0;
t_end   = 60e-3;     % simulate for 5ms (50 switching cycles)
dt      = 1e-6;     % 1 microsecond step
t       = t_start : dt : t_end;

% ── Run ODE Solver ────────────────────────────────────────────────────
options = odeset('MaxStep', dt, 'RelTol', 1e-6, 'AbsTol', 1e-9);

[t_out, x_out] = ode45(@(t,x) model(x, t, params), t, x0, options);

% ── Extract States ────────────────────────────────────────────────────
il = x_out(:, 1);   % inductor current
vc = x_out(:, 2);   % output voltage

% ── Theoretical Steady State ──────────────────────────────────────────
Vo_theory = d * Vin;
fprintf('Theoretical Output Voltage : %.2f V\n', Vo_theory);
fprintf('Simulated Output Voltage   : %.2f V\n', mean(vc(end-100:end)));

% ── Plot Results ──────────────────────────────────────────────────────
figure(1)

subplot(3,1,1)
plot(t_out*1e3, il, 'b', 'LineWidth', 1.2)
xlabel('Time (ms)')
ylabel('I_L (A)')
title('Inductor Current')
grid on

subplot(3,1,2)
plot(t_out*1e3, vc, 'r', 'LineWidth', 1.2)
hold on
yline(Vo_theory, 'k--', 'LineWidth', 1, 'Label', 'Theoretical Vo')
xlabel('Time (ms)')
ylabel('V_C (V)')
title('Output Voltage')
grid on

subplot(3,1,3)
% Regenerate PWM for plotting
pwm_sig = zeros(size(t));
for i = 1:length(t)
  pwm_sig(i) = pwm(fs, d, t(i));
end
plot(t*1e3, pwm_sig, 'g', 'LineWidth', 1.2)
xlabel('Time (ms)')
ylabel('PWM')
title('PWM Signal (d = 0.75)')
ylim([-0.2 1.2])
grid on

title('Buck Converter Simulation (Vin=12V, d=0.75, fs=10kHz)')
