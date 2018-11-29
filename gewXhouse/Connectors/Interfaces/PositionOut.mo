within gewXhouse.Connectors.Interfaces;

  connector PositionOut
  Modelica.Blocks.Interfaces.RealOutput lat "latitude" annotation(
    Placement(visible = true, transformation(origin = {30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput long "longitude" annotation(
    Placement(visible = true, transformation(origin = {30, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    annotation(
      Icon(graphics = {
      Rectangle(lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}),
      Ellipse(lineColor = {0, 85, 0}, fillColor = {0, 170, 0}, fillPattern = FillPattern.Solid, extent = {{-20, 20}, {20, -20}}, endAngle = 360) 
      }, 
      coordinateSystem(initialScale = 0.1)));
  end PositionOut;