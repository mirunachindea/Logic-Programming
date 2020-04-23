%% 7.1
%% a. L1 = [1,2,3,[4]].
%% b. L2 = [[1],[2],[3],[4,5]]
%% c. L3 = [[],2,3,4,[5,[6]],[7]].
%% d. L4 = [[[[1]]],1, [1]].
%% e. L5 = [1,[2],[[3]],[[[4]]],[5,[6,[7,[8,[9],10],11],12],13]].
%% f. L6= [alpha, 2,[beta],[gamma,[8]]].

%% a. ? - member( 2 ,L5). 
%% false - L5 doesn't contain atom 2
%% b. ? – member( [2] , L5). 
%% true - L5 contain list [2]
%% c. ? – member(X, L5). 
%% X is matched with first element of L5 => X = 1.
%% d. ? – append(L1,R,L2). 
%% false
%% e. ? – append(L4,L5,R).
%% R = [[[[1]]], 1, [1], 1, [2], [[3]], [[[...]]], [5|...]].
%% f. ? – delete(1, L4,R). false 
%% we should get R = [[[[1]]], [1]]
%% g. ? – delete(13,L5,R). false
%% we should get R = [1,[2],[[3]],[[[4]]],[5,[6,[7,[8,[9],10],11],12],13]]

%% 7.2
%% a. ? – atomic(apple). true
%% b. ? – atomic(4). true
%% c. ? – atomic(X). false - X is not defined
%% d. ? – atomic( apple(2)). true
%% e. ? – atomic([1,2,3]). false - a nonempty list is not an atom
%% f. ? – atomic([]). true - empty list is an atom

%% depth of a deep list
max(N1,N2,R):-N1>N2,!,R=N1.
max(_,N2,N2).
depth([],1).
depth([H|T],R):-atomic(H),!,depth(T,R).
depth([H|T],R):- depth(H,R1), depth(T,R2), R3 is R1+1, max(R3,R2,R).

%% 7.3
%% a. ? – depth(L1,R). R = 2 (element 4 is on the deepest level)
%% b. ? – depth(L2,R). R = 2 (contains 4 lists of level 1)
%% c. ? – depth(L3,R). R = 3 (el 6 is on the deepest level)
%% d. ? – depth(L4,4). R = 4 (first list is of level 3)
%% e. ? – depth(L5,R). R = 6 (el 9 is on the deepest level)
%% f. ? – depth(L6,4). R = 3 (el 8 is on the deepest level)

%% flattening a deep list
flatten([],[]).
flatten([H|T],[H|R]):-atomic(H),!,flatten(T,R).
flatten([H|T],R):-flatten(H,R1),flatten(T,R2),append(R1,R2,R).

%% list heads - atomic elments which are at the head of a shallow list
heads3([],[],_).
%% we are at the first element of list & elem is atomic
heads3([H|T],[H|R],1):-atomic(H),!,heads3(T,R,0).
%% we are not at the first element of list & elem is atomic
heads3([H|T],R,0):-atomic(H),!,heads3(T,R,0).
%% element is not atomic
heads3([H|T],R,_):-heads3(H,R1,1),heads3(T,R2,0), append(R1,R2,R).
heads_pretty(L,R) :- heads3(L, R,1).

%% nested member
member1(H,[H|_]).
member1(X,[H|_]):-member1(X,H).
member1(X,[_|T]):-member1(X,T).

%% 7.3.1
noatoms([],0).
noatoms([H|T],R):-atomic(H),!,noatoms(T,RT),R is RT+1.
noatoms([H|T],R):-noatoms(H,RH),noatoms(T,RT),R is RT+RH.

%% 7.3.2
sumatoms([],0).
sumatoms([H|T],R):-atomic(H),!,sumatoms(T,RT),R is RT+H.
sumatoms([H|T],R):-sumatoms(H,RH),sumatoms(T,RT),R is RT+RH.

%% 7.3.3
memberd(H,[H|_]):-!.
memberd(X,[H|_]):-memberd(X,H).
memberd(X,[_|T]):-memberd(X,T).

%% 7.4.1
getLastAtomic([],[]).
%% if last element & atomic
getLastAtomic([H],[H]):-atomic(H),!.
%% if last elem & not atomic
getLastAtomic([H],R):-getLastAtomic(H,R).
%% if not last elem & atomic
getLastAtomic([H|T],R):-atomic(H),!,getLastAtomic(T,R).
%% if not last elem & not atomic
getLastAtomic([H|T],R):-getLastAtomic(H,R1),getLastAtomic(T,R2),
						append(R1,R2,R).

%% 7.4.2
replace(O,N,[O|T],[N|R]):-replace(O,N,T,R).
replace(O,N,[H|T],[H|R]):-atomic(H),!,replace(O,N,T,R).
replace(O,N,[H|T],R):-replace(O,N,H,RH),replace(O,N,T,RT),append(RH,RT,R).
replace(_,_,[],[]).

