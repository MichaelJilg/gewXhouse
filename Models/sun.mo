model sun
  //
  parameter Real lat = 48.8785888 "latitude";
  parameter Real long = 8.7172797 "longitude";
  parameter Real pi = 3.141592654;
  parameter Real day = 26, month = 6;
  Real delta "declination angle";
  Real n "day number, such that day = 1 on the 1st January";
  Real m "part of the year";
  Real omega "hour angle";
  Real alpha, elevation "altitude angle";
  Real beta, azimuth "the solar azimuth angle";
  Real hour "actual time";
  Real phi "time equation";
  Real K;
  Real Flaechenstrahlung1 "Flächenstrahlung Seitenwand1";
  Real Flaechenstrahlung2 "Flächenstrahlung Seitenwand2";
  Real Flaechenstrahlung3 "Flächenstrahlung Seitenwand3";
  Real Flaechenstrahlung4 "Flächenstrahlung Seitenwand4";
  Real Flaechenstrahlung5 "Flächenstrahlung Dach";
  Real Flaechenstrahlung6 "Flächenstrahlung Dach";
  Real Flaechenstrahlung7;
  Real Direktstrahlung;
equation
  hour = time / 60 / 60;
  n = (month - 1) * 30.3 + day;
  K = pi / 180;
  m = (n - 1 + (hour - 12) / 24) / 365;
  delta = (0.006918 - 0.399912 * cos(2 * pi * m) + 0.070257 * sin(2 * pi * m) - 0.006758 * cos(4 * pi * m) + 0.000907 * sin(4 * pi * m) - 0.002697 * cos(6 * pi * m) + 0.00148 * sin(6 * pi * m)) / K;
  phi = 229.18 * (0.000075 + 0.001868 * cos(2 * pi * m) - 0.032077 * sin(2 * pi * m) - 0.014615 * cos(4 * pi * m) - 0.040849 * sin(4 * pi * m));
  omega = (hour * 60 + phi + 4 * long - 60) / 4 - 180;
  alpha = sin(K * lat) * sin(K * delta) + cos(K * lat) * cos(K * delta) * cos(K * omega);
  beta = -(sin(K * lat) * alpha - sin(K * delta)) / (cos(K * lat) * sin(acos(alpha)));
  elevation = asin(alpha) / K;
  azimuth = if der(beta) < 0 then acos(beta) / K else 360 - acos(beta) / K;
  Direktstrahlung = (-1) * 3000 + 5000 * sin(0.000035 * time);
  Flaechenstrahlung1 = Direktstrahlung * (cos(90 * K) + cos(abs(azimuth * K - 0 * K)) * sin(90 * K) * tan((if elevation < 0 then 0 else elevation) * K));
  Flaechenstrahlung7 = if Flaechenstrahlung1 < 0 then 0 else Flaechenstrahlung1;
  Flaechenstrahlung2 = Direktstrahlung * (cos(90 * K) + cos(abs(azimuth * K - 90 * K)) * sin(90 * K) * tan(elevation * K));
  Flaechenstrahlung3 = Direktstrahlung * (cos(90 * K) + cos(abs(azimuth * K - 180 * K)) * sin(90 * K) * tan(elevation * K));
  Flaechenstrahlung4 = Direktstrahlung * (cos(90 * K) + cos(abs(azimuth * K - 270 * K)) * sin(90 * K) * tan(elevation * K));
  Flaechenstrahlung5 = Direktstrahlung * (cos(45 * K) + cos(abs(azimuth * K - 90 * K)) * sin(45 * K) * tan(elevation * K));
  Flaechenstrahlung6 = Direktstrahlung * (cos(45 * K) + cos(abs(azimuth * K - 270 * K)) * sin(45 * K) * tan(elevation * K));
  annotation(
    experiment(StartTime = 0, StopTime = 100000, Tolerance = 1e-06, Interval = 66.7111));
end sun;