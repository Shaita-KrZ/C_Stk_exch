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
 
 % Predicat longueur : permet de connaitre le nombre d'element d'une liste
 longueur([[_,vide]|Q],N):-longueur(Q,N).
 longueur([_|Q],N):-longueur(Q,N1),N is N1+1.
 longueur([],0).

 % Predicat supprimer element : permet de supprimer un element d'une liste
 supprimer_element([T|Q],PositionDebut,PositionX,[T|Q1]):-PositionDebut<PositionX,Position1 is PositionDebut+1,supprimer_element(Q,Position1,PositionX,Q1).
 supprimer_element([_|Q],PositionDebut,PositionX,Q):-PositionDebut>=PositionX.
 
 
% -------------------------------- FIN PREDICAT GENERALE -------------------------------------%

% -------------------------------- PREDICAT BOURSE -------------------------------------------%

% initialisation de la bourse
bourse([[ble,7],[riz,6],[cacao,6],[cafe,6],[sucre,6],[mais,6]]).

% affichage de la bourse 
afficher_bourse([T|Q]):-afficher_liste([T|Q]).

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


afficher_tas([T|Q]):-afficher_liste([T|Q]).

% -------------------------------- FIN PREDICAT MARCHANDISE -------------------------------------------%

% -------------------------------- PREDICAT TRADER -------------------------------------------%

% initialisation du trader
trader(X):- random(0,9,X).
afficher_trader(X):-write(X).

% -------------------------------- FIN PREDICAT TRADER -------------------------------------------%

% -------------------------------- PREDICAT RESERVE JOUEUR -------------------------------------------%

reserve_joueur1([]).
reserve_joueur2([]).
afficher_joueur1([]):-write('La reserve du joueur 1 est vide').
afficher_joueur1([T|Q]):-afficher_sous_liste([T|Q]).
afficher_joueur2([]):-write('La reserve du joueur 2 est vide').
afficher_joueur2([T|Q]):-afficher_sous_liste([T|Q]).

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

plateau_depart([Marchandise, Bourse, PositionTrader, RJ1, RJ2]):-trader(PositionTrader),marchandise(1,9,[],Marchandise),bourse(Bourse),reserve_joueur1(RJ1),reserve_joueur2(RJ2).

% -------------------------------- FIN PREDICAT PLATEAU -------------------------------------------%

% -------------------------------- PREDICAT PLATEAU DEPART -------------------------------------------%

% Algorithme plateau_depart
% Algorithme qui affiche les differents parametres du plateau.

afficher_plateau([Marchandise, Bourse, PositionTrader, RJ1, RJ2]):-
	write('La reserve du joueur 1: '),nl,
	afficher_joueur1(RJ1),nl,
	write('***************************'),nl,
	write('La reserve du joueur 2: '),nl,
	afficher_joueur2(RJ2),nl,
	write('***************************'),nl,
	write('Le tas est :'),nl,
	afficher_tas(Marchandise),
	write('***************************'),nl,
	write('La bourse actuel est :'),nl,
	afficher_bourse(Bourse),
	write('***************************'),nl,
	write('Le trader est a la position :'),nl,
	afficher_trader(PositionTrader),nl.
	
% -------------------------------- FIN PREDICAT PLATEAU DEPART -------------------------------------------%

% -------------------------------- PREDICAT PARCOURIR MARCHANDISE -------------------------------------------%

% Liste Marchandise : [[0,ble,riz,ble,riz],[1,ble,sucre,riz,cacao],[2,ble,cafe,ble,cacao],[3,riz,sucre,cafe,sucre],[4,ble,cafe,ble,cacao],[5,sucre,ble,sucre,cacao],[6,riz,ble,riz,cafe],[7,riz,sucre,riz,cafe],[8,sucre,ble,riz,ble]]

% parcourir_marchandise_sautantvide(listeMarchandises,0,PositionXdeb,PositionX,listeMarchandises,tas).
% Algorithme parcourir_marchandise : permet de recuperer le tas correspondant la positionX
% Paramètre : [_|Q] : represente la liste des marchandises, PositionXdeb est la position du trader avant le deplacement,
% PositionX est la position du Trader apres le deplecement, Tas le tas a recuperer a la position du nouveau Trader

parcourir_marchandise_sautantvide([T|Q],PositionDebut,PositionXdeb,PositionX,Marchandise,Tas):-PositionDebut>=PositionXdeb,parcourir_marchandise_sautantvide2([T|Q],PositionXdeb,PositionX,Marchandise,Tas).
parcourir_marchandise_sautantvide([_|Q],PositionDebut,PositionXdeb,PositionX,Marchandise,Tas):-PositionDebut<PositionXdeb,Position1 is PositionDebut+1,parcourir_marchandise_sautantvide(Q,Position1,PositionXdeb,PositionX,Marchandise,Tas).

