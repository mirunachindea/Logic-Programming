tree1(t(6, t(4, t(2, nil, nil), t(5, nil, nil)), t(9, t(7, nil, nil), nil))).
tree2(t(8, t(5, nil, t(7, nil, nil)), t(9, nil, t(11, nil, nil)))).
tree3(t(6, t(4, t(2,nil,nil,nil), t(7,nil,nil,nil),nil), 
		t(5,nil,nil,nil),
		t(9, t(3,nil,nil,nil),nil,nil))).
% 1. Tree traversal
inorder(t(K,L,R), List):-inorder(L,LL), inorder(R, LR),
		append(LL, [K|LR],List).
inorder(nil, []).

preorder(t(K,L,R), List):-preorder(L,LL), preorder(R, LR),
		append([K|LL], LR, List).
preorder(nil, []).

postorder(t(K,L,R), List):-postorder(L,LL), postorder(R, LR),
		append(LL, LR,R1), append(R1, [K], List).
postorder(nil, []).

% 2. Pretty print
% inorder traversal
pretty_print(nil, _).
pretty_print(t(K,L,R), D):-D1 is D+1, pretty_print(L, D1), print_key(K, D),
		pretty_print(R, D1).
% predicate which prints key K at D tabs from the screen left margin 
% and then proceeds to a new line	
print_key(K, D):-D>0, !, D1 is D-1, write('\t'), print_key(K, D1).
print_key(K, _):-write(K), nl.

% 3. Search for key
search_key(Key, t(Key, _, _)):-!.
search_key(Key, t(K, L, _)):-Key<K, !, search_key(Key, L).
search_key(Key, t(_, _, R)):-search_key(Key, R).

% 4. Insert a key
insert_key(Key, nil, t(Key, nil, nil)):-write('Inserted '), write(Key), nl.
insert_key(Key, t(Key, L, R), t(Key, L, R)):-!, write('Key already in tree\n').
insert_key(Key, t(K, L, R), t(K, NL, R)):-Key<K, !, insert_key(Key, L, NL).
insert_key(Key, t(K, L, R), t(K, L, NR)):- insert_key(Key, R, NR).

% 5. Delete a key
delete_key(Key, nil, nil):-write(Key), write(' not in tree\n').
 % this clause covers also case for leaf (L=nil)
delete_key(Key, t(Key, L, nil), L):-!.
delete_key(Key, t(Key, nil, R), R):-!.
delete_key(Key, t(Key, L, R), t(Pred, NL, R)):-!, get_pred(L, Pred, NL).
delete_key(Key, t(K, L, R), t(K, NL, R)):-Key<K, !, delete_key(Key, L, NL).
delete_key(Key, t(K, L, R), t(K, L, NR)):- delete_key(Key, R, NR).
get_pred(t(Pred, L, nil), Pred, L):-!.
get_pred(t(Key, L, R), Pred, t(Key, L, NR)):-get_pred(R, Pred, NR).

% 6. Height of binary tree
% predicate which computes the maximum between 2 numbers
max(A, B, A):-A>B, !.
max(_, B, B).
% predicate which computes the height of a binary tree
height(nil, -1).
height(t(_, L, R), H):-height(L, H1), height(R, H2), max(H1, H2, H3),
	H is H3+1.

% 7. Ternary trees pretty print
% preorder traversal
pretty_print3(nil, _).
pretty_print3(t(K,L,M,R), D):-D1 is D+1,  print_key(K, D),
	pretty_print3(L, D1), pretty_print3(M, D1), pretty_print3(R, D1).

% 8. Ternary tree traversal
inorder3(t(K,L,M,R), List):-inorder3(L,LL), inorder3(M,LM), inorder3(R, LR),
		append(LL, [K|LM],List1), append(List1,LR,List).
inorder3(nil, []).

preorder3(t(K,L,M,R), List):-preorder3(L,LL), preorder3(M,LM), preorder3(R, LR),
		append([K|LL], LM, List1), append(List1,LR,List).
preorder3(nil, []).

postorder3(t(K,L,M,R), List):-postorder3(L,LL), postorder3(M,LM), postorder3(R, LR),
		append(LL,LM,R1), append(R1,LR,R2),append(R2, [K], List).
postorder3(nil, []).

% 9. Ternary tree height
height3(nil, -1).
height3(t(_, L, M, R), H):-height3(L, H1), height3(M, H2), height3(R, H3),
 	max(H1, H2, HP), max(HP, H3, HM), H is HM+1.

% quiz ex 1
inorderprint(t(K,L,R)):-inorderprint(L), write(K), write(' '),inorderprint(R).
inorderprint(nil).

% quiz ex 2
delete_key2(Key, nil, nil):-write(Key), write(' not in tree\n').
delete_key2(Key, t(Key, L, nil), L):-!.
delete_key2(Key, t(Key, nil, R), R):-!.
delete_key2(Key, t(Key, L, R), Res):- hang(R, L, Res).
delete_key2(Key, t(K, L, R), t(K, NL, R)):-Key<K, !, delete_key2(Key, L, NL).
delete_key2(Key, t(K, L, R), t(K, L, NR)):- delete_key2(Key, R, NR).
 
hang(t(K,nil,nil), H, t(K, H, nil)).
hang(t(K,L,R), H, t(K,L,R)):-hang(L, H, t(K,L,R)).

% quiz ex 3
leaves(nil, []).
leaves(t(K,nil,nil), [K]).
leaves(t(_,L,R), Res):- leaves(L,LL), leaves(R,LR), append(LL,LR,Res).

% problem 1
diam(nil, -1).
diam(t(_, L, R), D):-
	diam(L,DL), diam(R,DR),
	height(L, H1), height(R, H2), H is H1+H2+2,
	max(DL,DR,M1),
	max(M1,H,D).

% problem 3
mirror(nil,nil).
mirror(t(_,L1,R1),t(_,L2,R2)):-mirror(L1,R2), mirror(L2,R1).
symmetric(nil).
symmetric(t(_,L,R)):-mirror(L,R).