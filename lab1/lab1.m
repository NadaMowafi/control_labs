
Gsc = tf([100 40],[1 0]);
KaGtc = tf([10 6],[1 0]);
Jtot = tf([1],[7.226 0]);
Ra = 1;
Kcs = 0.5;
Kss = 0.0433;
Kf = 0.1;
Kb = 2;
r_itot = 0.0615;
pcwAvr_itot = 0.6514;
utotKt = 1.8;
T1 = series(Jtot,r_itot);
T2 = feedback(T1,(pcwAvr_itot+Kf),-1);
T3 = series(T2,utotKt);
Kcs = Kcs/T3;
T4 = feedback(T3,Kb,-1);
T5 = series(T4,KaGtc);
T6 = feedback(T5,Kcs,-1);
T7 = series(T6,Gsc);
Transfer_Function = feedback(T7,Kss,-1)  





