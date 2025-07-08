package PumpingSystem
  model SliderCrank
    DSFLib.Mechanical.Translational.Units.Position s;
    parameter Real l = 0.1, r = 0.01, s0 = - r - l;
    DSFLib.Mechanical.Rotational.Units.Angle th;
    DSFLib.Mechanical.Rotational.Units.Torque tau;
    DSFLib.Mechanical.Translational.Units.Force f;
    DSFLib.Mechanical.Rotational.Interfaces.Flange flangerot annotation(
      Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    DSFLib.Mechanical.Translational.Interfaces.Flange flangetra annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
  equation
    th = flangerot.phi;
    tau = flangerot.tau;
    f = flangetra.f;
    s + s0 = flangetra.s;
    s = r*cos(th) + l*sqrt(1 - (r*sin(th)/l)^2);
    tau*(s - r*cos(th)) = f*(r*s*sin(th));
    annotation(
      Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {-4, -154}, textColor = {0, 0, 255}, extent = {{-150, 85}, {150, 45}}, textString = "sliderCrank"), Ellipse(lineColor = {0, 0, 255}, fillColor = {200, 200, 255}, fillPattern = FillPattern.Solid, extent = {{-60, 60}, {60, -60}}), Line(points = {{30, 0}, {100, 0}}, color = {0, 0, 255})}));
  end SliderCrank;

  model ModeloPrueba
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
  connect(constTorque.flange_b, sliderCrank.flangerot) annotation(
      Line(points = {{-44, -2}, {-8, -2}}));
  connect(sliderCrank.flangetra, mass.flange) annotation(
      Line(points = {{4, -2}, {26, -2}}));
  connect(mass.flange, damper.flange_a) annotation(
      Line(points = {{26, -2}, {46, -2}}));
  connect(damper.flange_b, fixed1.flange) annotation(
      Line(points = {{70, -2}, {82, -2}}));
  connect(inertia.flange, sliderCrank.flangerot) annotation(
      Line(points = {{-26, 56}, {-32, 56}, {-32, -2}, {-8, -2}}));
  end ModeloPrueba;
end PumpingSystem;