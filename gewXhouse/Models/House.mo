within gewXhouse.Models;

model House
  parameter Real long = 8.7172797 "° longitude" annotation(
    Dialog(group = "House position", tab = "Global"));
  parameter Real lat = 48.8785888 "° latitude" annotation(
    Dialog(group = "House position", tab = "Global"));
  parameter Modelica.SIunits.Length length = 3 "Length of the house" annotation(
    Dialog(tab = "Dimensions"));
  parameter Modelica.SIunits.Length width = 3 "Width of the house" annotation(
    Dialog(tab = "Dimensions"));
  parameter Modelica.SIunits.Length height = 2 "Height of the house" annotation(
    Dialog(tab = "Dimensions"));
  parameter Modelica.SIunits.Angle pitch = 0.523599 "Roof pitch of the house" annotation(
    Dialog(tab = "Dimensions"));
  parameter Modelica.SIunits.Angle north = 0 "Orientation of the house 'north direction'" annotation(
    Dialog(tab = "Dimensions"));
  parameter Real cover_rho = 2600 "kg/m3 density" annotation(
    Dialog(group = "Parameter", tab = "Cover"));
  parameter Real cover_c_p = 840 "J/Kg.K specific thermal capacity" annotation(
    Dialog(group = "Parameter", tab = "Cover"));
  parameter Real G = 0.95 annotation(
    Dialog(group = "Parameter", tab = "Cover"));
  parameter Real cover_w_cover = 18e-3 "m total cover width (glass + gas)" annotation(
    Dialog(group = "Glass", tab = "Cover"));
  parameter Real cover_w_gas = 12e-3 "m gas gap" annotation(
    Dialog(group = "Glass", tab = "Cover"));
  parameter Real cover_l_glass = 760e-3 "W/m.K lambda" annotation(
    Dialog(group = "Glass", tab = "Cover"));
  parameter Real cover_l_gas = 26e-3 "W/m.K lambda (Krypton = 9.5e-3, Xenon = 5.5e-3)" annotation(
    Dialog(group = "Glass", tab = "Cover"));
  parameter Real floor_w = 0.5 "m floor depth" annotation(
    Dialog(group = "Parameter", tab = "Floor"));
  parameter Real floor_c = 20 "W/m2.K heat transfer coefficient" annotation(
    Dialog(group = "Parameter", tab = "Floor"));
  parameter Real floor_c1 = 1.26 "W/m.K heat conductivity coefficient (Humus: 1.26)" annotation(
    Dialog(group = "Parameter", tab = "Floor"));
  parameter Real floor_rho = 1014.42 "kg/m3 density (Humus: 1014.42" annotation(
    Dialog(group = "Parameter", tab = "Floor"));
  parameter Real floor_c_p = 1000 "J/Kg.K specific thermal capacity" annotation(
    Dialog(group = "Parameter", tab = "Floor"));
  parameter Real floor_r_v = 4 "1 roughness value" annotation(
    Dialog(group = "Parameter", tab = "Floor"));
  parameter Real air_rho = 1.2 "kg/m3 density (Humus: 1014.42" annotation(
    Dialog(group = "Parameter", tab = "Air"));
  parameter Real air_c_p = 1005 "J/Kg.K specific thermal capacity" annotation(
    Dialog(group = "Parameter", tab = "Air"));
  parameter Real venti_nl = 0.01 "1/s ventilation rate" annotation(
    Dialog(group = "Parameter", tab = "Ventilation"));
  //  parameter Real venti_dl = 1.2041 "kg/m3 desity" annotation(
  //    Dialog(group = "Parameter", tab = "Ventilation"));
  //  parameter Real venti_c_p = 1005 "J/Kg.K specific thermal capacity" annotation(
  //    Dialog(group = "Parameter", tab = "Ventilation"));
  parameter Boolean venti_on_off = false "Ventilation Switch On/Off" annotation(
    Dialog(group = "Parameter", tab = "Ventilation"));
  constant Integer N = 6 "number of surfaces";
  parameter Real sPitch[N] = {90, 90, 90, 90, pitch, pitch} "Surface angles" annotation(
    Dialog(tab = "Dimensions"));
  parameter Real sNorth[N] = {0, 90, 180, 270, 90, 270} "Surface orientalieon" annotation(
    Dialog(tab = "Dimensions"));
  Real sA[N];
  Real sTotal "total surface";
  Real sAFloor "floor area";
  Real vTotal "volume house";
  Real sADormer "Dormer house area";
  Real cTotal "house circumference";
  //Models.Surface floorSurface(pitch = 0, north = 0) "Ground floor";
  //Surface1 surface "north, east, south, west, east roof, west roof";
  Modelica.Blocks.Interfaces.RealInput I annotation(
    Placement(visible = true, transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput pos[2] = {long, lat} annotation(
    Placement(visible = true, transformation(origin = {-120, -20}, extent = {{20, -20}, {-20, 20}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput SunPos[2] annotation(
    Placement(visible = true, transformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Celsius.TemperatureSensor temperatureSensor annotation(
    Placement(visible = true, transformation(origin = {70, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput t_inside annotation(
    Placement(visible = true, transformation(origin = {120, 8}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a out annotation(
    Placement(visible = true, transformation(origin = {10, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_b annotation(
    Placement(visible = true, transformation(origin = {-28, -50}, extent = {{-10, 10}, {10, -10}}, rotation = 0), iconTransformation(origin = {110, -20}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  gewXhouse.Models.Floor floor(s.y = sAFloor, w.y = floor_w, c.y = floor_c, rho.y = floor_rho, c_p.y = floor_c_p, u.y = cTotal, c1.y = floor_c1, r_v.y = floor_r_v) annotation(
    Placement(visible = true, transformation(origin = {-20, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  gewXhouse.Models.Cover cover(c_p.y = cover_c_p, l_glass = cover_l_glass, l_gas = cover_l_gas, rho.y = cover_rho, s.y = sTotal, w_cover = cover_w_cover, w_gas = cover_w_gas, G.y = G) annotation(
    Placement(visible = true, transformation(origin = {-20, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  gewXhouse.Models.Ventilation ventilation(v.y = vTotal, nl.y = venti_nl, V_on_off.y = venti_on_off) annotation(
    Placement(visible = true, transformation(origin = {40, 40}, extent = {{20, -20}, {-20, 20}}, rotation = 0)));
  /* dl.y=venti_dl, c_p.y=venti_c_p,*/
  gewXhouse.Models.Air air(v.y = vTotal, rho.y = air_rho, c_p.y = air_c_p) annotation(
    Placement(visible = true, transformation(origin = {40, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(cover.I_Intern, floor.I) annotation(
    Line(points = {{-28, 34}, {-28, -14}}, color = {0, 0, 127}));
  connect(port_b, floor.environment) annotation(
    Line(points = {{-28, -50}, {-28, -26}}, color = {191, 0, 0}));
  connect(air.port, floor.heatPort) annotation(
    Line(points = {{40, -10}, {40, 8}, {-20, 8}, {-20, -20}}, color = {191, 0, 0}));
  connect(cover.heatPort, air.port) annotation(
    Line(points = {{-20, 40}, {-20, 8}, {40, 8}, {40, -10}}, color = {191, 0, 0}));
  connect(ventilation.heatPort, air.port) annotation(
    Line(points = {{40, 40}, {40, -10}}, color = {191, 0, 0}));
  connect(temperatureSensor.port, air.port) annotation(
    Line(points = {{60, 8}, {40, 8}, {40, -10}}, color = {191, 0, 0}));
  connect(ventilation.environment, out) annotation(
    Line(points = {{26, 40}, {10, 40}, {10, 70}}, color = {191, 0, 0}));
  connect(cover.environment, out) annotation(
    Line(points = {{-6, 40}, {10, 40}, {10, 70}}, color = {191, 0, 0}));
  connect(temperatureSensor.T, t_inside) annotation(
    Line(points = {{80, 8}, {120, 8}}, color = {0, 0, 127}));
  connect(cover.sunPos, SunPos) annotation(
    Line(points = {{-38, 40}, {-120, 40}}, color = {0, 0, 127}, thickness = 0.5));
  connect(I, cover.I_glob) annotation(
    Line(points = {{-120, 80}, {-28, 80}, {-28, 46}, {-28, 46}}, color = {0, 0, 127}));
  sAFloor = length * width;
  sADormer = length * length * tan(pitch) / 4;
  sA[1] = length * height + sADormer;
  sA[2] = width * height;
  sA[3] = sA[1];
  sA[4] = sA[2];
  sA[5] = length / 2 / cos(pitch) * width;
  sA[6] = sA[5];
  sTotal = (sA[1] + sA[2] + sA[5]) * 2;
  vTotal = sA[1] * width;
  cTotal = (length + width) * 2;
  annotation(
    preferredView="default",
    defaultComponentName = "house",
    Icon(graphics = {Rectangle(fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {0, -60}, lineColor = {190, 0, 0}, extent = {{-180, -28}, {180, -60}}, textString = "%name"), Text(origin = {-33, -63}, extent = {{1, -15}, {-1, 15}}, textString = "L", fontSize = 15), Text(origin = {47, -49}, extent = {{1, -15}, {-1, 15}}, textString = "W", fontSize = 15), Text(origin = {69, -11}, extent = {{1, -15}, {-1, 15}}, textString = "H", fontSize = 15), Line(points = {{20, 0}, {-80, 0}}, color = {135, 135, 135}, pattern = LinePattern.Dash), Ellipse(origin = {20, 0}, lineColor = {135, 135, 135}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-40, 40}, {40, -40}}, startAngle = 180, endAngle = 135), Line(points = {{-80, -80}, {20, -80}, {80, -50}, {80, 30}}, color = {255, 0, 0}, thickness = 0.5), Line(points = {{-80, -80}, {-80, 0}, {-30, 50}, {30, 80}, {80, 30}, {20, 0}}, color = {135, 135, 135}), Line(points = {{-30, 50}, {20, 0}, {20, -80}}, color = {135, 135, 135}), Text(origin = {-31, 21}, extent = {{1, -15}, {-1, 15}}, textString = "P", fontSize = 15), Line(origin = {-0.33, 0}, points = {{0, 80}, {-60, 50}}, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Text(origin = {-69, 65}, extent = {{1, -15}, {-1, 15}}, textString = "N", fontSize = 15), Ellipse(origin = {0, 80}, lineColor = {135, 135, 135}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-40, 40}, {40, -40}}, startAngle = 180, endAngle = 206), Line(origin = {0, -0.33}, points = {{0, 80}, {-80, 80}}, color = {255, 0, 0}, thickness = 0.5)}, coordinateSystem(initialScale = 0.1)),
    experiment(StartTime = 0, StopTime = 86400, Tolerance = 1e-06, Interval = 86.5731),
    Documentation(info = "<html><head></head><body><p><b>HOUSE MODEL</b></p><p><!--StartFragment--><span style=\"font-size: 12px;\">The house model will calculate its inner temperature curve depending on the transfered values of the sun model. The house consists of a network of different components which interakt with one another e.g.:</span><!--EndFragment--></p><p></p><ul><li><a href=\"modelica://gewXhouse.Models.Cover\">cover</a></li><li><a href=\"modelica://gewXhouse.Models.Ventilation\">ventilation</a></li><li><a href=\"modelica://gewXhouse.Models.Floor\" style=\"font-size: 12px;\">floor</a></li><li><a href=\"modelica://gewXhouse.Models.Air\" style=\"font-size: 12px;\">air</a></li></ul><div><div>Overview of house input/output&nbsp;</div><div><br><table style=\"height: 200px; width: 574px; border-color: black; margin-left: auto; margin-right: auto;\" border=\"1\">
<tbody>
<tr style=\"height: 39px;\">
<td style=\"width: 79.1333px; text-align: center; height: 39px;\">&nbsp;</td>
<td style=\"width: 198.917px; height: 39px; text-align: center;\"><strong>Variable</strong></td>
<td style=\"width: 271.95px; height: 39px; text-align: center;\"><strong>Description</strong></td>
</tr>
<tr style=\"height: 69px;\">
<td style=\"width: 79.1333px; text-align: center; height: 69px;\" rowspan=\"2\"><img src=\"modelica://gewXhouse/Resources/Input.jpg\" alt=\"Smiley face\" width=\"42\" height=\"42\">
<p><strong>Input</strong></p><strong><br></strong></td>
<td style=\"width: 198.917px; height: 69px; text-align: center;\">I</td>
<td style=\"width: 271.95px; height: 69px; text-align: center;\">Radiation from the sun will be transfered to other components in the greenhouse with the correct physical calculation</td>
</tr>
<tr style=\"height: 45px;\">
<td style=\"width: 198.917px; height: 45px; text-align: center;\">sunPos[2]</td>
<td style=\"width: 271.95px; height: 45px;\">The sunPos[] with azimuth and elevation provides the house model to calculate solar radiation from from different angles and a value of the solar radioation over the day</td>
</tr>
<tr style=\"height: 33.7167px;\">
<td style=\"width: 79.1333px; text-align: center; height: 78.7167px;\" rowspan=\"2\"><img src=\"modelica://gewXhouse/Resources/Output.jpg\" alt=\"Smiley face\" width=\"42\" height=\"42\"><strong>Output</strong></td>
<td style=\"width: 198.917px; height: 33.7167px;\">
<p style=\"text-align: center;\">t_inside</p>
</td>
<td style=\"width: 271.95px; height: 33.7167px; text-align: center;\">This value provides the user to see the simulated temperature in the greenhouse</td>
</tr>
<tr style=\"height: 33.7167px;\">
<td style=\"width: 198.917px; height: 33.7167px;\">
<p style=\"text-align: center;\">posHouse[2]</p>
</td>
<td style=\"width: 271.95px; height: 33.7167px; text-align: center;\">The house model outputs the lateral and longitudinal coordinates to the sun</td>
</tr>
</tbody>
</table>
<p>&nbsp;</p></div></div></body></html>"));
end House;
