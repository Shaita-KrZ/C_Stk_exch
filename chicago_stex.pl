%consult('C:/Users/SHAITA/Documents/Github/Chicago-stock-ecxhange/chicago_stex.pl').

%permet d'afficher une liste
afficher_sous_liste([H|[]]):-write(H),nl.
afficher_sous_liste([H|T]):-write(H),write(','),afficher_sous_liste(T).
%permet d'afficher une liste de sous liste
afficher_liste([]).
afficher_liste([T|Q]):-afficher_sous_liste(T),afficher_liste(Q).


% initialisation de la bourse
bourse([[ble,7],[riz,6],[cacao,6],[cafe,6],[sucre,6],[mais,6]]).
% affichage de la bourse a partir du fait bourse 
afficher_bourse(_):-bourse([T|Q]),afficher_liste([T|Q]).

% initialisation du tas

% Association d'une marchandise avec un numero permettant de le retrouver.
marchandise_numero([[ble,1],[riz,2],[cacao,3],[cafe,4],[sucre,5],[mais,6]]).

%Permettant de trouver un numero de la marchandise dans une liste de marchandise
trouver_numero(T,R,[[T,R]|_]):-!.
trouver_numero(T,R,[_|Q]):-trouver_numero(T,R,Q).

%Permettant d'ajouter un element a une liste
ajouter_element(X,[],[X]).
ajouter_element(X,[T|Q],[X|[T|Q]]).

%simulation d une boucle qui ajoute des marchandises au fur et a mesure (la marchandise est random), le numero generé par random est associé à une marchandise
% a l'aide de trouver_numero
% On ajoute ensuite la marchandise dans une liste 

tas(Ldep,I,K):-I=<K,random(1,6,X),marchandise_numero(L),trouver_numero(Marchandise,X,L),ajouter_element(Marchandise,Ldep,LRes),I1 is I+1,tas(LRes,I1,K).
tas(Lres,I,K):-I>K,afficher_sous_liste(Lres).
%On affectue le tas 9 fois afin d'initialiser les 9 tas du jeu. 
%Complexité = 4*9
afficher_tas(J,K):-J=<K,tas([],1,4),J1 is J+1,afficher_tas(J1,K).
afficher_tas(J,K):-J>K.


% initialisation du trader
trader(X):- random(1,9,X).
afficher_trader(_):-trader(X),write(X).


afficher_joueur1([]):-write('La reserve du joueur 1 est vide').
afficher_joueur2([]):-write('La reserve du joueur 2 est vide').

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
	