parcourir_marchandise_sautantvide2([[_,vide]|Q],PositionXdeb,PositionX,Marchandise,Tas):-parcourir_marchandise_sautantvide2(Q,PositionXdeb,PositionX,Marchandise,Tas).
parcourir_marchandise_sautantvide2([_|Q],PositionXdeb,PositionX,Marchandise,Tas):-PositionXdeb<PositionX, Position1 is PositionXdeb+1,parcourir_marchandise_sautantvide2(Q,Position1,PositionX,Marchandise,Tas).
parcourir_marchandise_sautantvide2([T|_],PositionXdeb,PositionX,_,Tas):-PositionXdeb>=PositionX,affecter_liste(Tas,T).
parcourir_marchandise_sautantvide2([],PositionXdeb,PositionX,Marchandise,Tas):-parcourir_marchandise_sautantvide2(Marchandise,PositionXdeb,PositionX,Marchandise,Tas).


%parcourir_marchandise([_|Q],PositionDebut,PositionX,Tas):-PositionDebut<PositionX,Position1 is PositionDebut+1,parcourir_marchandise(Q,Position1,PositionX,Tas).%
%parcourir_marchandise([T|_],PositionDebut,PositionX,Tas):-PositionDebut>=PositionX,affecter_liste(Tas,T).

% -------------------------------- FIN PREDICAT PARCOURIR MARCHANDISE -------------------------------------------%

% ------------------------------- PREDICAT SUPPRIMER MARCHANDISE --------------------------------- %

% Algorithme supprimer_marchandise :
% Paramètre : Liste dess Tas ([T|Q]), PositionDebut (=0), PositionX (Tas dans lequel on veut supprimer un element), Liste Resultat avec la marchandise supprimer ([T|Q1])
% On boucle de PositionDebut a Position X|
% On rapelle a chaque fois supprimer_marchandise avec la suite des tas
% Lorsque la boucle est terminé, on affecte le reste des marchandise Q et on supprime la premiere marchandise 
% En remontant, on recupere les tas parcourus


supprimer_marchandise([T|Q],PositionDebut,PositionX,[T|Q1]):-PositionDebut<PositionX,Position1 is PositionDebut+1,supprimer_marchandise(Q,Position1,PositionX,Q1).
supprimer_marchandise([[T,_]|Q],PositionDebut,PositionX,[[T,vide]|Q]):-PositionDebut>=PositionX.
supprimer_marchandise([[T|[_|Q2]]|Q],PositionDebut,PositionX,[[T|Q2]|Q]):-PositionDebut>=PositionX.



% ------------------------------- FIN PREDICAT SUPPRIMER MARCHANDISE --------------------------------- %

% ------------------------------- PREDICAT DECREMENTER BOURSE --------------------------------- %


decrementer_bourse(Marchandise,[[Marchandise,Nombre]|Q],[[Marchandise,Nombre1]|Q]):-Nombre1 is Nombre-1.
decrementer_bourse(Marchandise,[[T,Nombre]|Q],[[T,Nombre]|Q1]):-decrementer_bourse(Marchandise,Q,Q1).

% ------------------------------- FIN PREDICAT DECREMENTER BOURSE --------------------------------- %

% -------------------------------- PREDICAT COUP_POSSIBLE -------------------------------------------%

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

% Predicat qui permet dans le cas ou la positionduTrader est egale a 0 et que du coup le MouvementAvant(=PositionTrader-1) est egale a -1, il devient egale a 8 (=dernier element).
moins_un(X,Y):-egalite(X,-1),Y is 8,!.
moins_un(X,X).

coup_possible([Marchandise,_,PositionTrader,_,_], [_,Deplacement,March_gardee,March_vendu]):-
Deplacement=<3,Deplacement>=1,
PositionApres is PositionTrader+Deplacement+1,
PositionAvant is PositionTrader+Deplacement-1,
parcourir_marchandise_sautantvide(Marchandise,0,PositionTrader,PositionApres,Marchandise,[_|[T|_]]),
parcourir_marchandise_sautantvide(Marchandise,0,PositionTrader,PositionAvant,Marchandise,[_|[X|_]]),
(egalite(March_gardee,X),egalite(March_vendu,T) ; egalite(March_gardee,T),egalite(March_vendu,X)),!.
coup_possible(_,_):-write('Le coup jouer comporte une erreur'),nl,fail,!.

