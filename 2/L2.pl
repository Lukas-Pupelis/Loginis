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

/* pvz.
galima_nuvaziuoti(vilnius,pasvalys,4).
galima_nuvaziuoti(vilnius,Miestas,4).
galima_nuvaziuoti(Miestas1,Miestas2,3).
*/

% 5.3. - dalybos liekana (mod).

%Dalyba iš nulio negalima
mod(_, 0, _) :-
    throw(error(division_by_zero)).

% Apibrėžti liekanos (mod) predikatą
mod(Dalinys, Daliklis, Mod) :-
    Daliklis \= 0,
    modulis(Daliklis, DaliklioModulis),
    mod_rekursinis(Dalinys, DaliklioModulis, Mod).
        
% Bazinis atvejis: kai Dalinys yra tarp 0 ir DaliklioModulis
mod_rekursinis(Dalinys, DaliklioModulis, Dalinys) :-
    Dalinys >= 0,
    Dalinys < DaliklioModulis.
    
% Rekursinis atvejis: atimti DaliklioModulis iš Dalinys, jei Dalinys >= DaliklioModulis
mod_rekursinis(Dalinys, DaliklioModulis, Mod) :-
    Dalinys >= DaliklioModulis,
    NaujasDalinys is Dalinys - DaliklioModulis,
    mod_rekursinis(NaujasDalinys, DaliklioModulis, Mod).
    
% Rekursinis atvejis: pridėti DaliklioModulis prie Dalinys, jei Dalinys < 0
mod_rekursinis(Dalinys, DaliklioModulis, Mod) :-
    Dalinys < 0,
    NaujasDalinys is Dalinys + DaliklioModulis,
    mod_rekursinis(NaujasDalinys, DaliklioModulis, Mod).
    
% Pagalbinis predikatas absoliutinei reikšmei apskaičiuoti
modulis(Dalinys, Modulis) :-
    Dalinys >= 0,
    Modulis = Dalinys.
    
modulis(Dalinys, Modulis) :-
    Dalinys < 0,
    Modulis is -Dalinys.