% 1. Incomplete lists

% member
% must test explicitly for the end of the list, and fail
member_il(_, L):-var(L), !, fail.
% these 2 clauses are the same as for the member1 predicate
member_il(X, [X|_]):-!.
member_il(X, [_|T]):-member_il(X, T).

% insert
insert_il(X, L):-var(L), !, L=[X|_]. %found end of list, add element
insert_il(X, [X|_]):-!. %found element, stop
insert_il(X, [_|T]):- insert_il(X, T). % traverse input list to reach end/X

% delete
delete_il(_, L, L):-var(L), !. % reached end, stop
delete_il(X, [X|T], T):-!. % found element, remove it and stop
delete_il(X, [H|T], [H|R]):-delete_il(X, T, R). % search for the element

% Incomplete BSTs

% search
search_it(_, T):-var(T), !, fail.
search_it(Key, t(Key, _, _)):-!.
search_it(Key, t(K, L, _)):-Key<K, !, search_it(Key, L).
search_it(Key, t(_, _, R)):-search_it(Key, R).

% insert
insert_it(Key, t(Key, _, _)):-!.
insert_it(Key, t(K, L, R)):-Key<K, !, insert_it(Key, L).
insert_it(Key, t(_, _, R)):- insert_it(Key, R).

% delete
delete_it(Key, T, T):-var(T), !, write(Key), write(' not in tree\n').
delete_it(Key, t(Key, L, R), L):-var(R), !.
delete_it(Key, t(Key, L, R), R):-var(L), !.
delete_it(Key, t(Key, L, R), t(Pred, NL, R)):-!, get_pred(L, Pred, NL).
delete_it(Key, t(K, L, R), t(K, NL, R)):-Key<K, !, delete_it(Key, L, NL).
delete_it(Key, t(K, L, R), t(K, L, NR)):- delete_it(Key, R, NR).

get_pred(t(Pred, L, R), Pred, L):-var(R), !.
get_pred(t(Key, L, R), Pred, t(Key, L, NR)):-get_pred(R, Pred, NR).

% Quiz exercises

% 1. append
append_il(L1, L, L):-var(L1),!.
append_il([H|T], L, [H|R]):-append_il(T, L, R).

% 2. reverse
reverse_il(L,L):-var(L).
reverse_il([H|T],Res):-
	reverse_il(T,Res1),
	append_il(Res1,[H|_],Res).

% 3. transform to complete list
to_complete(L,[]):-var(L),!.
to_complete([H|T],[H|R]):-to_complete(T,R).

% 4. preorder
preorder_it(L, _):-var(L),!.
preorder_it(t(K,L,R), List):-preorder_it(L,LL), preorder_it(R, LR),
		append([K|LL], LR, List).

% 5. height
max(A, B, A):-A>B, !.
max(_, B, B).
height_it(L, -1):-var(L),!.
height_it(t(_, L, R), H):-height_it(L, H1), height_it(R, H2), 
	max(H1, H2, H3), H is H3+1.

% 6. transform to complete BST
to_complete_it(L,nil):-var(L),!.
to_complete_it(t(K,L,R),t(K,NL,NR)):-
	to_complete_it(L,NL),to_complete_it(R,NR).

% Problems

% 1. flatten Incomplete list
flatten_il(L,_):-var(L),!.
flatten_il([H|T],[H|R]):-atomic(H),!,flatten_il(T,R).
flatten_il([H|T],R):-flatten_il(H,R1),flatten_il(T,R2),append(R1,R2,R).


% 2. diameter of bst
diam_it(L, -1):-var(L),!.
diam_it(t(_, L, R), D):-
	diam_it(L,DL), diam_it(R,DR),
	height_it(L, H1), height_it(R, H2), H is H1+H2+2,
	max(DL,DR,M1),
	max(M1,H,D).

% 3. det if an incomplete list is sub-list in another incomplete list
% keep an extra argument for initial sublist
subl_il(SL,L):-subl_il(SL,L,SL).
% if we reach the end of sublist => yes
subl_il(L,_,_):-var(L),!.
% if we reach the end of list => fail
subl_il(_,L,_):-var(L),!,fail.
% if H coincide, apply to tail of sublist
subl_il([H|T1],[H|T2],IL):-subl_il(T1,T2,IL),!.
% if H do not coincide, apply to entire sublist again 
subl_il(_,[_|T2],IL):-subl_il(IL,T2).
