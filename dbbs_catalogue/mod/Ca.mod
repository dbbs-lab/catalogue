TITLE Cerebellum Granule Cell Model
COMMENT
    CaHVA channel
    Author: E.D'Angelo, T.Nieus, A. Fontana
    Last revised: 8.5.2000
ENDCOMMENT

NEURON {
  SUFFIX Ca
  USEION ca READ eca WRITE ica
  RANGE alpha_s, beta_s, alpha_u, beta_u
  RANGE Aalpha_s, Kalpha_s, V0alpha_s
  RANGE Abeta_s, Kbeta_s, V0beta_s
  RANGE Aalpha_u, Kalpha_u, V0alpha_u
  RANGE Abeta_u, Kbeta_u, V0beta_u
}

UNITS {
    (mA) = (milliamp)
    (mV) = (millivolt)
}

PARAMETER {
   :Kalpha_s = 0.063 (/mV)  Checked!
   :Kbeta_s = -0.039 (/mV) Checked!
   :Kalpha_u = -0.055 (/mV) Checked!
   :Kbeta_u = 0.012 (/mV) Checked!

    Aalpha_s	=    0.04944		(/ms)
    Kalpha_s	=   15.87301587302	(mV)
    V0alpha_s	=  -29.06			(mV)

    Abeta_s		=    0.08298		(/ms)
    Kbeta_s		=  -25.641			(mV)
    V0beta_s	=  -18.66			(mV)

    Aalpha_u	=    0.0013			(/ms)
    Kalpha_u	=  -18.183			(mV)
    V0alpha_u	=  -48.0			(mV)

    Abeta_u		=    0.0013			(/ms)
    Kbeta_u		=   83.33			(mV)
    V0beta_u	=  -48.0			(mV)

    v								(mV)
    gcabar		=    0.00046		(mho/cm2)
    celsius		=   30.0			(degC)
}

STATE { s u }

ASSIGNED {
    alpha_s (/ms)
    beta_s	(/ms)
    alpha_u (/ms)
    beta_u	(/ms)
	Q10
}

INITIAL {
    LOCAL a_s, b_s, a_u, b_u

    Q10 = 3.0^((celsius - 20)/10)

    a_s = alp_s(v)
    b_s = bet_s(v)
    a_u = alp_u(v)
    b_u = bet_u(v)

    s = a_s/(a_s + b_s)
    u = a_u/(a_u + b_u)
}

BREAKPOINT {
    SOLVE states METHOD cnexp

	LOCAL g

    alpha_s = alp_s(v)
    beta_s  = bet_s(v)
    alpha_u = alp_u(v)
    beta_u  = bet_u(v)

    g   = gcabar*s*s*u
    ica = g*(v - eca)
}

DERIVATIVE states {
    LOCAL a_s, b_s, a_u, b_u

    a_s = alp_s(v)
    b_s = bet_s(v)
    a_u = alp_u(v)
    b_u = bet_u(v)

    s' = a_s - s*(a_s + b_s)
    u' = a_u - u*(a_u + b_u)
}

FUNCTION alp_s(v) { alp_s = Q10*Aalpha_s*exp((v - V0alpha_s)/Kalpha_s) }
FUNCTION alp_u(v) { alp_u = Q10*Aalpha_u*exp((v - V0alpha_u)/Kalpha_u) }
FUNCTION bet_s(v) { bet_s = Q10*Abeta_s*exp((v - V0beta_s)/Kbeta_s) }
FUNCTION bet_u(v) { bet_u = Q10*Abeta_u*exp((v - V0beta_u)/Kbeta_u) }
