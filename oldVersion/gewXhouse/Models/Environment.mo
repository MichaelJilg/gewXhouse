within gewXhouse.Models;

model Environment


  Modelica.Blocks.Sources.CombiTimeTable temperature( extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint,fileName = "C:/Users/Gunterson/Documents/GitHub/gewXhouse/gewXhouse/Resources/temp.txt", offset = {0}, smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments, startTime = 1, table = fill(0.0, 0, 2), tableName = "temp", tableOnFile = true, timeScale = 60, verboseRead = true)  annotation(
    Placement(visible = true, transformation(origin = {-50, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  gewXhouse.Connectors.environment environment annotation(
    Placement(visible = true, transformation(origin = {40, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {80, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1 annotation(
    Placement(visible = true, transformation(origin = {-8, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin1 annotation(
    Placement(visible = true, transformation(origin = {26, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation

  connect(fromKelvin1.Celsius, environment.Tout) annotation(
    Line(points = {{37, 70}, {40, 70}, {40, 34}}, color = {0, 0, 127}));
  connect(fromKelvin1.Kelvin, toKelvin1.Kelvin) annotation(
    Line(points = {{14, 70}, {4, 70}}, color = {0, 0, 127}));
  connect(toKelvin1.Celsius, temperature.y[1]) annotation(
    Line(points = {{-20, 70}, {-38, 70}}, color = {0, 0, 127}));
  annotation(
      Icon(graphics = {Line(origin = {-0.23, -84.3}, points = {{-98.4671, -1.98624}, {-72.4671, 2.01376}, {-44.4671, -5.98624}, {7.53292, 4.01376}, {43.5329, -3.98624}, {69.5329, 2.01376}, {97.5329, -3.98624}}, color = {85, 85, 0}, thickness = 2, smooth = Smooth.Bezier), Line(origin = {49.1, 88.31}, points = {{-39.934, -0.80248}, {-21.934, 5.19752}, {0.0659595, -0.802482}, {18.066, 3.19752}, {40.066, -2.80248}}, color = {85, 85, 255}, thickness = 1, smooth = Smooth.Bezier), Line(origin = {49.19, 78.17}, points = {{-39.934, -0.80248}, {-21.934, 5.19752}, {0.0659595, -0.802482}, {18.066, 3.19752}, {40.066, -2.80248}}, color = {85, 85, 255}, thickness = 1, smooth = Smooth.Bezier), Line(origin = {-0.2, 4.2}, points = {{-59.9906, -57.1231}, {-79.9906, -41.1231}, {-79.9906, 38.8769}, {-59.9906, 58.8769}, {60.0094, 58.8769}, {80.0094, 38.8769}, {80.0094, -41.1231}, {60.0094, -61.1231}, {-37.9906, -61.1231}}, color = {255, 85, 255}, thickness = 1, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5, smooth = Smooth.Bezier)}, coordinateSystem(initialScale = 0.1)));

end Environment;