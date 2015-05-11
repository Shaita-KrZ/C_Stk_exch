%consult('C:/Users/SHAITA/Documents/Github/Chicago-stock-ecxhange/chicago_stex.pl').
%Predicat generale :
%permet d'afficher une liste
afficher_sous_liste([H|[]]):-write(H),nl.
afficher_sous_liste([H|T]):-write(H),write(','),afficher_sous_liste(T).
%permet d'afficher une liste de sous liste
afficher_liste([]).
afficher_liste([T|Q]):-afficher_sous_liste(T),afficher_liste(Q).
%Permettant de trouver un numero de la marchandise dans une liste de marchandise
trouver_numero(T,R,[[T,R]|_]):-!.
trouver_numero(T,R,[_|Q]):-trouver_numero(T,R,Q).
%Permettant d'ajouter un element a une liste
ajouter_element(X,[],[X]).
ajouter_element(X,[T|Q],[X|[T|Q]]).
%Permettant de savoir si deux liste sont egales
egalite_liste(L,L).
%Permet de savoir si X est un element d'une liste
element(X,[X|_]):-!.
element(X,[_|Q]):-element(X,Q).

% initialisation de la bourse
bourse([[ble,7],[riz,6],[cacao,6],[cafe,6],[sucre,6],[mais,6]]).
% affichage de la bourse a partir du fait bourse 
afficher_bourse(_):-bourse([T|Q]),afficher_liste([T|Q]).

% initialisation du tas
% Association d'une marchandise avec un numero permettant de le retrouver.
marchandise_numero([[ble,1],[riz,2],[cacao,3],[cafe,4],[sucre,5],[mais,6]]).
% tas([],1,4,X).
tas(Ldep,I,K,LTas):-I=<K,random(1,6,X),marchandise_numero(L),trouver_numero(Marchandise,X,L),ajouter_element(Marchandise,Ldep,LRes),I1 is I+1,tas(LRes,I1,K,LTas).
tas(Lres,I,K,LTas):-I>K,LTas is Lre.

% marchandise(1,9,[],X).
marchandise(J,K,Ldep,LMarchandise):-J=<K,tas([],1,4,Tas),ajouter_element(J,Tas,LTas),ajouter_element(LTas,Ldep,LRes),J1 is J+1,marchandise(J1,K,LRes,LMarchandise).
marchandise(J,K,LRes,LMarchandise):-J>K,LMarchandise is LRes.
% afficher_tas(1,9,[]).
afficher_tas(J,K,LTas):-J=<K,tas([],1,4,Tas),ajouter_element(J,Tas,Tas2),ajouter_element(Tas2,LTas,LResultat),J1 is J+1,afficher_tas(J1,K,LResultat).
afficher_tas(J,K,LTas):-J>K,afficher_liste(LTas).

% initialisation du trader
trader(X):- random(1,9,X).
afficher_trader(_):-trader(X),write(X).

reserve_joueur1([]).
reserve_joueur2([]).
afficher_joueur1([]):-write('La reserve du joueur 1 est vide').
afficher_joueur2([]):-write('La reserve du joueur 2 est vide').

plateau([Marchandise, Bourse, PositionTrader, RJ1, RJ2]):-trader(PositionTrader),marchandise(1,9,[],Marchandise),bourse(Bourse),reserve_joueur1(RJ1),reserve_joueur2(RJ2).

plateau_depart(_):-
	write('La reserve du joueur 1: '),nl,
	afficher_joueur1([]),nl,
	write('***************************'),nl,
	write('La reserve du joueur 2: '),nl,
	afficher_joueur2([]),nl,
	write('***************************'),nl,
	write('Le tas est :'),nl,
	afficher_tas(1,9),
	write('***************************'),nl,
	write('La bourse actuel est :'),nl,
	afficher_bourse(_),
	write('***************************'),nl,
	write('Le trader est a la position :'),nl,
	afficher_trader(_).

