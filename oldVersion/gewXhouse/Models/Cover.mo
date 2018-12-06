within gewXhouse.Models;

model Cover
  parameter Modelica.Blocks.Sources.RealExpression w (y= 6e-3) "width" annotation(
    Placement(visible = true, transformation(origin = {-86, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Modelica.Blocks.Sources.RealExpression s (y= 15) "m2 total surface" annotation(
    Placement(visible = true, transformation(origin = {-54, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Modelica.Blocks.Sources.RealExpression l (y= 0.76)  "W/m.K - lambda" annotation(
    Placement(visible = true, transformation(origin = {-18, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Modelica.Blocks.Sources.RealExpression rho (y= 2600) "kg/m3 density" annotation(
    Placement(visible = true, transformation(origin = {-24, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Modelica.Blocks.Sources.RealExpression c_p (y= 840) "specific thermal capacity" annotation(
    Placement(visible = true, transformation(origin = {-24, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  final constant Real pi = Modelica.Constants.pi;
  parameter Integer N = 6;
  parameter Real surfacesPitch[N] = {0,0,0,0,0,0};
  parameter Real surfacesNorth[N] = {0,0,0,0,0,0};
  
  Real elevation;
  Real azimuth;
  
  Modelica.SIunits.RadiantEnergyFluenceRate I "surface radiation";
  Modelica.SIunits.RadiantEnergyFluenceRate Ip "positive surface radiation";

  gewXhouse.Connectors.Interfaces.HeatFluxInput  I_glob annotation(
    Placement(visible = true, transformation(extent = {{-140, -100}, {-100, -60}}, rotation = 0), iconTransformation(origin = {-40, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput sunPos[2] "elevation, azimuth" annotation(
    Placement(visible = true, transformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-90, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  gewXhouse.Connectors.Interfaces.HeatFluxOutput I_Intern annotation(
    Placement(visible = true, transformation(origin = {120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-40, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort "Heat port for sensible heat input" annotation(
    Placement(visible = true,transformation(extent = {{-10, -20}, {10, 0}}, rotation = 0), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a environment annotation(
    Placement(visible = true, transformation(origin = {90, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  gewXhouse.Models.ThermalConductor thermalConductor annotation(
    Placement(visible = true, transformation(origin = {50, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product product annotation(
    Placement(visible = true, transformation(origin = {-18, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  gewXhouse.Models.HeatCapacitor heatCapacitor annotation(
    Placement(visible = true, transformation(origin = {20, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Math.Product product1 annotation(
    Placement(visible = true, transformation(origin = {26, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Division division annotation(
    Placement(visible = true, transformation(origin = {-12, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  if cardinality(I_glob) == 0 then
    I_glob = 1000;
  end if;
  if cardinality(sunPos[1]) == 0 then
    elevation = 0;
  else
    elevation = sunPos[1];
  end if;
  if cardinality(sunPos[2]) == 0 then
    azimuth = 0;
  else
    azimuth  = sunPos[2];
  end if;
  connect(division.u2, w.y) annotation(
    Line(points = {{-24, -68}, {-68, -68}, {-68, 78}, {-75, 78}}, color = {0, 0, 127}));
  connect(product.u1, w.y) annotation(
    Line(points = {{-30, 78}, {-75, 78}}, color = {0, 0, 127}));
  connect(heatCapacitor.c_p, c_p.y) annotation(
    Line(points = {{4, 36}, {-10, 36}, {-10, 44}, {-13, 44}}, color = {0, 0, 127}));
  connect(heatCapacitor.rho, rho.y) annotation(
    Line(points = {{4, 28}, {-13, 28}}, color = {0, 0, 127}));
  connect(thermalConductor.port_b, environment) annotation(
    Line(points = {{60, -10}, {90, -10}}, color = {191, 0, 0}));
  connect(product1.y, thermalConductor.G) annotation(
    Line(points = {{38, -56}, {50, -56}, {50, -18}, {50, -18}}, color = {0, 0, 127}));
  connect(product1.u2, division.y) annotation(
    Line(points = {{14, -62}, {0, -62}}, color = {0, 0, 127}));
  connect(product1.u1, l.y) annotation(
    Line(points = {{14, -50}, {4, -50}, {4, -34}, {-18, -34}}, color = {0, 0, 127}));
  connect(division.u1, s.y) annotation(
    Line(points = {{-24, -56}, {-40, -56}, {-40, 66}, {-54, 66}}, color = {0, 0, 127}));
  connect(heatCapacitor.port, thermalConductor.port_a) annotation(
    Line(points = {{20, 20}, {20, 6}, {20, 6}, {20, -10}, {30, -10}, {30, -10}, {40, -10}}, color = {191, 0, 0}));
  connect(heatCapacitor.volume, product.y) annotation(
    Line(points = {{4, 44}, {-2, 44}, {-2, 72}, {-6, 72}, {-6, 72}}, color = {0, 0, 127}));
  connect(product.u2, s.y) annotation(
    Line(points = {{-30, 66}, {-50, 66}, {-50, 66}, {-54, 66}}, color = {0, 0, 127}));
  connect(heatPort, thermalConductor.port_a) annotation(
    Line(points = {{0, -10}, {40, -10}, {40, -10}, {40, -10}}, color = {191, 0, 0}));
  
algorithm
  for i in 1:N loop
    I := I_glob * (cos(surfacesPitch[i]) + cos(abs(azimuth - surfacesNorth[i])) * sin(surfacesPitch[i]) * tan(elevation));
    Ip := Ip + (if I < 0 or elevation < 0 or (abs(surfacesPitch[i]-elevation)) > 41 then 0 else I);
  end for;
  I_Intern := Ip;
  
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics),
    Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(rotation = 90, lineColor = {0, 117, 227}, fillColor = {170, 213, 255}, fillPattern = FillPattern.Backward, extent = {{-20, 80}, {20, -80}}), Text(origin = {-60, 0}, extent = {{-50, -34}, {170, -94}}, textString = "%name")}),
  experiment(StartTime = 0, StopTime = 86400, Tolerance = 1e-06, Interval = 86.5731));
end Cover;
