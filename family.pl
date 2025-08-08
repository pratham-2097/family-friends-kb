male(vivek).
male(raghav).
male(mahesh).
male(arjun).
male(raj).
male(dev).
male(pratham).
male(aarav).
male(ramesh).

female(roopa).
female(kirthana).
female(anita).
female(sangeeta).
female(diya).
female(meera).
female(kavya).
female(neha).
female(priya).
female(lakshmi).

married(vivek, roopa).
married(raghav, anita).
married(mahesh, sangeeta).
married(arjun, meera).
married(raj, neha).
married(ramesh, lakshmi).

parent(ramesh, vivek).
parent(lakshmi, vivek).
parent(ramesh, raghav).
parent(lakshmi, raghav).
parent(ramesh, mahesh).
parent(lakshmi, mahesh).

parent(vivek, pratham).
parent(roopa, pratham).
parent(vivek, kirthana).
parent(roopa, kirthana).

parent(raghav, aarav).
parent(anita, aarav).

parent(mahesh, diya).
parent(sangeeta, diya).

parent(arjun, kavya).
parent(meera, kavya).

friend_of(pratham, kavya).
friend_of(aarav, dev).
friend_of(diya, priya).

likes(pratham, cricket).
likes(pratham, chess).
likes(kirthana, dance).
likes(roopa, cooking).
likes(vivek, chess).
likes(raghav, cricket).
likes(mahesh, music).
likes(anita, cooking).
likes(sangeeta, baking).
likes(aarav, cricket).
likes(diya, chess).
likes(kavya, dance).
likes(arjun, music).
likes(meera, baking).
likes(raj, chess).
likes(neha, yoga).
likes(dev, cricket).
likes(priya, chess).

spouse(X,Y) :- married(X,Y) ; married(Y,X).
mother(X,Y) :- female(X), parent(X,Y).
father(X,Y) :- male(X), parent(X,Y).

sibling(X,Y) :- parent(P,X), parent(P,Y), X \= Y.
brother(X,Y) :- male(X), sibling(X,Y).
sister(X,Y) :- female(X), sibling(X,Y).

grandparent(X,Z) :- parent(X,Y), parent(Y,Z).
ancestor(X,Z) :- parent(X,Z).
ancestor(X,Z) :- parent(X,Y), ancestor(Y,Z).

cousin(X,Y) :- parent(A,X), parent(B,Y), sibling(A,B), X \= Y.

sibling_in_law(X,Y) :- spouse(X,S), sibling(S,Y).
sibling_in_law(X,Y) :- sibling(X,S), spouse(S,Y).

friend(X,Y) :- friend_of(X,Y) ; friend_of(Y,X).

related(X,Y) :-
    parent(X,Y) ;
    parent(Y,X) ;
    child(X,Y) ;
    child(Y,X) ;
    sibling(X,Y) ;
    spouse(X,Y) ;
    ancestor(X,Y) ;
    ancestor(Y,X) ;
    descendant(X,Y) ;
    descendant(Y,X).

good_match(X,Y,Thing) :-
    likes(X,Thing),
    likes(Y,Thing),
    X \= Y,
    \+ friend(X,Y).

run_demo :-
    setof(S, sibling(pratham,S), Sibs),
    writeln('Siblings of pratham:'), writeln(Sibs),

    setof(C, cousin(pratham,C), Cousins),
    writeln('Cousins of pratham:'), writeln(Cousins),

    setof(A, ancestor(A,pratham), Ancestors),
    writeln('Ancestors of pratham:'), writeln(Ancestors),

    setof(SI, sibling_in_law(roopa,SI), SIs),
    writeln('Sibling-in-law of roopa:'), writeln(SIs),

    setof(Y, good_match(pratham,Y,_), Recs),
    writeln('Friend recommendations for pratham:'), writeln(Recs).
