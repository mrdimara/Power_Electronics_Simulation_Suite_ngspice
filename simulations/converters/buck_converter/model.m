function u = pwm(fs, d, t)
% PWM using triangular carrier (-1 to 1)
% t must be a scalar (called each ODE iteration)

  Ts    = 1/fs;
  t_mod = mod(t, Ts);        % where we are within current period

  % triangular carrier (-1 to 1)
  if t_mod < Ts/2
    carrier = -1 + (4/Ts) * t_mod;     % rising slope
  else
    carrier =  3 - (4/Ts) * t_mod;     % falling slope
  end

  % convert duty cycle (0 to 1) to reference (-1 to 1)
  ref = 2*d - 1;

  % compare
  if ref > carrier
    u = 1;      % switch ON
  else
    u = 0;      % switch OFF
  end

endfunction