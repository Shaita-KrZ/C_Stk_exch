bourse(Bourse,[[ble,7],[riz,6],[cacao,6],[cafe,6],[csucre,6],[cmais,6]]).

%consult('C:/Users/SHAITA/Documents/Github/Chicago-stock-ecxhange/chicago_stex.pl').

% afficher_bourse([]).
% afficher_bourse(L,X):-bourse(L,[[T|R]|Q]),write(T),write(R),nl,afficher_bourse(L,Q).


tas(Tas,[[mais,riz,ble,ble],[ble,mais,sucre,riz],[cafe,sucre, cacao,cacao],[cafe,mais,sucre,mais],[cacao,mais,ble,ble],[riz,cafe,sucre,ble],
		[cafe,ble,sucre,cacao],[mais,cacao,cacao,cafe],[riz,riz,cafe,cacao]]).
afficher_tas(Y):-tas(_,Y), print(Y).

joueur(J1,[]).
joueur(J2,[]).
afficher_joueur(Y):-joueur(X,Y),write(X),print(Y).

plateau(Plateau,B,T,J1,J2):-bourse(X,B),tas(Y,T),joueur(_,J1),joueur(_,J2).
afficher_plateau(P):-plateau(P,B,T,J1,J2),print(B),nl,print(T),nl,print(J1),nl,print(J2).