%On a la liste des marchandise allant de 9 a 1, on parcours la liste jusqua trouver la pile correspondante
parcourir_marchandise([_|Q],Positionfin,Position,Marchandise):-Position<Positionfin,Position1 is Position+1,parcourir_marchandise(Q,Positionfin,Position1,Marchandise).
% T sera la liste des marchandise
parcourir_marchandise([T|_],Positionfin,Position,Marchandise):-Positionfin>=Position,Marchandise is T.

coup([j1,1,sucre,riz]).

coup_possible([Marchandise, Bourse, PositionTrader, RJ1,RJ2], [Joueur,Deplacement,March_gardee,March_vendu]):-
coup([Joueur,Deplacement,March_gardee,March_vendu]),
plateau([Marchandise,Bourse,PositionTrader,RJ1,RJ2]),
Deplacement=<3,Deplacement>=1,
Mouvement is PositionTrader+Deplacement,
Mouvement1 is Mouvement+1,
Mouvement2 is Mouvement-1,
parcourir_marchandise(Marchandise,9,Mouvement1,[_|[T|_]]),
produit1 is T,
egalite_liste(March_vendu,T),
parcourir_marchandise(Marchandise,9,Mouvement2,[_|[X|_]]),
produit2 is X,
egalite_liste(March_gardee,X).

coup_possible([Marchandise, Bourse, PositionTrader, RJ1,RJ2], [Joueur,Deplacement,March_gardee,March_vendu]):-
coup([Joueur,Deplacement,March_gardee,March_vendu]),
plateau([Marchandise,Bourse,PositionTrader,RJ1,RJ2]),
Deplacement=<3,Deplacement>=1,
Mouvement is PositionTrader+Deplacement,
Mouvement1 is Mouvement+1,
Mouvement2 is Mouvement-1,
parcourir_marchandise(Marchandise,9,Mouvement1,[_|[T|_]]),
produit1 is T,
egalite_liste(March_gardee,T),
parcourir_marchandise(Marchandise,9,Mouvement2,[_|[X|_]]),
produit2 is X,
egalite_liste(March_vendu,X).

affecter_choix1(X,X,1).
affecter_choix1(X,Y,_).

affecter_choix2(X,X,2).
affecter_choix2(X,Y,_).

supprimer_element(X,[X|Q],[Q]).

jouer_coup([Marchandise,Bourse,PositionTrader,RJ1,RJ2],[Joueur,Deplacement,March_gardee,March_vendu], [NouveauMarchandise,NouveauBourse,NouveauPositionTrader,NouveauRJ1,NouveauRJ2]):-
write("Le trader est a la position"),
write(PositionTrader),nl,
write("Voulez vous vous deplacez de 1,2 ou 3 cases?"),
read(Deplacement),
NouveauPositionTrader is PositionTrader+Deplacement,
Mouvement1 is NouveauPositionTrader+1,
Mouvement2 is NouveauPositionTrader-1,
write("La marchandise correspondante apres le Trader est"),
parcourir_marchandise(Marchandise,9,Mouvement1,[T1|[X|Q1]]),
write(X),nl,
write("La marchandise correspondant avant le Trader est"),
parcourir_marchandise,9,Deplacement,Mouvement2,[T2|[Y|Q2]]),
write(Y),nl,
write("Tapez 1 pour garder la marchandise 1"),nl,
write("Tapez 2 pour la vendre"),nl,
read(Choix),
affecter_choix1(X,March_gardee,Choix),
affecter_choix2(X,March_vendu,Choix),
affecter_choix1(Y,March_vendu,Choix),
affecter_choix2(Y,March_gardee,Choix),
coup_possible([Marchandise,Bourse, PositionTrader,RJ1,RJ2],[Joueur,Deplacement,March_gardee,March_vendu]).
%supprimer__marchandise(),
%supprimer_marchandise(),
%ajouter_element(X,RJ1,NouveauRJ1),
%ajouter_element(Y,RJ2,NouveauRJ1),
%modif_bourse(),
%savoir si J1 ou J2.









