within OpenHPL.Waterway;

model HydroacousticPipe
  extends OpenHPL.Icons.Pipe;
  extends OpenHPL.Interfaces.TwoContacts;

  outer Data data "Using standard data set";
  // Geometrical parameters of the pipe:
  parameter SI.Length H = 0 "Height difference from the inlet to the outlet" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Length L = 1000 "Length of the pipe" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Diameter D = 1.0 "Diameter of the pipe (only constant diameter pipe suppoerted at the moment)" annotation (
    Dialog(group = "Geometry"));
 // Friction specification:
  parameter Types.FrictionMethod friction_method = Types.FrictionMethod.PipeRoughness "Method for specifying pipe friction" annotation (
    Dialog(group = "Friction"));
  parameter SI.Height p_eps_input = data.p_eps "Pipe roughness height (absolute)" annotation (
    Dialog(group = "Friction", enable = friction_method == Types.FrictionMethod.PipeRoughness));
  parameter Real f_moody(min=0) = 0.02 "Moody friction factor (dimensionless, typically 0.01-0.05)" annotation (
    Dialog(group = "Friction", enable = friction_method == Types.FrictionMethod.MoodyFriction));
  parameter Real m_manning(unit="m(1/3)/s", min=0) = 40 "Manning M (Strickler) coefficient M=1/n (typically 60-110 for steel, 30-60 for rock tunnels)" annotation (
    Dialog(group = "Friction", enable = friction_method == Types.FrictionMethod.ManningFriction and not use_n));
  parameter Boolean use_n = false "If true, use Mannings coefficient n (=1/M) instead of Manning's M (Strickler)" annotation (
    Dialog(group = "Friction", enable = friction_method == Types.FrictionMethod.ManningFriction), choices(checkBox=true));
  parameter Real n_manning(unit="s/m(1/3)", min=0) = 0.025 "Manning's n coefficient (typically 0.009-0.017 for steel/concrete, 0.017-0.030 for rock tunnels)" annotation (
    Dialog(group = "Friction", enable = friction_method == Types.FrictionMethod.ManningFriction and use_n));

// Steady state:
  parameter Boolean SteadyState=data.SteadyState "If true, starts in steady state" annotation (Dialog(group="Initialization"));
  parameter SI.VolumeFlowRate Vdot_0=data.Vdot_0 "Initial flow rate of the pipe" annotation (Dialog(group="Initialization"));
  parameter Boolean ignoreFriction = false "Set friction factor to zero if true" annotation(
    Dialog(group = "Initialization"));
  //
  parameter SI.VelocityOfSound a = 1000.0 "Speed of sound";
  parameter Integer N=10 "Number of intermediate pipe segments";
  SI.VolumeFlowRate Qm "Average volume flow rate";
  Real h[N + 1] "Local dynamic head";
  SI.VolumeFlowRate Vdot[N] "Flow rate for each section";
protected
  constant Real EPSILON = 1e-08;
  parameter Real n_eff = if use_n then n_manning else 1/m_manning "Effective Manning's n coefficient";
  parameter SI.Height p_eps = if friction_method == OpenHPL.Types.FrictionMethod.PipeRoughness then p_eps_input elseif friction_method == OpenHPL.Types.FrictionMethod.MoodyFriction then 3.7*D*10^(-1/(2*sqrt(f_moody))) else D*3.0971*exp(-0.118/n_eff) "Equivalent pipe roughness height";
  constant Real pi = Modelica.Constants.pi;
  parameter SI.Area A = pi*(D/2)^2 "pipe cross section area";
  parameter SI.Acceleration g = data.g;
  parameter SI.Density rho=data.rho;
  Real fr "Friction coeficient";
  Real Re "Reynolds number";
  parameter Real dx = (2*L)/N "space step";
  parameter Real C = dx*g*A/a^2 "Hydroacoustic capacitance";
  parameter Real Li = dx/(g*A) "Hydroacoustic inductance";
  Real R;
  parameter Integer i;
initial equation
  if (SteadyState) then
    for i in 1:N loop
      der(Vdot[i]) = 0;
      der(h[i]) = 0;
    end for;
    der(h[N + 1]) = 0;
  else
    for i in 1:N loop
      Vdot[i] = Vdot_0;
    end for;
  end if;
equation
  Qm = (abs(sum(Vdot[i] for i)) + EPSILON)/N;
  Re = (data.rho*abs(Qm/A)*D)/data.mu;
  R = fr*dx*abs(Qm)/(2*g*D*A^2);
  if (ignoreFriction) then
    fr = 1.e-10;
  else
    fr = OpenHPL.Functions.DarcyFriction.fDarcy(Re, D, p_eps);
  end if;
  i.p=(h[1]+H)*(rho*g);
  o.p=h[N + 1]*(rho*g);
 
  i.mdot = Vdot[1]*data.rho;
  o.mdot = -Vdot[N]*data.rho;
  for i in 1:N loop
    (Li/2)*der(Vdot[i]) + (R/2)*Vdot[i] + (h[i + 1] - h[i]) = 0;
  end for;

  for i in 2:N loop
    C*der(h[i]) + (Vdot[i] - Vdot[i - 1]) = 0;
  end for;

annotation(
    Documentation(info = "<html><head></head><body><p>Hydroacoustic pipe flow model based on the electric analog (transmission line method)- see [Nicolet, 2007].</p></body></html>"));
end HydroacousticPipe;
