TITLE Calcium dependent potassium channel

NEURON {
  SUFFIX Kca3_1
  RANGE gkbar, qt, Ybeta
  USEION k READ ek WRITE ik
  USEION ca READ cai
}

UNITS {
  (mA)    = (milliamp)
  (mV)    = (millivolt)
  (molar) = (1/liter)
  (mM)    = (millimolar)
}

CONSTANT {
  q10 = 3
}

PARAMETER {
  celsius         (degC)
  v               (mV)
  gkbar   = 0.120
  Ybeta   = 0.05
}

ASSIGNED { qt }

STATE { Y }

INITIAL {
  LOCAL alpha

  qt = q10 ^ ((celsius - 37) / 10)
  alpha = exp((v + 70) / 27) * concdep(cai)
  Y = alpha / (alpha + Ybeta)
}

BREAKPOINT {
  SOLVE state METHOD cnexp

  LOCAL gk
  gk = gkbar * Y
  ik =  gk * (v - ek)
}

DERIVATIVE state {
  Y' = exp((v + 70) / 27) * concdep(cai) * (1 - Y) - Ybeta * Y
}

FUNCTION concdep(cai) {
  if (cai < 0.01) {
    concdep = (500 * (0.015 - cai)) / (exp((0.015 - cai) / 0.0013) - 1)
  }
  else {
    concdep = (500 * 0.005) / (exp(0.005 / 0.0013) - 1)
  }
}
