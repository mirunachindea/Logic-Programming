% MEMBER
member1(X, [X|_]):-!.
member1(X, [_|T]):-member1(X, T).

% DELETE
delete(X,[X|T],T):-!.
delete(X,[H|T],[H|R]):-delete(X,T,R).
delete(_,[],[]).

% LENGTH
% backward 
length1([],0).
length1([_|T],Len):-
	length1(T,Len1),
	Len is Len1+1.

% forward
length2_acc([],Acc,Res):-Res=Acc.
length2_acc([_|T],Acc,Res):-
	Acc1 is Acc+1,
	length2_acc(T,Acc1,Res).

length2(L,Res):-length2_acc(L,0,Res).

% REVERSE
% backward
reverse1([],[]).
reverse1([H|T],Res):-
	reverse1(T,Res1),
	append(Res1,[H],Res).

%forward
reverse2_acc([],R,R).
reverse2_acc([H|T],RP,RF):-
	reverse2_acc(T, [H|RP],RF).

reverse2(L,R):-reverse2_acc(L,[],R).

% MINIMUM
% forward
minimum1([], M, M).
minimum1([H|T], MP, M):-H<MP, minimum1(T, H, M).
minimum1([_|T], MP, M):-minimum1(T, MP, M).
minimum1([H|T],R):-minimum1([H|T],H,R).
% 4.7. each query has only one answer

% backward
minimum_bwd([H], H).
minimum_bwd([H|T], M):-minimum_bwd(T, M), H>=M.
minimum_bwd([H|T], H):-minimum_bwd(T, M), H<M.

minimum2([H|T],M):-minimum2(T,M),H>=M,!.
minimum2([H|_],H).

% in the case of forward recursion, the minimum is initialized with
% the first element of the list, while on backward recursion, min
% is initialized with the last element of the list

% MAXIMUM
% forward
maximum1([], M, M).
maximum1([H|T], MP, M):-H>MP, !, maximum1(T, H, M).
maximum1([_|T], MP, M):-maximum1(T, MP, M).
maximum1([H|T],R):-maximum1([H|T],H,R).


% UNION
union([H|T],L2,R):-member(H,L2),!,union(T,L2,R).
union([H|T],L,[H|R]):-union(T,L,R).
union([],L,L).

% INTERSECTION
inters([H|T],L2,RP,RF):-
	% if H of first list is in second list
	member(H,L2),!,
	% we add the element to  the partial result
	append(RP,[H],RP1),
	% and process the tail of the first list
	inters(T,L2,RP1,RF).
% if H of first list is not in second list
inters([_|T],L2,RP,RF):-inters(T,L2,RP,RF).
inters([],_,R,R).
inters(L1,L2,R):-inters(L1,L2,[],R).


% DIFFERENCE
difference([H|T],L2,RP,RF):-
	% if H of first list is in second list
	member(H,L2),!,
	% process the tail
	difference(T,L2,RP,RF).
% if H of first list is not in second list
difference([H|T],L,RP,RF):-
	% add the element to partial result list
	append(RP,[H],RP1),
	difference(T,L,RP1,RF).
difference([],_,R,R).
difference_pretty(L1,L2,R):-difference(L1,L2,[],R).


% 4.4
% q4-1.
find_del_min(L,R):-
	% find the minimum
	minimum1(L,M),
	% delete its first occurence
	delete(M,L,R).

% q4-2.
% I used a counter initialized to 1 and a partial result list
revk(L,K,RF):-revk(L,K,1,[],RF).
revk(L,K,Cnt,RP,RF):-
	% if we reach the kth element
	K=Cnt,!,
	% reverse the list
	reverse2(L,Rev),
	% append the list to the partial result
	append(RP,Rev,RP1),
	% call the predicate for the empty list, to return the result
	revk([],K,Cnt,RP1,RF).
revk([H|T],K,Cnt,RP,RF):-
	append(RP,[H],RP1),
	Cnt1 is Cnt+1,
	revk(T,K,Cnt1,RP1,RF).
revk([],_,_,R,R).

% q4-3.
find_del_max(L,R):-
	% find the maximum
	maximum1(L,M),
	% delete its first occurence
	delete(M,L,R).

% 4.5
% q4-1.
rle_encode([H|T],R):-rle([H|T],H,0,[],R).
rle([H|T],Prev,Cnt,RP,RF):-
	% if it is the same element as previous, increment Cnt
	H=Prev,!,
	Cnt1 is Cnt+1,
	% prev -> actual
	rle(T,H,Cnt1,RP,RF).
rle([H|T],Prev,Cnt,RP,RF):-
	% if the element changed, construct a list [element, no_occ]
	append([Prev],[Cnt],L),
	% put the list in the partial result list
	append(RP,[L],RP1),
	rle(T,H,1,RP1,RF).
rle([],Prev,Cnt,RP,RF):-
	% if we reach end of list, we have one more element to add to the result
	append([Prev],[Cnt],L),
	append(RP,[L],RF).

% q4-2
% rotate once
rotate_right(L,R):- 
	rotate_right(L,R1,H), 
	R=[H|R1].
rotate_right([H|T],L,R) :- 
	rotate_right(T,T1,R), 
	L=[H|T1].
rotate_right([H],[],H).

% rotate k times
rotate_right_k(L,K,RF):-
	K>0,
	rotate_right(L,R1),
	K1 is K-1,
	rotate_right_k(R1,K1,RF).
rotate_right_k(L,0,L).
rotate_right_k([],_,[]).

% q4-3.
% get the element at a position
getpos([H|_],0,H).
getpos([_|T],Pos,E):-
	Pos>0,
	Pos1 is Pos-1,
	getpos(T,Pos1,E).

% delete the element at specified position
deletepos(L,P,R):-deletepos(L,P,[],R).
deletepos([],_,R,R).
deletepos([_|T],P,PR,FR):-
	P=0,!,
	append(PR,T,PR1),
	deletepos([],P,PR1,FR).
deletepos([H|T],P,PR,FR):-
	append(PR,[H],PR1),
	P1 is P-1,
	deletepos(T,P1,PR1,FR).

rnd_select(L,K,R):-rnd_select(L,K,[],R).
rnd_select(_,0,R,R).
rnd_select(L,K,RP,RF):-
	K>0,
	K1 is K-1,
	length1(L,Len),
	MaxPos is Len-1,
	Pos is random(MaxPos),
	% luam elementul de la pozitia Pos
	getpos(L,Pos,El),
	% punem elementul in lista noua
	append(RP,[El],RP1),
	% stergem elementul din lista
	deletepos(L,Pos,NL),
	rnd_select(NL,K1,RP1,RF).


