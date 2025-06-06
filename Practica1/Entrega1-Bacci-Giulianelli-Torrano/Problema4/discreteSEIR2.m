function x = discreteSEIR2(pre_x, t)
    TR=length(pre_x)-4;
    TI=3, N=1e6;
    R0=1.5;
    pre_S=pre_x(1);
    pre_E=pre_x(2);
    pre_I=pre_x(3);
    pre_R=pre_x(4);
    pre_NE=pre_x(5:length(pre_x))
    NEaux=R0/(TR-TI) * pre_S * pre_I / N;
    S=pre_S - NEaux;
    E=pre_E + NEaux - pre_NE(TI);
    I=pre_I + pre_NE(TI) - pre_NE(TR);
    R=pre_R + pre_NE(TR);
    NE=[NEaux; pre_NE(1:TR-1)]
    x=[S;E;I;R;NE]
  end
  