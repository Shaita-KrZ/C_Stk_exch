%consult('C:/Users/SHAITA/Documents/Github/Chicago-stock-ecxhange/chicago_stex.pl').


% -------------------------------- DEBUT PREDICAT GENERALE -------------------------------------%
% permet d'afficher une liste
afficher_sous_liste([H|[]]):-write(H),nl.
afficher_sous_liste([H|T]):-write(H),write(','),afficher_sous_liste(T).
% Permet d'afficher une liste de sous liste
afficher_liste([]).
afficher_liste([T|Q]):-afficher_sous_liste(T),afficher_liste(Q).

% trouver_numero([],4,marchandise_numero)
% Algorithme trouver_numero
% Paramètre : T la marchandise a trouver, R le numero correspondant a une marchandise, liste associatif marchandise / numero
% Si le numero correspond au numero associe a la marchandise, on affecte la marchandise a T
% Sinon on continue de parcourir la liste
trouver_numero(T,R,[[T,R]|_]):-!.
trouver_numero(T,R,[_|Q]):-trouver_numero(T,R,Q).

% Permettant d'ajouter un element a une liste
ajouter_element(X,[],[X]).
ajouter_element(X,[T|Q],[X|[T|Q]]).

% Permettant de savoir si deux liste sont egales
egalite(L,L).

% Permet de savoir si X est un element d'une liste
element(X,[X|_]):-!.
element(X,[_|Q]):-element(X,Q).

% Permet d'affecter deux listes
affecter_liste(L,L).

% modulo(4,10,Z).
% Predicat MODULO (permet de pas avoir une positionTrader superieur a 9)
modulo(X,Y,Z):-Z is X mod Y. 

% -------------------------------- FIN PREDICAT GENERALE -------------------------------------%

% -------------------------------- PREDICAT BOURSE -------------------------------------------%

% initialisation de la bourse
bourse([[ble,7],[riz,6],[cacao,6],[cafe,6],[sucre,6],[mais,6]]).

% affichage de la bourse 
afficher_bourse(_):-bourse([T|Q]),afficher_liste([T|Q]).

% -------------------------------- FIN PREDICAT BOURSE -------------------------------------------%

% -------------------------------- PREDICAT MARCHANDISE -------------------------------------------%

% Association d'une marchandise avec un numero permettant de la retrouver avec un chiffre random.
marchandise_numero([[ble,1],[riz,2],[cacao,3],[cafe,4],[sucre,5],[mais,6]]).

% tas(1,4,[],X).
% Algorithme tas :
% Paramètre : I, K boucle de I a K / TasIncrementer La liste qui va contenir le tas au fur et a mesure / TasResultat va contenir le tas final
% Trouver un nombre au hasard entre 1 et 6
% Recupere une liste des marchandises avec un numero (permet de recuperer des marchandises au hasard)
% Trouve la marchandise correspondant au numero random
% Ajoute la Marchandise au tas Incrementer qui donne une nouvelle liste (Liste Resultat)
% On rapelle tas avec la liste de Resultat

tas(I,K,TasIncrementer,TasResultat):-I=<K,random(1,6,X),marchandise_numero(MarchandiseNumero),trouver_numero(Marchandise,X,MarchandiseNumero),ajouter_element(Marchandise,TasIncrementer,ListeResultat),I1 is I+1,tas(I1,K,ListeResultat,TasResultat).
tas(I,K,TasIncrementer,TasResultat):-I>K,affecter_liste(TasResultat,TasIncrementer),!.


% marchandise(1,9,[],X).
% Algorithme Marchandise :
% Paramètre : I, K boucle de I a K / MarchandiseIncrementer La liste qui va contenir LES tas au fur et a mesure / MarchandiseResultat va contenir LES tas final
% On appelle l'agorithme tas, qui va nous renvoyer un nouveau Tas
% K1 is K-J pour avoir les listes de 0 à 8 et pas de 9 à 1
% On ajoute un numero au Tas correspondant a sa position et permettant de le retrouver
% On ajoute le Tas au Marchandise Incrementer qui donne un nouvelle liste (LRes).
% On rapelle marchandise avec la liste de Resultat  

marchandise(J,K,MarchandiseIncrementer,MarchandiseResultat):-J=<K,tas(1,4,[],Tas),K1 is K-J,ajouter_element(K1,Tas,LTas),ajouter_element(LTas,MarchandiseIncrementer,LRes),J1 is J+1,marchandise(J1,K,LRes,MarchandiseResultat).
marchandise(J,K,MarchandiseIncrementer,MarchandiseResultat):-J>K,affecter_liste(MarchandiseResultat,MarchandiseIncrementer).

