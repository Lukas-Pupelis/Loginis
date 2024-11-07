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
