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
    DSFLib.Mechanical.Rotational.Components.Inertia inertia(J = 1) annotation(
      Placement(transformation(origin = {-14, 56}, extent = {{-12, -12}, {12, 12}})));
    SliderCrank sliderCrank annotation(
      Placement(transformation(origin = {-8, -2}, extent = {{-12, -12}, {12, 12}})));
    DSFLib.Mechanical.Translational.Components.Mass mass annotation(
      Placement(transformation(origin = {26, -2}, extent = {{-12, -12}, {12, 12}})));
    DSFLib.Mechanical.Translational.Components.Damper damper(b = 1) annotation(
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
    p = if q > 0 then Ron*q else Roff*q;
    annotation(
      Icon(graphics = {Polygon(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 50}, {100, -50}, {100, 50}, {0, 0}, {-100, -50}, {-100, 50}}), Text(origin = {0, 14}, textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name"), Text(origin = {2, -18}, extent = {{-144, -34}, {144, -68}}, textString = "RH=%RH")}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
  end OneWayValve;

  model ModeloPrueba2
    DSFLib.Hydraulics.Components.Tank tank(v(start = 1)) annotation(
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
    connect(constPress.fluidPort, oneWayValve.fluidPort_b) annotation(
      Line(points = {{-72, -50}, {-64, -50}, {-64, -10}, {-52, -10}}));
    connect(constPress.fluidPort, oneWayValve1.fluidPort_a) annotation(
      Line(points = {{-72, -50}, {70, -50}, {70, -10}, {52, -10}}));
    connect(oneWayValve.fluidPort_a, valve.fluidPort_a) annotation(
      Line(points = {{-28, -10}, {0, -10}, {0, 16}}));
  end ModeloPrueba2;

  model BombaHidraulica
    DSFLib.Hydraulics.Interfaces.FluidPort fluidPort_a annotation(
      Placement(transformation(origin = {90, -1}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {86, -21}, extent = {{-16, -16}, {16, 16}})));
    DSFLib.Mechanical.Rotational.Interfaces.Flange flange annotation(
      Placement(transformation(origin = {-1, 90}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-1, 86}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
    DSFLib.Hydraulics.Interfaces.FluidPort fluidPort_b annotation(
      Placement(transformation(origin = {-92, 1}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-86, -23}, extent = {{-16, -16}, {16, 16}})));
  SliderCrank sliderCrank annotation(
      Placement(transformation(origin = {0, 50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OneWayValve oneWayValve1 annotation(
      Placement(transformation(origin = {-44, 28}, extent = {{-10, -10}, {10, 10}})));
  OneWayValve oneWayValve2 annotation(
      Placement(transformation(origin = {38, 2}, extent = {{-10, -10}, {10, 10}})));
  DSFLib.Mechanical.Translational.Components.Fixed fixed annotation(
      Placement(transformation(origin = {0, -20}, extent = {{-10, -10}, {10, 10}})));
  DSFLib.MultiDomain.HydroMechanical.Components.PistonCylinder pistonCylinder(A = 0.01)  annotation(
      Placement(transformation(origin = {0, 6}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
    equation
    connect(sliderCrank.flangeR, flange) annotation(
      Line(points = {{0, 50}, {0, 90}}));
    connect(oneWayValve1.fluidPort_b, fluidPort_b) annotation(
      Line(points = {{-54, 28}, {-92, 28}, {-92, 2}}));
    connect(oneWayValve2.fluidPort_a, fluidPort_a) annotation(
      Line(points = {{48, 2}, {90, 2}, {90, 0}}));
  connect(pistonCylinder.flange_b, sliderCrank.flangeT) annotation(
      Line(points = {{0, 16}, {0, 40}}));
  connect(pistonCylinder.flange_a, fixed.flange) annotation(
      Line(points = {{0, -4}, {0, -20}}));
  connect(pistonCylinder.fluidPort, oneWayValve2.fluidPort_b) annotation(
      Line(points = {{8, 2}, {28, 2}}));
  connect(oneWayValve1.fluidPort_a, pistonCylinder.fluidPort) annotation(
      Line(points = {{-34, 28}, {8, 28}, {8, 2}}));
    annotation(
      Diagram(graphics),
      Icon(graphics = {Text(origin = {71, 73}, rotation = 180, extent = {{-181, 18}, {131, -21}}, textString = "Q=%Q"), Polygon(fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.HorizontalCylinder, points = {{-28, 30}, {-28, -30}, {50, -2}, {-28, 30}}), Rectangle(origin = {0, -24}, fillColor = {0, 127, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, 32}, {100, -32}}), Ellipse(origin = {0, -24}, fillColor = {26, 182, 199}, fillPattern = FillPattern.Sphere, extent = {{-80, 80}, {80, -80}}), Polygon(origin = {9, -27}, fillColor = {0, 170, 255}, fillPattern = FillPattern.Solid, points = {{-33, 51}, {49, 1}, {-33, -43}, {-33, 49}, {-33, 51}}), Text(origin = {0, -200}, textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name"), Rectangle(origin = {-65, 113}, rotation = 90, fillColor = {238, 238, 238}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-83, -49}, {-23, -77}})}));
  end BombaHidraulica;

  model ModeloPrueba3
    DSFLib.Mechanical.Rotational.Components.Inertia inertia annotation(
      Placement(transformation(origin = {-16, 50}, extent = {{-10, -10}, {10, 10}})));
    DSFLib.Mechanical.Rotational.Components.Fixed fixed annotation(
      Placement(transformation(origin = {-66, 8}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    DSFLib.Mechanical.Rotational.Components.ConstTorque constTorque annotation(
      Placement(transformation(origin = {-40, 8}, extent = {{-10, -10}, {10, 10}})));
    DSFLib.Hydraulics.Components.ConstPress constPress annotation(
      Placement(transformation(origin = {-38, -42}, extent = {{-10, -10}, {10, 10}})));
    DSFLib.Hydraulics.Components.Valve valve annotation(
      Placement(transformation(origin = {30, 50}, extent = {{-10, -10}, {10, 10}})));
    BombaHidraulica bombaHidraulica annotation(
      Placement(transformation(origin = {-8, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  equation
  connect(constPress.fluidPort, valve.fluidPort_a) annotation(
      Line(points = {{-28, -42}, {60, -42}, {60, 50}, {40, 50}}));
  connect(valve.fluidPort_b, bombaHidraulica.fluidPort_a) annotation(
      Line(points = {{20, 50}, {-6, 50}, {-6, 17}}));
  connect(constPress.fluidPort, bombaHidraulica.fluidPort_b) annotation(
      Line(points = {{-28, -42}, {-6, -42}, {-6, -1}}));
  connect(bombaHidraulica.flange, constTorque.flange_b) annotation(
      Line(points = {{-16, 8}, {-30, 8}}));
  connect(fixed.flange, constTorque.flange_a) annotation(
      Line(points = {{-66, 8}, {-50, 8}}));
  connect(inertia.flange, constTorque.flange_b) annotation(
      Line(points = {{-26, 50}, {-30, 50}, {-30, 8}}));
  end ModeloPrueba3;

  model ModeloPrueba4
  BombaHidraulica bombaHidraulica annotation(
      Placement(transformation(origin = {-26, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  DSFLib.MultiDomain.ElectroMechanical.Components.DCMotor dCMotor(R = 0.1, L = 0.001, Km = 1, Jm = 1)  annotation(
      Placement(transformation(origin = {-72, 12}, extent = {{-16, -16}, {16, 16}})));
  DSFLib.Circuits.Components.ConstVolt constVolt(V = 6)  annotation(
      Placement(transformation(origin = {-72, 64}, extent = {{10, 10}, {-10, -10}})));
  DSFLib.Hydraulics.Components.Valve valve(RH = 10000000)  annotation(
      Placement(transformation(origin = {48, 66}, extent = {{-10, -10}, {10, 10}})));
  DSFLib.Hydraulics.Components.Column column annotation(
      Placement(transformation(origin = {-24, 56}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  DSFLib.Hydraulics.Components.Tank tank annotation(
      Placement(transformation(origin = {2, 84}, extent = {{-10, -10}, {10, 10}})));
  DSFLib.Hydraulics.Components.Tank tank1 annotation(
      Placement(transformation(origin = {8, -52}, extent = {{-10, -10}, {10, 10}})));
  DSFLib.Hydraulics.Components.Column column1 annotation(
      Placement(transformation(origin = {-24, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
    connect(dCMotor.flange, bombaHidraulica.flange) annotation(
      Line(points = {{-58, 10}, {-35, 10}}));
    connect(dCMotor.n, constVolt.n) annotation(
      Line(points = {{-82, 28}, {-82, 64}}));
    connect(dCMotor.p, constVolt.p) annotation(
      Line(points = {{-62, 28}, {-62, 64}}));
    connect(column.fluidPort_a, bombaHidraulica.fluidPort_a) annotation(
      Line(points = {{-24, 46}, {-24, 18}}));
    connect(tank.fluidPort, valve.fluidPort_b) annotation(
      Line(points = {{2, 74}, {2, 66}, {38, 66}}));
    connect(column.fluidPort_b, tank.fluidPort) annotation(
      Line(points = {{-24, 66}, {2, 66}, {2, 74}}));
    connect(bombaHidraulica.fluidPort_b, column1.fluidPort_b) annotation(
      Line(points = {{-24, 2}, {-24, -16}}));
    connect(column1.fluidPort_a, tank1.fluidPort) annotation(
      Line(points = {{-24, -36}, {-24, -70}, {8, -70}, {8, -62}}));
  end ModeloPrueba4;
end PumpingSystem;