% afficher_tas(1,9,[]).
% Algorithme afficher_tas = Algorithme Marchandise sauf qu on affiche seulement les marchandises et on ne les recuperer pas
afficher_tas(J,K,LTas):-J=<K,tas(1,4,[],Tas),K1 is K-J,ajouter_element(K1,Tas,Tas2),ajouter_element(Tas2,LTas,LResultat),J1 is J+1,afficher_tas(J1,K,LResultat).
afficher_tas(J,K,LTas):-J>K,afficher_liste(LTas).

% -------------------------------- FIN PREDICAT MARCHANDISE -------------------------------------------%

% -------------------------------- PREDICAT TRADER -------------------------------------------%

% initialisation du trader
trader(X):- random(1,9,X).
afficher_trader(_):-trader(X),write(X).

% -------------------------------- FIN PREDICAT TRADER -------------------------------------------%

% -------------------------------- PREDICAT RESERVE JOUEUR -------------------------------------------%

reserve_joueur1([]).
reserve_joueur2([]).
afficher_joueur1([]):-write('La reserve du joueur 1 est vide').
afficher_joueur2([]):-write('La reserve du joueur 2 est vide').

% -------------------------------- FIN PREDICAT RESERVE JOUEUR -------------------------------------------%

% -------------------------------- PREDICAT PLATEAU -------------------------------------------%

% plateau(Plateau).
% Algorithme plateau 
% Paramètre : prend en paramètre les differents paramètres d'un plateau : Marchandise, Bourse, PositionTrader, Reserve Joueur1, Reserve Joueur2 sous forme d'une liste.
% On initialise marchandise avec le predicat marchandise
% On initialise PositionTrader avec le predicat trader
% On initialise Bourse avec le predicat bourse
% On initialise RJ1 avec reserve_joueur1
% On initialise RJ2 avec reserve_joueur2

plateau([Marchandise, Bourse, PositionTrader, RJ1, RJ2]):-trader(PositionTrader),marchandise(1,9,[],Marchandise),bourse(Bourse),reserve_joueur1(RJ1),reserve_joueur2(RJ2).

% -------------------------------- FIN PREDICAT PLATEAU -------------------------------------------%

% -------------------------------- PREDICAT PLATEAU DEPART -------------------------------------------%

% Algorithme plateau_depart
% Algorithme qui affiche les differents parametres du plateau.

plateau_depart(_):-
	write('La reserve du joueur 1: '),nl,
	afficher_joueur1([]),nl,
	write('***************************'),nl,
	write('La reserve du joueur 2: '),nl,
	afficher_joueur2([]),nl,
	write('***************************'),nl,
	write('Le tas est :'),nl,
	afficher_tas(1,9,[]),
	write('***************************'),nl,
	write('La bourse actuel est :'),nl,
	afficher_bourse(_),nl,
	write('***************************'),nl,
	write('Le trader est a la position :'),nl,
	afficher_trader(_).
	
% -------------------------------- FIN PREDICAT PLATEAU DEPART -------------------------------------------%

% -------------------------------- PREDICAT PARCOURIR MARCHANDISE -------------------------------------------%

% Liste Marchandise : [[0,ble,riz,ble,riz],[1,ble,sucre,riz,cacao],[2,ble,cafe,ble,cacao],[3,riz,sucre,cafe,sucre],[4,ble,cafe,ble,cacao],[5,sucre,ble,sucre,cacao],[6,riz,ble,riz,cafe],[7,riz,sucre,riz,cafe],[8,sucre,ble,riz,ble]]

% parcourir_marchandise(listeMarchandises,0,Position,Marchandise).
% Algorithme parcourir_marchandise : permet de recuperer le tas correspondant la positionX
% Paramètre : [_|Q] : represente la liste des marchandises, PositionDebut correspond a la premiere positions des tas (i.e : 1),PositionX la position de la marchandise a retrouver, Tas le tas a recuperer
% Boucle de PositionDebut (=0) a PositionX (=3) par exemple. 
% Une fois arrive a PositionX, On recupere le tas correspondant a la position X 

parcourir_marchandise([_|Q],PositionDebut,PositionX,Tas):-PositionDebut<PositionX,Position1 is PositionDebut+1,parcourir_marchandise(Q,Position1,PositionX,Tas).
parcourir_marchandise([T|_],PositionDebut,PositionX,Tas):-PositionDebut>=PositionX,affecter_liste(Tas,T).

