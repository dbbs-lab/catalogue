TITLE Large conductance Ca2+ activated K+ channel mslo

COMMENT
Parameters from Cox et al. (1987) J Gen Physiol 110:257-81 (patch 1).

Current Model Reference: Anwar H, Hong S, De Schutter E (2010) Controlling
Ca2+-activated K+ channels with models of Ca2+ buffering in Purkinje cell.
Cerebellum*

*Article available as Open Access

PubMed link: http://www.ncbi.nlm.nih.gov/pubmed/20981513

Written by Sungho Hong, Okinawa Institute of Science and Technology, March 2009.
Contact: Sungho Hong (shhong@oist.jp)
ENDCOMMENT

NEURON {
  SUFFIX Kca1_1
  USEION k READ ek WRITE ik
  USEION ca READ cai
  RANGE gbar
}

UNITS {
    (mV)    = (millivolt)
    (S)     = (siemens)
    (molar) = (1/liter)
    (mM)    = (millimolar)
}

CONSTANT {
  FARADAY = 96.520
  R       = 8.3134 : gas constant (J/K.mol)
  q10     = 3
}

PARAMETER {
    v           (mV)
    celsius     (degC)
    gbar = 0.01 (S/cm2)

    Qo =  0.73
    Qc = -0.67

    k1        = 1000.0 (/mM)
    onoffrate =    1.0 (/ms)

    Kc =    11.0e-3 (mM)
    Ko =     1.1e-3 (mM)

    pf0 =    2.39e-3  (/ms)
    pf1 =    7.0e-3   (/ms)
    pf2 =   40.0e-3   (/ms)
    pf3 =  295.0e-3   (/ms)
    pf4 =  557.0e-3   (/ms)

    pb0 = 3936.0e-3  (/ms)
    pb1 = 1152.0e-3  (/ms)
    pb2 =  659.0e-3  (/ms)
    pb3 =  486.0e-3  (/ms)
    pb4 =   92.0e-3  (/ms)
}

STATE {
    C0 FROM 0 TO 1
    C1 FROM 0 TO 1
    C2 FROM 0 TO 1
    C3 FROM 0 TO 1
    C4 FROM 0 TO 1
    O0 FROM 0 TO 1
    O1 FROM 0 TO 1
    O2 FROM 0 TO 1
    O3 FROM 0 TO 1
    O4 FROM 0 TO 1
}

BREAKPOINT {
    SOLVE activation METHOD sparse
    LOCAL g
    g  = gbar*(O0 + O1 + O2 + O3 + O4)
    ik = g*(v - ek)
}

INITIAL {
    SOLVE activation STEADYSTATE sparse
}

KINETIC activation {
    LOCAL c01, c12, c23, c34
    LOCAL o01, o12, o23, o34
    LOCAL c10, c21, c32, c43
    LOCAL o10, o21, o32, o43

    LOCAL f0, f1, f2, f3, f4
    LOCAL b0, b1, b2, b3, b4

    LOCAL qt, alpha, beta, k1p, b

    qt    = q10^(0.1*(celsius - 23.0))
    k1p   = k1*onoffrate*qt
    b     = FARADAY*v/(R*(273.15 + celsius))
    alpha = qt*exp(Qo*b)
    beta  = qt*exp(Qc*b)

    c01 = 4*ca*k1p
    c12 = 3*ca*k1p
    c23 = 2*ca*k1p
    c34 = 1*ca*k1p
    o01 = 4*ca*k1p
    o12 = 3*ca*k1p
    o23 = 2*ca*k1p
    o34 = 1*ca*k1p

    c10 = 1*Kc*k1p
    c21 = 2*Kc*k1p
    c32 = 3*Kc*k1p
    c43 = 4*Kc*k1p
    o10 = 1*Ko*k1p
    o21 = 2*Ko*k1p
    o32 = 3*Ko*k1p
    o43 = 4*Ko*k1p

    f0  = pf0*alpha
    f1  = pf1*alpha
    f2  = pf2*alpha
    f3  = pf3*alpha
    f4  = pf4*alpha

    b0  = pb0*beta
    b1  = pb1*beta
    b2  = pb2*beta
    b3  = pb3*beta
    b4  = pb4*beta

    ~ C0 <-> C1  (c01, c10)
    ~ C1 <-> C2  (c12, c21)
    ~ C2 <-> C3  (c23, c32)
    ~ C3 <-> C4  (c34, c43)
    ~ O0 <-> O1  (o01, o10)
    ~ O1 <-> O2  (o12, o21)
    ~ O2 <-> O3  (o23, o32)
    ~ O3 <-> O4  (o34, o43)
    ~ C0 <-> O0  (f0,   b0)
    ~ C1 <-> O1  (f1,   b1)
    ~ C2 <-> O2  (f2,   b2)
    ~ C3 <-> O3  (f3,   b3)
    ~ C4 <-> O4  (f4,   b4)

    CONSERVE C0 + C1 + C2 + C3 + C4 + O0 + O1 + O2 + O3 + O4 = 1
}
