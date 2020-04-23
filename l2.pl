% forward reccursion
%	use an extra argument to store the partial result
% backward reccursion
%	use the stack for reccursion
%	the result is computed when we reach the basic case (e.g. n = 0)

% 1. greatest common divisor
gcd(X,X,X).
gcd(X,Y,Z):- 
	X>Y, 
	R is X-Y, 
	gcd(R,Y,Z).
gcd(X,Y,Z):- 
	X<Y, 
	R is Y-X, 
	gcd(X,R,Z).


% 2. factorial
% backward reccursion
fact(0,1).
fact(N,F):- 
	N>0, 
	N1 is N-1, 
	fact(N1,F1), 
	F is F1*N.
% forward reccursion
fact1(0,FF,FF).
fact1(N,FP,FF):- 
	N>0, 
	N1 is N-1, 
	FP1 is FP*N, 
	fact1(N1,FP1,FF).

fact1_pretty(N,F):- fact1(N,1,F).


% 3. for loop
forLoop(SF,SF,0).
forLoop(SP,SF,N):-
	N>0,
	N1 is N-1,
	SP1 is SP+N1,
	forLoop(SP1,SF,N1).

% 4. least common multiplier
lcm(X,Y,Z):-  
	gcd(X,Y,G),
	Z is abs(X*Y) / G.


% 5. fibonacci
fib(0,1).
fib(1,1).
fib(N,F):-
	N>1,
	N1 is N-1,
	N2 is N-2,
	fib(N1,F1),
	fib(N2,F2),
	F is F1+F2.

% 6. repeat ... until
rep(L,H):-
	writeln(L),
	L<H,
	LP1 is L+1,
	rep(LP1,H).

% 7. while
whl(L,H):-
	LM1 is L-1,
	LM1<H,
	writeln(L),
	LP1 is L+1,
	whl(LP1,H).

% 8. triangle
triangle(A,B,C):-
	S1 is A+B,
	S1>C,
	S2 is B+C,
	S2>A,
	S3 is A+C,
	S3>B.

% 9. 2nd order equation
solve_eq2(A,B,C,X):-
	D is B*B-4*A*C,
	X is (-B+sqrt(D))/(2*A).

solve_eq2(A,B,C,X):-
	D is B*B-4*A*C,
	X is (-B-sqrt(D))/(2*A).

