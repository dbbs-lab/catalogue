TITLE CA1 KM channel from Mala Shah

UNITS {
    (mA) = (milliamp)
    (mV) = (millivolt)
}

PARAMETER {
    v (mV)
    ek
    celsius (degC)
    gbar = .0001 (mho/cm2)
    vhalfl = -40 (mV)
    kl = -10
    vhalft = -42 (mV)
    a0t = 0.009 (/ms)
    zetat = 7 (1)
    gmt = .4 (1)
    q10 = 5
    b0 = 60
    st = 1
}

NEURON {
    SUFFIX glia__dbbs__Kv7__0
    THREADSAFE
    USEION k READ ek WRITE ik
    RANGE gbar, ik
    GLOBAL inf, tau
}

STATE {
    m
}

ASSIGNED {
    ik (mA/cm2)
    inf
    tau
    taua
    taub
}

INITIAL {
    rate(v)
    m = inf
}

BREAKPOINT {
    SOLVE state METHOD cnexp
    ik = gbar*m^st*(v-ek)
}

FUNCTION alpt(v(mV)) {
    alpt = exp(0.0378*zetat*(v-vhalft))
}

FUNCTION bett(v(mV)) {
    bett = exp(0.0378*zetat*gmt*(v-vhalft))
}

DERIVATIVE state {
    rate(v)
    m' = (inf-m)/tau
}

PROCEDURE rate(v(mV)) {
    LOCAL a, qt
    qt = q10^((celsius-35)/10)
    inf = (1/(1+exp((v-vhalfl)/kl)))
    a = alpt(v)
    tau = b0+bett(v)/(a0t*(1+a))
}