% -------------------------------- FIN PREDICAT PARCOURIR MARCHANDISE -------------------------------------------%

% -------------------------------- PREDICAT COUP_POSSIBLE -------------------------------------------%

coup([j1,1,sucre,riz]).

% Algorithme coup_possible :
% Paramètre : Plateau, Coup : coup([j1,1,sucre,riz]) (par exemple)
% Pour tester l'algorithme, on initialise le plateau et le coup avec le predicat plateau et coup
% Si le deplacement est superieur a 3 ou inferieur a 1 => erreur
% On recupere la nouvelle position du trader (Mouvement)
% On recupere la position juste apres le trader
% On recupere la position juste avant le trader
% On utilise modulo a chaque fois pour eviter que le mouvement ne passe 9
% On regarde si la marchandise a la position juste apres le trader correspond bien a la march_vendu (predicat 1) ou a la march_gardee(predicat 2).
% On regarde si la marchandise a la position juste avant le trader correspond bien a la march_vendu (predicat 1) ou a la march_gardee(predicat 2).

coup_possible([Marchandise, Bourse, PositionTrader, RJ1,RJ2], [Joueur,Deplacement,March_gardee,March_vendu]):-
Deplacement=<3,Deplacement>=1,
Mouvement is PositionTrader+Deplacement,
modulo(Mouvement,10,MouvementModulo),
MouvementApres is MouvementModulo+1,
modulo(MouvementApres,10,MouvementModuloApres),
MouvementAvant is MouvementModulo-1,
modulo(MouvementAvant,10,MouvementModuloAvant),
parcourir_marchandise(Marchandise,0,MouvementModuloApres,[_|[T|_]]),
egalite(March_vendu,T),
parcourir_marchandise(Marchandise,0,MouvementModuloAvant,[_|[X|_]]),!,
egalite(March_gardee,X),!.

coup_possible([Marchandise, Bourse, PositionTrader, RJ1,RJ2], [Joueur,Deplacement,March_gardee,March_vendu]):-
Deplacement=<3,Deplacement>=1,
Mouvement is PositionTrader+Deplacement,
modulo(Mouvement,10,MouvementModulo),
MouvementApres is MouvementModulo+1,
modulo(MouvementApres,10,MouvementModuloApres),
MouvementAvant is MouvementModulo-1,
modulo(MouvementAvant,10,MouvementModuloAvant),
parcourir_marchandise(Marchandise,0,MouvementModuloApres,[_|[T|_]]),!,
egalite(March_gardee,T),
parcourir_marchandise(Marchandise,0,MouvementModuloAvant,[_|[X|_]]),!,
egalite(March_vendu,X),!.

% -------------------------------- FIN PREDICAT COUP_POSSIBLE -------------------------------------------%

% -------------------------------- PREDICAT JOUER COUP -------------------------------------------%

affecter_choix1(X,X,1).
affecter_choix1(X,Y,_).

affecter_choix2(X,X,2).
affecter_choix2(X,Y,_).

supprimer_element(X,[X|Q],[Q]).

jouer_coup([Marchandise,Bourse,PositionTrader,RJ1,RJ2],[Joueur,Deplacement,March_gardee,March_vendu], [NouveauMarchandise,NouveauBourse,NouveauPositionTrader,NouveauRJ1,NouveauRJ2]):-
coup_possible([Marchandise, Bourse, PositionTrader, RJ1, RJ2],[Joueur,Deplacement,March_gardee,March_vendu]),
PosTrader is PositionTrader+Deplacement,
modulo(PosTrader,10,NouveauPositionTrader),
PositionTraderApres is NouveauPositionTrader+1,
modulo(PositionTraderApres,10,PositionTraderModuloApres),
PositionTraderAvant is NouveauPositionTrader-1,
modulo(PositionTraderAvant,10,PositionTraderModuloAvant),
write("La marchandise correspondante apres le Trader est"),
parcourir_marchandise(Marchandise,0,PositionTraderModuloApres,[T1|[X|Q1]]),
write(X),nl,
write("La marchandise correspondant avant le Trader est"),
parcourir_marchandise(Marchandise,0,PositionTraderModuloAvant,[T2|[Y|Q2]]),
write(Y),nl.

%supprimer__marchandise(),
%supprimer_marchandise(),
%ajouter_element(X,RJ1,NouveauRJ1),
%ajouter_element(Y,RJ2,NouveauRJ1),
%modif_bourse(),
%savoir si J1 ou J2.



% -------------------------------- FIN PREDICAT JOUER COUP -------------------------------------------%







