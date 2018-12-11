within gewXhouse.Models;

model Ventilation
  parameter Modelica.Blocks.Sources.RealExpression v(y= 30) "m3 house volume" annotation(
    Placement(visible = true, transformation(origin = {-80, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Modelica.Blocks.Sources.RealExpression nl(y= 0.01) "1/s ventilation rate" annotation(
    Placement(visible = true, transformation(origin = {-80, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Modelica.Blocks.Sources.RealExpression dl(y=1.2041) "kg/m3 desity" annotation(
    Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Modelica.Blocks.Sources.RealExpression c_p(y= 1005) "J/kg.K air" annotation(
    Placement(visible = true, transformation(origin = {-80, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Modelica.Blocks.Sources.BooleanExpression V_on_off(y=true) "true: Ventilation On / false:Ventilation Off" annotation(
    Placement(visible = true, transformation(origin = {-80, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort "Heat port for sensible heat input" annotation(
    Placement(visible = true,transformation(extent = {{-42, 10}, {-22, 30}}, rotation = 0), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a environment annotation(
    Placement(visible = true, transformation(origin = {62, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  gewXhouse.Models.ThermalConductor thermalConductor annotation(
    Placement(visible = true, transformation(origin = {20, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.MultiProduct multiProduct(nu = 4)  annotation(
    Placement(visible = true, transformation(origin = {-2, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch1 annotation(
    Placement(visible = true, transformation(origin = {-38, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Modelica.Blocks.Sources.RealExpression ventilationOffRate(y = 0.00) annotation(
    Placement(visible = true, transformation(origin = {-80, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(ventilationOffRate.y, switch1.u3) annotation(
    Line(points = {{-69, -80}, {-59, -80}, {-59, -68}, {-50, -68}}, color = {0, 0, 127}));
  connect(V_on_off.y, switch1.u2) annotation(
    Line(points = {{-69, -60}, {-50, -60}}, color = {255, 0, 255}));
  connect(nl.y, switch1.u1) annotation(
    Line(points = {{-69, -40}, {-59, -40}, {-59, -52}, {-50, -52}}, color = {0, 0, 127}));
  connect(switch1.y, multiProduct.u[4]) annotation(
    Line(points = {{-27, -60}, {-20, -60}, {-20, -20}, {-12, -20}}, color = {0, 0, 127}));
  connect(heatPort, thermalConductor.port_a) annotation(
    Line(points = {{-32, 20}, {10, 20}}, color = {191, 0, 0}));
  connect(thermalConductor.port_b, environment) annotation(
    Line(points = {{30, 20}, {62, 20}}, color = {191, 0, 0}));
  connect(multiProduct.y, thermalConductor.G) annotation(
    Line(points = {{9.7, -20}, {20, -20}, {20, 12}}, color = {0, 0, 127}));
  connect(v.y, multiProduct.u[3]) annotation(
    Line(points = {{-69, -20}, {-12, -20}}, color = {0, 0, 127}));
  connect(c_p.y, multiProduct.u[1]) annotation(
    Line(points = {{-69, 20}, {-64.5, 20}, {-64.5, 20}, {-60, 20}, {-60, -20}, {-12, -20}}, color = {0, 0, 127}));
  connect(dl.y, multiProduct.u[2]) annotation(
    Line(points = {{-69, 0}, {-60, 0}, {-60, -20}, {-12, -20}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics),
    Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(rotation = 90, lineColor = {170, 170, 255}, fillColor = {170, 85, 255}, fillPattern = FillPattern.CrossDiag, extent = {{-20, 80}, {20, -80}}), Text(origin = {-60, 0}, extent = {{-50, -34}, {170, -94}}, textString = "%name")}),
  experiment(StartTime = 0, StopTime = 86400, Tolerance = 1e-06, Interval = 86.5731),
  Documentation(info = "<html><head></head><body><p><b>VENTILATION MODEL</b></p><p>The ventilation model is a component in the greenhouse, which enables the user to simluate a ventilation (without air conditioning) in the greenhouse. It is made up of a thermal conductor, which calculates the inner temperature of the greenhouse. The user has the possiblity to enter different ventilation rate. This parameter can be changed in the <a href=\"modelica://gewXhouse.Models.House\" style=\"font-size: 12px;\">house</a> model.&nbsp;</p>
<p>Overview of ventilation input/output&nbsp;</p>
<table style=\"height: 200px; width: 574px; border-color: black; margin-left: auto; margin-right: auto;\" border=\"1\">
<tbody>
<tr style=\"height: 39px;\">
<td style=\"width: 79.1333px; text-align: center; height: 39px;\">&nbsp;</td>
<td style=\"width: 198.917px; height: 39px; text-align: center;\"><strong>Variable</strong></td>
<td style=\"width: 271.95px; height: 39px; text-align: center;\"><strong>Description</strong></td>
</tr>
<tr style=\"height: 69px;\">
<td style=\"width: 79.1333px; text-align: center; height: 78.7167px;\"><img src=\"modelica://gewXhouse/Resources/Input.jpg\" alt=\"Smiley face\" width=\"45\" height=\"42\"><strong>Input</strong></td>
<td style=\"width: 198.917px; height: 69px; text-align: center;\">n</td>
<td style=\"width: 271.95px; height: 69px; text-align: center;\">ventilation rate [1/s]</td>
</tr>





<tr style=\"height: 33.7167px;\">
<td style=\"width: 79.1333px; text-align: center; height: 78.7167px;\"><img src=\"modelica://gewXhouse/Resources/Output.jpg\" alt=\"Smiley face\" width=\"42\" height=\"42\"><strong>Output</strong></td>
<td style=\"width: 198.917px; height: 33.7167px;\">
<p style=\"text-align: center;\">heat Port</p>
</td>
<td style=\"width: 271.95px; height: 33.7167px; text-align: center;\">The heat port transfers the Q_flow combined with the air from outside.</td>
</tr>
</tbody>
</table>
<p>&nbsp;</p></body></html>"));
end Ventilation;