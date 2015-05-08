
/* FAITS */
bourse([[ble,7],[riz,6],[cacao,6],[cafe,6],[sucre,6],[mais,6]]).

/*Heap => A suppr une fois randomisé correctement */
heap([[mais,riz,ble,ble],[ble,mais,sucre,riz],[cafe,sucre, cacao,cacao],[cafe,mais,sucre,mais],[cacao,mais,ble,ble],[riz,cafe,sucre,ble],[cafe,ble,sucre,cacao],[mais,cacao,cacao,cafe],[riz,riz,cafe,cacao]]).

all_ressources([mais, mais, mais, mais, mais, mais, ble, ble, ble, ble, ble, ble, cacao, cacao, cacao, cacao, cacao, cacao, riz, riz, riz, riz, riz, riz, cafe, cafe, cafe, cafe, cafe, cafe, sucre, sucre, sucre, sucre, sucre, sucre]).

token(X):- random_member(X, [1,2,3,4,5,6,7,8,9]).

joueur1([]).
joueur2([]).
/* FAITS : FIN */

/* FONCTIONS AUXILIAIRES */
concat([],L,L).
concat([T|Q], L, [T|R]):-concat(Q,L,R).

retire_element(X,[],R).
retire_element(X,[X|Q], Q):-!.
retire_element(X,[T|Q], [T|L]):-retire_element(X,Q,L).


/*create_heap([],H, HF):-finish_heap(H, NB, HF),!.
create_heap(L,H, HF) :-random_member(X,L),concat([X],H,H1), retire_element(X,L,R),create_heap(R,H1, HF).

finish_heap([], 0, HF):-!.
finish_heap([X1, X2, X3, X4|Q], Long, HF):- concat([[X1, X2, X3, X4]], HF, HF1),
                                            finish_heap(Q,Long2, HF1), 
                                            Long is Long2 + 4.
*/

selectN(0,_,[]) :- !.
selectN(N,L,[X|S]) :- N > 0, 
   el(X,L,R), 
   N1 is N-1,
   selectN(N1,R,S).

el(X,[X|L],L).
el(X,[_|L],R) :- el(X,L,R).

group([],[],[]).
group(G,[N1|Ns],[G1|Gs]) :- 
   selectN(N1,G,G1),
   subtract(G,G1,R),
   group(R,Ns,Gs).
   
shuffle_ressources(L, R):-random_permutation(L,R1),group(R1,[6,6,6,6,6,6],R).
   
longueur(0, []).
longueur(Long, [_|Q]):-longueur(Long2, Q), Long is Long2 + 1.

my_heap(H):- all_ressources(Res),shuffle_ressources(Res, H).
/* FONCTIONS AUXILIAIRES : FIN */

/* FONCTIONS DEMANDÉES */


affiche_plateau(P):- bourse(B), heap(H), token(T), joueur1(J1), joueur2(J2), 
                 concat([B, H, T, J1, J2],[],P), 
                 writeln(B),                  
                 writeln(H), 
                 writeln(T), 
                 writeln(J1), 
                 writeln(J2).

/* FONCTIONS DEMANDÉES : FIN */


