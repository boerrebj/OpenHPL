within OpenHPLTest;

package HydroacousticPipeTest
  extends Modelica.Icons.ExamplesPackage;

  model AbstractHAPipeTest
    extends Modelica.Icons.Example;
    //
    inner OpenHPL.Data data(Vdot_0 = 0.0, p_a = 0.0, p_eps (displayUnit = "mm")= 0) annotation(
      Placement(transformation(origin = {-72, 80}, extent = {{-10, -10}, {10, 10}})));
    //
    parameter Modelica.Units.SI.Length Ln = 1000.;
    parameter Modelica.Units.SI.Length Dn = sqrt(An*4/Modelica.Constants.pi);
   
    OpenHPL.Waterway.Reservoir Upstream(h_0 = 100, constantLevel = true) annotation(
      Placement(transformation(origin = {-54, 32}, extent = {{-10, -10}, {10, 10}})));
    OpenHPL.Waterway.Reservoir Downstream(constantLevel = true, h_0 = 0) annotation(
      Placement(transformation(origin = {72, 10}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
    OpenHPL.Waterway.Valve valve(ValveCapacity = false, H_n = 100, Vdot_n = 1)  annotation(
      Placement(transformation(origin = {44, 10}, extent = {{-10, -10}, {10, 10}})));
    OpenHPL.Waterway.HydroacousticPipe pipe(H = 0, L = Ln, D = Dn, SteadyState = true, ignoreFriction = true)  annotation(
      Placement(transformation(origin = {-8, 20}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.Ramp ramp(height = -1, duration = 2, offset = 1, startTime = 2)  annotation(
      Placement(transformation(origin = {4, 72}, extent = {{-10, -10}, {10, 10}})));
    protected
    constant Modelica.Units.SI.Area An = 0.1;
  equation
    connect(valve.o, Downstream.o) annotation(
      Line(points = {{54, 10}, {62, 10}}, color = {0, 128, 255}));
    connect(Upstream.o, pipe.i) annotation(
      Line(points = {{-44, 32}, {-32, 32}, {-32, 20}, {-18, 20}}, color = {0, 128, 255}));
    connect(pipe.o, valve.i) annotation(
      Line(points = {{2, 20}, {12, 20}, {12, 10}, {34, 10}}, color = {0, 128, 255}));
  connect(ramp.y, valve.opening) annotation(
      Line(points = {{15, 72}, {44, 72}, {44, 18}}, color = {0, 0, 127}));
  end AbstractHAPipeTest;
end HydroacousticPipeTest;
