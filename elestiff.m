function ke = elestiff(E, A, x)

lx = x(3) - x(1);
ly = x(4) - x(2);
le = sqrt(lx^2 + ly^2);

l = lx/le;  m = ly/le; lm = l*m;


factor1= A*E/le;
    ke=[l^2, lm, -l^2, -lm;
        lm, m^2, -lm, -m^2;
        -l^2, -lm, l^2, lm;
        -lm, -m^2, lm, m^2]*factor1;