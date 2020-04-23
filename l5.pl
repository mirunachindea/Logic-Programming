% SORTING METHODS

% 1. Direct sorting methods
% 1.1. Permutation sort
perm_sort(L, R):-perm(L,R), is_ordered(R), !.
perm(L, [H|R]):-
	% extract an element H from L randomly
	append(A, [H|T], L), 
	% recreate the list without H
	append(A, T, L1), 
	perm(L1, R).
perm([], []).
is_ordered([_]).
is_ordered([H1, H2|T]):-H1 =< H2, is_ordered([H2|T]).

% 1.2. Selection sort
minimum([H|T],M):-minimum(T,M),H>=M,!.
minimum([H|_],H).
delete1(X,[X|T],T):-!.
delete1(X,[H|T],[H|R]):-delete1(X,T,R).
delete1(_,[],[]).

sel_sort(L, [M|R]):- minimum(L, M), delete1(M, L, L1), sel_sort(L1, R).
sel_sort([], []).

find_del_min(L,R):-
	minimum(L,M),
	delete1(M,L,R).

% 1.3. Insertion sort
ins_sort([H|T], R):- ins_sort(T, R1), write(R1),insert_ord(H, R1, R).
ins_sort([], []).
% if X > H, recursive call
insert_ord(X, [H|T], [H|R]):-X>H, !, insert_ord(X, T, R).
% if X <= H, prepend
insert_ord(X, T, [X|T]).

% 1.4. Bubble sort
% F - flag - unsorted yet
bubble_sort(L, R):-one_pass(L, R1, F), nonvar(F), !, bubble_sort(R1, R).
bubble_sort(L, L).
one_pass([H1, H2|T], [H2|R], F):- H1>H2, !, F = 1, one_pass([H1|T], R, F).
one_pass([H1|T], [H1|R], F):-one_pass(T, R, F).
one_pass([], [] ,_).

% 2. Advanced Sorting Methods
% 2.1. Quicksort
quick_sort([H|T], R):-partition(H, T, Sm, Lg), quick_sort(Sm, SmS),
quick_sort(Lg, LgS), append(SmS, [H|LgS], R).
quick_sort([], []).
partition(H, [X|T], [X|Sm], Lg):-X<H, !, partition(H, T, Sm, Lg).
partition(H, [X|T], Sm, [X|Lg]):-partition(H, T, Sm, Lg).
partition(_, [], [], []).

% 2.2. Merge sort
merge_sort(L, R):-split(L, L1, L2), merge_sort(L1, R1), merge_sort(L2, R2),
merge(R1, R2, R).
merge_sort([H], [H]).
merge_sort([], []).
% split the list in 2 equal parts
% K = length(L) / 2
split(L, L1, L2):-length(L, Len), Len>1, K is Len/2, splitK(L, K, L1, L2).
% first K elem in L -> L1; the rest -> L2
splitK([H|T], K, [H|L1], L2):- K>0, !, K1 is K-1, splitK(T, K1, L1, L2).
splitK(T, _, [], T).
merge([H1|T1], [H2|T2], [H1|R]):-H1<H2, !, merge(T1, [H2|T2], R).
merge([H1|T1], [H2|T2], [H2|R]):-merge([H1|T1], T2, R).
merge([], L, L).
merge(L, [], L).


% get the element at a position
getpos([H|_],0,H).
getpos([_|T],Pos,E):-
	Pos>0,
	Pos1 is Pos-1,
	getpos(T,Pos1,E).

% q5-2.
maximum([H|T],M):-maximum(T,M),H>=M,!.
maximum([H|_],H).
sel_sort2(L, [M|R]):- minimum(L, M), delete1(M, L, L1), sel_sort2(L1, R).
sel_sort2([], []).

% q5-3.
ins_sort2([],R,R).
ins_sort2([H|T],RP,RF):- 
	insert_ord(H,RP,RP1),
	ins_sort2(T,RP1,RF).

% q5-4.
bubble_sort2(L,R):- length(L,N),bubble_sort2(L,R,N).
bubble_sort2(L, R, N):- N>0, !, 
	N1 is N-1,
	one_pass2(L, R1), bubble_sort2(R1, R, N1).
bubble_sort2(L, L, _).
one_pass2([H1, H2|T], [H2|R]):- H1>H2, !, one_pass2([H1|T], R).
one_pass2([H1|T], [H1|R]):-one_pass2(T, R).
one_pass2([], []).

% p5-1.
sort_chars([H|T], R):-partition2(H, T, Sm, Lg), sort_chars(Sm, SmS),
sort_chars(Lg, LgS), append(SmS, [H|LgS], R).
sort_chars([], []).
partition2(H, [X|T], [X|Sm], Lg):-
	char_code(X,Code_X),
	char_code(H,Code_H),
	Code_X<Code_H, !, partition2(H, T, Sm, Lg).
partition2(H, [X|T], Sm, [X|Lg]):-partition2(H, T, Sm, Lg).
partition2(_, [], [], []).

d(X, [X|T], R):-d(X, T, R).

d(X, [H|T], [H|R]):-d(X, T, R).

d(_, [], []).