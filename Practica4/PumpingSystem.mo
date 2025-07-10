package PumpingSystem
  model SliderCrank
    DSFLib.Mechanical.Translational.Units.Position s;
    parameter Real l = 0.1, r = 0.01, s0 = -r - l;
    DSFLib.Mechanical.Rotational.Units.Angle th;
    DSFLib.Mechanical.Rotational.Interfaces.Flange flangeR annotation(
      Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    DSFLib.Mechanical.Translational.Interfaces.Flange flangeT annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
  equation
    th = flangeR.phi;
    s + s0 = flangeT.s;
    s = r*cos(th) + l*sqrt(1 - (r*sin(th)/l)^2);
    flangeR.tau*(s - r*cos(th)) = flangeT.f*(r*s*sin(th));
    annotation(
      Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {-4, -154}, textColor = {0, 0, 255}, extent = {{-150, 85}, {150, 45}}, textString = "sliderCrank"), Ellipse(lineColor = {0, 0, 255}, fillColor = {200, 200, 255}, fillPattern = FillPattern.Solid, extent = {{-60, 60}, {60, -60}}), Line(points = {{30, 0}, {100, 0}}, color = {0, 0, 255})}));
  end SliderCrank;

  model ModeloPrueba1
    DSFLib.Mechanical.Rotational.Components.Fixed fixed annotation(
      Placement(transformation(origin = {-82, -2}, extent = {{-12, -12}, {12, 12}}, rotation = -90)));
    DSFLib.Mechanical.Rotational.Components.ConstTorque constTorque annotation(
      Placement(transformation(origin = {-58, -2}, extent = {{-14, -14}, {14, 14}})));
    DSFLib.Mechanical.Rotational.Components.Inertia inertia annotation(
      Placement(transformation(origin = {-14, 56}, extent = {{-12, -12}, {12, 12}})));
    SliderCrank sliderCrank annotation(
      Placement(transformation(origin = {-8, -2}, extent = {{-12, -12}, {12, 12}})));
    DSFLib.Mechanical.Translational.Components.Mass mass annotation(
      Placement(transformation(origin = {26, -2}, extent = {{-12, -12}, {12, 12}})));
    DSFLib.Mechanical.Translational.Components.Damper damper annotation(
      Placement(transformation(origin = {58, -2}, extent = {{-12, -12}, {12, 12}})));
    DSFLib.Mechanical.Translational.Components.Fixed fixed1 annotation(
      Placement(transformation(origin = {82, -2}, extent = {{-12, -12}, {12, 12}}, rotation = 90)));
  equation
    connect(fixed.flange, constTorque.flange_a) annotation(
      Line(points = {{-82, -2}, {-72, -2}}));
    connect(constTorque.flange_b, sliderCrank.flangeR) annotation(
      Line(points = {{-44, -2}, {-8, -2}}));
    connect(sliderCrank.flangeT, mass.flange) annotation(
      Line(points = {{4, -2}, {26, -2}}));
    connect(mass.flange, damper.flange_a) annotation(
      Line(points = {{26, -2}, {46, -2}}));
    connect(damper.flange_b, fixed1.flange) annotation(
      Line(points = {{70, -2}, {82, -2}}));
    connect(inertia.flange, sliderCrank.flangeR) annotation(
      Line(points = {{-26, 56}, {-32, 56}, {-32, -2}, {-8, -2}}));
  end ModeloPrueba1;

  model OneWayValve
    extends DSFLib.Hydraulics.Interfaces.TwoPort;
    parameter Real Ron = 1e-6, Roff = 1e12;
  equation
    p = if q > 0 then Ron * q else Roff * q;
    annotation(
      Icon(graphics = {Polygon(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 50}, {100, -50}, {100, 50}, {0, 0}, {-100, -50}, {-100, 50}}), Text(origin = {0, 14}, textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name"), Text(origin = {2, -18}, extent = {{-144, -34}, {144, -68}}, textString = "RH=%RH")}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
  end OneWayValve;

  model ModeloPrueba2
    DSFLib.Hydraulics.Components.Tank tank annotation(
      Placement(transformation(origin = {0, 72}, extent = {{-12, -12}, {12, 12}})));
    DSFLib.Hydraulics.Components.Valve valve annotation(
      Placement(transformation(origin = {0, 28}, extent = {{-12, -12}, {12, 12}}, rotation = -90)));
    DSFLib.Hydraulics.Components.ConstPress constPress annotation(
      Placement(transformation(origin = {-84, -50}, extent = {{-12, -12}, {12, 12}})));
    OneWayValve oneWayValve annotation(
      Placement(transformation(origin = {-40, -10}, extent = {{-12, -12}, {12, 12}})));
    OneWayValve oneWayValve1 annotation(
      Placement(transformation(origin = {41, -11}, extent = {{-11, -11}, {11, 11}})));
  equation
    connect(tank.fluidPort, valve.fluidPort_b) annotation(
      Line(points = {{0, 60}, {0, 40}}));
  connect(valve.fluidPort_a, oneWayValve1.fluidPort_b) annotation(
      Line(points = {{0, 16}, {0, -10}, {30, -10}}));
  connect(oneWayValve.fluidPort_a, oneWayValve1.fluidPort_b) annotation(
      Line(points = {{-28, -10}, {30, -10}}));
  connect(constPress.fluidPort, oneWayValve.fluidPort_b) annotation(
      Line(points = {{-72, -50}, {-64, -50}, {-64, -10}, {-52, -10}}));
  connect(constPress.fluidPort, oneWayValve1.fluidPort_a) annotation(
      Line(points = {{-72, -50}, {70, -50}, {70, -10}, {52, -10}}));
  end ModeloPrueba2;
end PumpingSystem;