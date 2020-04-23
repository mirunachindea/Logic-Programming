woman(ana).
woman(sara).
woman(ema).
woman(maria).
woman(carmen).
woman(dorina).
woman(irina).

man(andrei).
man(george).
man(alex).
man(marius).
man(mihai).
man(sergiu).

parent(sergiu, mihai).
parent(marius, maria).
parent(dorina, maria).
parent(mihai, george).
parent(mihai, carmen).
parent(irina, george).
parent(irina, carmen).
parent(maria,ana).
parent(maria, andrei).
parent(george,ana).
parent(george,andrei).
parent(carmen, sara).
parent(carmen, ema).
parent(alex, sara).
parent(alex, ema).

mother(X,Y):-woman(X), parent(X,Y).

father(X,Y):-man(X), parent(X,Y).

sibling(X,Y):-parent(Z,X), parent(Z,Y), X\=Y.

sister(X,Y):-sibling(X,Y), woman(X).

aunt(X,Y):-sister(X,Z), parent(Z, Y).

brother(X,Y):-sibling(X,Y), man(X).

uncle(X,Y):-brother(X,Z), parent(Z,Y).

grandmother(X,Y):-mother(X,Z), parent(Z,Y).

grandfather(X,Y):-father(X,Z), parent(Z,Y).

ancestor(X,Y):-parent(X,Y).
ancestor(X,Y):-parent(X,Z), ancestor(Z,Y).