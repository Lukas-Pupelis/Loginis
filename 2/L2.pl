% Autorius: Lukas Pupelis 2110612
% 4 kursas 4 grupė
% Variantai: 1.5, 5.3.

% 1.5. - pravažiavus lygiai N tarpinių miestų.

% Faktai apibrėžiantys kelius tarp miestų
kelias(vilnius, ukmerge, 73). 
kelias(vilnius, moletai, 64).
kelias(moletai, utena, 35).
kelias(moletai, anyksciai, 43).
kelias(moletai, ukmerge, 44).
kelias(utena, ukmerge, 63).
kelias(utena, anyksciai, 39).
kelias(utena, zarasai, 49).
kelias(utena, rokiskis, 65).
kelias(utena, kupiskis, 57).
kelias(ukmerge, panevezys, 64).
kelias(ukmerge, jonava, 37).
kelias(anyksciai, rokiskis, 61).
kelias(anyksciai, kupiskis, 47).
kelias(jonava, kaunas, 32).
kelias(panevezys, pakruojis, 50).
kelias(panevezys, pasvalys, 40).

/* 
   Predikatas galima_nuvaziuoti(Miestas1, Miestas2, N) nustato, ar galima nuvažiuoti 
   iš miesto Miestas1 į miestą Miestas2 praeinant būtent N tarpinių miestų.
   
   Čia N reiškia tik tarpinių miestų skaičių, tai yra, iš viso kelias susideda iš N+1 etapų.
*/
galima_nuvaziuoti(Miestas1, Miestas2, N) :-
    N =:= 0,
    kelias(Miestas1, Miestas2, _).

galima_nuvaziuoti(Miestas1, Miestas2, N) :-
    N > 0,
    kelias(Miestas1, TarpinisMiestas, _),
    N1 is N - 1,
    galima_nuvaziuoti(TarpinisMiestas, Miestas2, N1).