% -------------------------------- FIN PREDICAT COUP_POSSIBLE -------------------------------------------%

% -------------------------------- PREDICAT JOUER COUP -------------------------------------------%

% Algorithme jouer_coup
% Paramètre : Le plateau, le coup, Le nouveau PLateau
% On test d'abord si le coup est possible
% On calcul la nouvelle Position du Trader
% On supprime les marchandises gardee et vendu
% Si joueur 1, on ajoute la marchandise a la reserve du joueur 1
% Si joueur 2, on ajoute la marchandise a la reserve du joueur 2
% On decremente ensuite la valeur de la marchandise dans la bourse


jouer_coup([Marchandise,Bourse,PositionTrader,RJ1,RJ2],[Joueur,Deplacement,March_gardee,March_vendu],
[NouveauMarchandise,NouveauBourse,_,NouveauRJ1,NouveauRJ2],PositionAvant,PositionApres):-
coup_possible([Marchandise, Bourse, PositionTrader, RJ1, RJ2],[Joueur,Deplacement,March_gardee,March_vendu]),
supprimer_marchandise(Marchandise,0,PositionAvant,ListeResultat1),
supprimer_marchandise(ListeResultat1,0,PositionApres,NouveauMarchandise),
(egalite(Joueur,'j1'),ajouter_element(March_gardee,RJ1,NouveauRJ1),egalite(NouveauRJ2,RJ2); egalite(Joueur,'j2'),ajouter_element(March_gardee,RJ2,NouveauRJ2),egalite(NouveauRJ1,RJ1)),
decrementer_bourse(March_vendu,Bourse,NouveauBourse).

% -------------------------------- FIN PREDICAT JOUER COUP -------------------------------------------%

<<<<<<< HEAD

% -------------------------------- PREDICAT START JEU -------------------------------------------%s

% start jeu
% Initialise le plateau
% choisi le premier joueur au hasard entre le joueur 1 et 2

start_jeu(_):-
plateau_depart([Marchandise,Bourse,PositionTrader,RJ1,RJ2]),
random(1,3,X),nl,
(egalite(X,1),egalite(Joueur,'j1') ; egalite(X,2),egalite(Joueur,'j2')),
boucle_jeu([Marchandise,Bourse,PositionTrader,RJ1,RJ2],Joueur).

boucle_jeu([Marchandise,Bourse,PositionTrader,RJ1,RJ2],Joueur):-
longueur(Marchandise,N),
N>2,
afficher_plateau([Marchandise,Bourse,PositionTrader,RJ1,RJ2]),
write('Longueur :'),write(N),nl,
(egalite(Joueur,'j1'),write('Le joueur 1 joue'),egalite(NouveauJoueur,'j2') ; egalite(Joueur,'j2'),write('Le joueur 2 joue'),egalite(NouveauJoueur,'j1')),nl,
write('De combien de cases voulez-vous deplacer le trader (1, 2, 3) ?'),nl,
read(Deplacement),
PosTrader is PositionTrader+Deplacement,
parcourir_marchandise_sautantvide(Marchandise,0,PositionTrader,PosTrader,Marchandise,[NouveauPositionTrader|_]),
MouvementApres is PosTrader+1,
MouvementAvant is PosTrader-1,
parcourir_marchandise_sautantvide(Marchandise,0,PositionTrader,MouvementApres,Marchandise,[PositionApres|[MarchApres|_]]),
parcourir_marchandise_sautantvide(Marchandise,0,PositionTrader,MouvementAvant,Marchandise,[PositionAvant|[MarchAvant|_]]),
write('Le Trader est maintenant a la position: '),nl,
write(NouveauPositionTrader),nl,
write('Quel Marchandise voulez-vous garder ?'),nl,
write(PositionAvant),write(': '),write(MarchAvant),
write(' ou '),
write(PositionApres),write(': '),write(MarchApres),nl,
read(MarchGardee),
write('Quel Marchandise voulez-vous vendre ?'),nl,
write(PositionAvant),write(': '),write(MarchAvant),
write(' ou '),
write(PositionApres),write(': '),write(MarchApres),nl,
read(MarchVendu),
nl,nl,nl,
jouer_coup([Marchandise,Bourse,PositionTrader,RJ1,RJ2],[Joueur,Deplacement,MarchGardee,MarchVendu],[NouveauMarchandise,NouveauBourse,NouveauPositionTrader,NouveauRJ1,NouveauRJ2],PositionAvant,PositionApres),
boucle_jeu([NouveauMarchandise,NouveauBourse,NouveauPositionTrader,NouveauRJ1,NouveauRJ2],NouveauJoueur).

