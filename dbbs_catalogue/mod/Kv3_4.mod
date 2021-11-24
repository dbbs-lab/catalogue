: HH TEA-sensitive Purkinje potassium current
: Created 8/5/02 - nwg
: Suffix from kpkj to Kv3_4

NEURON {
    SUFFIX Kv3_4
    USEION k READ ek WRITE ik
    RANGE gkbar, ik
}

UNITS {
    (mV) = (millivolt)
    (mA) = (milliamp)
}

CONSTANT {
    q10 = 3.0
    vj  = 11.0 : junction potential
}

PARAMETER {
    celsius             (degC)
    v                   (mV)

    gkbar   =    0.004	(mho/cm2)

    mivh    =  -24.0    (mV)
    mik     =   15.4	(1)
    mty0    =    0.00012851
    mtvh1   =  100.7	(mV)
    mtk1    =   12.9    (1)
    mtvh2   =  -56.0	(mV)
    mtk2    =  -23.1    (1)

    hiy0    =    0.31
    hiA     =    0.69
    hivh    =   -5.802  (mV)
    hik     =   11.2	(1)
}

ASSIGNED { qt }

STATE { m h }

INITIAL {
    LOCAL Vm

    Vm = v + vj

    m = minf_func(Vm)
    h = hinf_func(Vm)

    qt = q10^(0.1*(celsius - 37.0))
}

BREAKPOINT {
    SOLVE states METHOD cnexp
	LOCAL g
	g  = gkbar*m*m*m*h
    ik = g*(v - ek)
}

DERIVATIVE states {
    LOCAL mrho, hrho, minf, hinf, Vm

    Vm = v + vj

    minf = minf_func(Vm)
    hinf = hinf_func(Vm)
    mrho = mrho_func(Vm, qt)
    hrho = hrho_func(Vm, qt)

    m' = (minf - m)*mrho
    h' = (hinf - h)*hrho
}

FUNCTION minf_func(Vm) { minf_func =        1.0/(1.0 + exp((mivh - Vm)/mik)) }
FUNCTION hinf_func(Vm) { hinf_func = hiy0 + hiA/(1.0 + exp((Vm - hivh)/hik)) }

FUNCTION mrho_func(Vm, qt) {
    LOCAL res
    if (Vm < -35.0) {
        res = (3.4225e-5 + 0.00498*exp(Vm/28.29))*3.0
    } else {
        res = mty0 + 1.0/(exp((Vm + mtvh1)/mtk1) + exp((Vm + mtvh2)/mtk2))
    }
    mrho_func = 0.001*qt/res
}

FUNCTION hrho_func(Vm, qt) {
    LOCAL res
    if ( Vm > 0) {
        res = 1.2 + 2.3*exp(-0.141*Vm)
    } else {
        res = 0.012202 + 12.0*exp(-((Vm + 56.3)/49.6)^2.0)
    }
    hrho_func = qt/res
}
