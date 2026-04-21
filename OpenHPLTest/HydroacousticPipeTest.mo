within OpenHPLTest;

package HydroacousticPipeTest
  extends Modelica.Icons.ExamplesPackage;
  package AuxModels
     extends Modelica.Icons.Package;
     
     model ControlledPressure
     
      outer Data data "using standard class with constants";
      OpenHPL.Interfaces.Contact_o p;
      equation
      
     end ControlledPressure;
  
  end AuxModels;
  model HydroacousticPipeTest_01
  extends Modelica.Icons.Example;
    //
    inner OpenHPL.Data data(Vdot_0 = 0.0, p_a = 0.0, p_eps(displayUnit = "mm") = 0) annotation(
      Placement(transformation(origin = {-72, 80}, extent = {{-10, -10}, {10, 10}})));
    //
    parameter Modelica.Units.SI.Length Ln = 5000.;
    parameter Modelica.Units.SI.Length Dn = sqrt(An*4/Modelica.Constants.pi);
    OpenHPL.Waterway.Reservoir Ups1(h_0 = 100, constantLevel = true) annotation(
      Placement(transformation(origin = {-54, 32}, extent = {{-10, -10}, {10, 10}})));
    OpenHPL.Waterway.Reservoir Dws1(constantLevel = true, h_0 = 0) annotation(
      Placement(transformation(origin = {72, 10}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
    OpenHPL.Waterway.Valve valve1(ValveCapacity = false, H_n = 100, Vdot_n = 1) annotation(
      Placement(transformation(origin = {44, 10}, extent = {{-10, -10}, {10, 10}})));
    OpenHPL.Waterway.HydroacousticPipe pipe1(H = 0, L = Ln, D = Dn, SteadyState = true, ignoreFriction = true) annotation(
      Placement(transformation(origin = {-8, 20}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.Ramp ramp(height = -1, duration = 2, offset = 1, startTime = 2) annotation(
      Placement(transformation(origin = {96, 80}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  protected
    constant Modelica.Units.SI.Area An = 0.1;
  public
  OpenHPL.Waterway.Reservoir Ups2(constantLevel = true, h_0 = 100) annotation(
      Placement(transformation(origin = {-60, -24}, extent = {{-10, -10}, {10, 10}})));
  OpenHPL.Waterway.Reservoir Dws2(constantLevel = true, h_0 = 0) annotation(
      Placement(transformation(origin = {66, -46}, extent = {{10, -10}, {-10, 10}})));
  OpenHPL.Waterway.Valve valve2(H_n = 100, ValveCapacity = false, Vdot_n = 1) annotation(
      Placement(transformation(origin = {38, -46}, extent = {{-10, -10}, {10, 10}})));
  OpenHPL.Waterway.HydroacousticPipe pipe2(D = Dn, H = 0, L = Ln, SteadyState = true) annotation(
      Placement(transformation(origin = {-14, -36}, extent = {{-10, -10}, {10, 10}})));
  OpenHPL.Waterway.Reservoir Ups3(constantLevel = true, h_0 = 100) annotation(
      Placement(transformation(origin = {-62, -72}, extent = {{-10, -10}, {10, 10}})));
  OpenHPL.Waterway.Reservoir Dws3(constantLevel = true, h_0 = 0) annotation(
      Placement(transformation(origin = {64, -94}, extent = {{10, -10}, {-10, 10}})));
  OpenHPL.Waterway.Valve valve3(H_n = 100, ValveCapacity = false, Vdot_n = 1) annotation(
      Placement(transformation(origin = {36, -94}, extent = {{-10, -10}, {10, 10}})));
  OpenHPL.Waterway.HydroacousticPipe pipe3(D = Dn*2, H = 0, L = Ln, SteadyState = true) annotation(
      Placement(transformation(origin = {-16, -84}, extent = {{-10, -10}, {10, 10}})));
  equation
    connect(valve1.o, Dws1.o) annotation(
      Line(points = {{54, 10}, {62, 10}}, color = {0, 128, 255}));
    connect(Ups1.o, pipe1.i) annotation(
      Line(points = {{-44, 32}, {-32, 32}, {-32, 20}, {-18, 20}}, color = {0, 128, 255}));
    connect(pipe1.o, valve1.i) annotation(
      Line(points = {{2, 20}, {12, 20}, {12, 10}, {34, 10}}, color = {0, 128, 255}));
    connect(ramp.y, valve1.opening) annotation(
      Line(points = {{85, 80}, {42, 80}, {42, 18}, {44, 18}}, color = {0, 0, 127}));
    connect(valve2.o, Dws2.o) annotation(
      Line(points = {{48, -46}, {56, -46}}, color = {0, 128, 255}));
    connect(Ups2.o, pipe2.i) annotation(
      Line(points = {{-50, -24}, {-38, -24}, {-38, -36}, {-24, -36}}, color = {0, 128, 255}));
    connect(pipe2.o, valve2.i) annotation(
      Line(points = {{-4, -36}, {6, -36}, {6, -46}, {28, -46}}, color = {0, 128, 255}));
    connect(ramp.y, valve2.opening) annotation(
      Line(points = {{85, 80}, {85, -18}, {38, -18}, {38, -38}}, color = {0, 0, 127}));
    connect(valve3.o, Dws3.o) annotation(
      Line(points = {{46, -94}, {54, -94}}, color = {0, 128, 255}));
    connect(Ups3.o, pipe3.i) annotation(
      Line(points = {{-52, -72}, {-40, -72}, {-40, -84}, {-26, -84}}, color = {0, 128, 255}));
    connect(pipe3.o, valve3.i) annotation(
      Line(points = {{-6, -84}, {4, -84}, {4, -94}, {26, -94}}, color = {0, 128, 255}));
    connect(ramp.y, valve3.opening) annotation(
      Line(points = {{85, 80}, {10, 80}, {10, -74}, {36, -74}, {36, -86}}, color = {0, 0, 127}));
  end HydroacousticPipeTest_01;

  model HydroacousticPipeTest_02
    extends OpenHPLTest.HydroacousticPipeTest.HydroacousticPipeTest_01(ramp(duration = 1, offset = 1, startTime = 0.5));
  equation

  annotation(
      experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-06, Interval = 0.002));
end HydroacousticPipeTest_02;

 model HydroacousticPipeTest_03
  extends Modelica.Icons.Example;
    //
    inner OpenHPL.Data data(Vdot_0 = 0.0, p_a = 0.0, p_eps(displayUnit = "mm") = 0) annotation(
      Placement(transformation(origin = {-72, 80}, extent = {{-10, -10}, {10, 10}})));
    //
    parameter Modelica.Units.SI.Length Ln = 5000.;
    parameter Modelica.Units.SI.Length Dn = sqrt(An*4/Modelica.Constants.pi);
    OpenHPL.Waterway.Reservoir Ups1(h_0 = 100, constantLevel = true) annotation(
      Placement(transformation(origin = {-54, 32}, extent = {{-10, -10}, {10, 10}})));
    OpenHPL.Waterway.Reservoir Dws1(constantLevel = true, h_0 = 0) annotation(
      Placement(transformation(origin = {72, 10}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
    OpenHPL.Waterway.Valve valve1(ValveCapacity = false, H_n = 100, Vdot_n = 1) annotation(
      Placement(transformation(origin = {44, 10}, extent = {{-10, -10}, {10, 10}})));
    OpenHPL.Waterway.HydroacousticPipe pipe1(H = 0, L = Ln, D = Dn, SteadyState = true, ignoreFriction = true) annotation(
      Placement(transformation(origin = {-8, 20}, extent = {{-10, -10}, {10, 10}})));
    constant Modelica.Units.SI.Area An = 0.1;
  OpenHPL.Waterway.Reservoir Ups2(constantLevel = true, h_0 = 100) annotation(
      Placement(transformation(origin = {-60, -24}, extent = {{-10, -10}, {10, 10}})));
  OpenHPL.Waterway.Reservoir Dws2(constantLevel = true, h_0 = 0) annotation(
      Placement(transformation(origin = {66, -46}, extent = {{10, -10}, {-10, 10}})));
  OpenHPL.Waterway.Valve valve2(H_n = 100, ValveCapacity = false, Vdot_n = 1) annotation(
      Placement(transformation(origin = {38, -46}, extent = {{-10, -10}, {10, 10}})));
  OpenHPL.Waterway.HydroacousticPipe pipe2(D = Dn, H = 0, L = Ln, SteadyState = true) annotation(
      Placement(transformation(origin = {-14, -36}, extent = {{-10, -10}, {10, 10}})));
  OpenHPL.Waterway.Reservoir Ups3(constantLevel = true, h_0 = 100) annotation(
      Placement(transformation(origin = {-62, -72}, extent = {{-10, -10}, {10, 10}})));
  OpenHPL.Waterway.Reservoir Dws3(constantLevel = true, h_0 = 0) annotation(
      Placement(transformation(origin = {64, -94}, extent = {{10, -10}, {-10, 10}})));
  OpenHPL.Waterway.Valve valve3(H_n = 100, ValveCapacity = false, Vdot_n = 1) annotation(
      Placement(transformation(origin = {36, -94}, extent = {{-10, -10}, {10, 10}})));
  OpenHPL.Waterway.HydroacousticPipe pipe3(D = Dn*2, H = 0, L = Ln, SteadyState = true) annotation(
      Placement(transformation(origin = {-16, -84}, extent = {{-10, -10}, {10, 10}})));
 Modelica.Blocks.Sources.Pulse pulse(amplitude = 1, width = 5, period = 20, nperiod = 3, offset = 0, startTime = 2)  annotation(
      Placement(transformation(origin = {82, 76}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  protected

equation
    connect(valve1.o, Dws1.o) annotation(
      Line(points = {{54, 10}, {62, 10}}, color = {0, 128, 255}));
    connect(Ups1.o, pipe1.i) annotation(
      Line(points = {{-44, 32}, {-32, 32}, {-32, 20}, {-18, 20}}, color = {0, 128, 255}));
    connect(pipe1.o, valve1.i) annotation(
      Line(points = {{2, 20}, {12, 20}, {12, 10}, {34, 10}}, color = {0, 128, 255}));
    connect(valve2.o, Dws2.o) annotation(
      Line(points = {{48, -46}, {56, -46}}, color = {0, 128, 255}));
    connect(Ups2.o, pipe2.i) annotation(
      Line(points = {{-50, -24}, {-38, -24}, {-38, -36}, {-24, -36}}, color = {0, 128, 255}));
    connect(pipe2.o, valve2.i) annotation(
      Line(points = {{-4, -36}, {6, -36}, {6, -46}, {28, -46}}, color = {0, 128, 255}));
    connect(valve3.o, Dws3.o) annotation(
      Line(points = {{46, -94}, {54, -94}}, color = {0, 128, 255}));
    connect(Ups3.o, pipe3.i) annotation(
      Line(points = {{-52, -72}, {-40, -72}, {-40, -84}, {-26, -84}}, color = {0, 128, 255}));
    connect(pipe3.o, valve3.i) annotation(
      Line(points = {{-6, -84}, {4, -84}, {4, -94}, {26, -94}}, color = {0, 128, 255}));
 connect(pulse.y, valve1.opening) annotation(
      Line(points = {{72, 76}, {44, 76}, {44, 18}}, color = {0, 0, 127}));
 connect(pulse.y, valve2.opening) annotation(
      Line(points = {{72, 76}, {30, 76}, {30, -28}, {38, -28}, {38, -38}}, color = {0, 0, 127}));
 connect(pulse.y, valve3.opening) annotation(
      Line(points = {{72, 76}, {18, 76}, {18, -72}, {36, -72}, {36, -86}}, color = {0, 0, 127}));
  annotation(
      experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.002));
end HydroacousticPipeTest_03;
end HydroacousticPipeTest;
