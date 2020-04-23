member1(X, [X|_]).
member1(X, [_|T]):- member1(X,T).

append1([], L, L).
append1([H|T], L, [H|R]):-append1(T, L, R).

delete(X, [X|T], T).
delete(X, [H|T], [H|R]):-delete(X, T, R).
delete(_, [], []).

delete_all(X, [X|T], R):-delete_all(X, T, R).
delete_all(X, [H|T], [H|R]):-delete_all(X, T, R).
delete_all(_, [], []).

append3(L1,L2,L3,R):-
	append1(L1,L2,R1),
	append1(R1,L3,R).
	
prepend(X,L,R):-
	append1([X],L,R).
	
sum(L,R):-sum(L,0,R).
sum([],SF,SF).
sum([H|T],SP,SF):-
	SP1 is SP+H,
	sum(T,SP1,SF).

separate_parity(L,E,O):-separate_parity(L,E,[],O,[]).
separate_parity([],E,E,O,O).
separate_parity([H|T],E,EP,O,OP):-
	M is mod(H,2),
	M=0,
	append1(EP,[H],EP1),
	separate_parity(T,E,EP1,O,OP).
separate_parity([H|T],E,EP,O,OP):-
	M is mod(H,2),
	M=1,
	append1(OP,[H],OP1),
	separate_parity(T,E,EP,O,OP1).


remove_duplicates(L,R):-remove_duplicates(L,[],R).
remove_duplicates([],FR,FR).
remove_duplicates([H|T],PR,FR):-
	member1(H,T),
	remove_duplicates(T,PR,FR).
remove_duplicates([H|T],PR,FR):-
	not(member1(H,T)),
	append1(PR,[H],PR1),
	remove_duplicates(T,PR1,FR).

replace_all(K,NK,L,R):-replace_all(K,NK,L,[],R).
replace_all(_,_,[],FR,FR).
replace_all(K,NK,[H|T],PR,FR):-
	H=K,
	append1(PR,[NK],PR1),
	replace_all(K,NK,T,PR1,FR).
replace_all(K,NK,[H|T],PR,FR):-
	not(H=K),
	append1(PR,[H],PR1),
	replace_all(K,NK,T,PR1,FR).

drop_k(L,K,R):-drop_k(L,K,1,[],R).
drop_k([],_,_,FR,FR).
drop_k([_|T],K,N,PR,FR):-
	M is mod(N,K),
	M=0,
	N1 is N+1,
	drop_k(T,K,N1,PR,FR).
drop_k([H|T],K,N,PR,FR):-
	M is mod(N,K),
	not(M=0),
	N1 is N+1,
	append1(PR,[H],PR1),
	drop_k(T,K,N1,PR1,FR).




	

	

	
	