% Autorius: Lukas Pupelis 2110612
% 4 kursas 4 grupė
% 3 užduotis
% Variantai: 1.2, 2.1, 3.4, 4.4

/*
1.2. lyginiai(S) - teisingas, kai visi duoto sveikųjų skaičių sąrašo S elementai
yra lyginiai. Pavyzdžiui:
?- lyginiai([4,18,24,10]).
true.
*/
lyginiai([]).
lyginiai([H|T]) :-
    0 is mod(H,2), lyginiai(T).

/*pvz.: lyginiai([4,18,24,10]).
lyginiai([17,25,10]).
lyginiai([25,10]).
*/


/*2.1. nr(S,K,E) - E yra K-asis sąrašo S elementas. Pavyzdžiui:
?- nr([a,b,c,d,e],3,E).
E = c.
*/

nr([E|_] , 1 ,E):-!.
nr([_|T] , N ,E):-
    N > 0, N1 is N-1, nr(T,N1,E).

/*
Pvz.
nr([],3,E).
nr([a,b,c],2,E).
nr([a,b,c],5,E).
nr([a,b,c,d,e],3,E).
nr([a,b,c,d,e],5,E).
*/

/*
kartojasi(S,R) - sąrašas R susideda iš duotojo sąrašo S pasikartojančių elementų. Pavyzdžiui:
?- kartojasi([a,b,a,d,a,d],R).
R = [a,d].
*/

% kartojasi(S, K) - K yra elementų sąrašas, kurie kartojasi sąraše S.
kartojasi(S, K) :-
    rasti_visus(X, (narys(X, S), sumuoti_pasikartojimus(S, X, C), C > 1), K0),
    rusiuoti(K0, K).

% sumuoti_pasikartojimus(Sąrašas, Elementas, Suma) - Suma yra skaičius, kiek kartų
% Elementas pasirodo Sąraše.
sumuoti_pasikartojimus([], _, 0).
sumuoti_pasikartojimus([X|Xs], X, N) :-
    sumuoti_pasikartojimus(Xs, X, N1),
    N is N1 + 1.
sumuoti_pasikartojimus([Y|Ys], X, N) :-
    X \= Y,
    sumuoti_pasikartojimus(Ys, X, N).
