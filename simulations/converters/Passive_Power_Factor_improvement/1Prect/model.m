function xdot = model(x, t, params)
  #Rectifier capacitor circuit - 1 phase
  iL = x(1);       #x1 is assigned to state variable iL
  vo = x(2);       #x2 is assigned to state variable vc

  vs = abs(325*sin(2*pi*50*t));
  L  = 1e-6;
  R1 = 1;
  R2 = 100;
  C  = 1000e-6;

  iLdot = (vs > vo) * (vs - iL*R1 - vo) / L;
  vodot = iL/C - vo/R2/C;

  xdot = [iLdot; vodot];
end