boucle_jeu([Marchandise,Bourse,_,RJ1,RJ2],_):-
afficher_bourse(Bourse),nl,
write('Reserve du joueur 1 : '),nl,
afficher_joueur1(RJ1),nl,
write('Reserve du joueur 2 : '),nl,
afficher_joueur2(RJ2),nl,
write('********************************'),nl,
write('La partie est fini'),nl,
write('Comptez vos points en fonction des matieres possedées et de leur valeur en bourse'),nl,
write('Celui qui a le plus de point gagne').


% -------------------------------- PREDICAT COUP_POSSIBLES -------------------------------------------%


long(0, []).
long(Long, [_|Q]):-long(Long2, Q), Long is Long2 + 1.

concatanate([],L,L).
concatanate([T|Q], L, [T|R]):-concatanate(Q,L,R).


/*
    Algorithme coups possibles:
    Parametres: Plateau
    Retour: Liste des Coups possibles.
    
    A chaque tour, le joueur peut se déplacer de 1,2 ou 3 cases. En fonction de son déplacement
    le joueur gardera la ressource située sur le tas de gauche et vendra celle située sur le tas
    de droite, ou il fera l'inverse.
*/

coups_possibles([H, B, T, J1, J2],ListeCoupsPossibles):-
    long(L,H) ,
    T1 is T + 1 ,
    L1 is L + 1,
    modulo(T1,L1,MouvementModulo),
    MouvementApres is MouvementModulo+1,
    modulo(MouvementApres,L1,MouvementModuloApres),
    MouvementAvant is MouvementModulo-1,
    modulo(MouvementAvant,L1,MouvementModuloAvant),
    parcourir_marchandise(H,0, MouvementModuloAvant, [_|[TG|_]]),
    parcourir_marchandise(H,0, MouvementModuloApres, [_|[TD|_]]),
    concatanate([],[[joueur1, T1, TG, TD]],ListeCoupsPossibles1),
    concatanate(ListeCoupsPossibles1,[[joueur2, 1, TG, TD]],ListeCoupsPossibles2),
    concatanate(ListeCoupsPossibles2,[[joueur1, 1, TD, TG]],ListeCoupsPossibles3),
    concatanate(ListeCoupsPossibles3,[[joueur2, 1, TD, TG]],ListeCoupsPossibles4),
    T2 is T + 2,
    modulo(T2,L1,MouvementModulo2),
    MouvementApres2 is MouvementModulo2+1,
    modulo(MouvementApres2,L1,MouvementModuloApres2),
    MouvementAvant2 is MouvementModulo2-1,
    modulo(MouvementAvant2,L1,MouvementModuloAvant2),
    parcourir_marchandise(H,0, MouvementModuloAvant2, [_|[TG2|_]]),
    parcourir_marchandise(H,0, MouvementModuloApres2, [_|[TD2|_]]),
    concatanate(ListeCoupsPossibles4,[[joueur1, 2, TG2, TD2]],ListeCoupsPossibles5),
    concatanate(ListeCoupsPossibles5,[[joueur2, 2, TG2, TD2]],ListeCoupsPossibles6),
    concatanate(ListeCoupsPossibles6,[[joueur1, 2, TD2, TG2]],ListeCoupsPossibles7),
    concatanate(ListeCoupsPossibles7,[[joueur2, 2, TD2, TG2]],ListeCoupsPossibles8),
    T3 is T + 3,
    modulo(T3,L1,MouvementModulo3),
    MouvementApres3 is MouvementModulo3+1,
    modulo(MouvementApres3,L1,MouvementModuloApres3),
    MouvementAvant3 is MouvementModulo3-1,
    modulo(MouvementAvant3,L1,MouvementModuloAvant3),
    parcourir_marchandise(H,0, MouvementModuloAvant3, [_|[TG3|_]]),
    parcourir_marchandise(H,0, MouvementModuloApres3, [_|[TD3|_]]),
    concatanate(ListeCoupsPossibles8,[[joueur1, 3, TG3, TD3]],ListeCoupsPossibles9),
    concatanate(ListeCoupsPossibles9,[[joueur2, 3, TG3, TD3]],ListeCoupsPossibles10),
    concatanate(ListeCoupsPossibles10,[[joueur1, 3, TD3, TG3]],ListeCoupsPossibles11),
    concatanate(ListeCoupsPossibles11,[[joueur2, 3, TD3, TG3]],ListeCoupsPossibles), writeln(ListeCoupsPossibles).

% -------------------------------- FIN PREDICAT COUP_POSSIBLES -------------------------------------------%
