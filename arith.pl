% isnumber(X) is true if X is a isnumber

isnumber(0).
isnumber(s(X)) :- isnumber(X).

% plus(X,Y,Z) is true if X + Y = Z

plus(0,X,X) :- isnumber(X).
plus(s(X),Y,s(Z)) :- plus(X,Y,Z).

% minus(X,Y,Z) is true if X - Y =Z

minus(X,0,X) :- isnumber(X).
minus(s(X),s(Y),Z) :- minus(X,Y,Z).

% times(X,Y,Z) is true if X * Y = Z

times(X,0,0) :- isnumber(X).
times(X,s(Y),Z) :- times(X,Y,Z1), plus(X,Z1,Z).

% pow(X,Y,Z) is true if X^Y = Z

pow(X,0,s(0)) :- isnumber(X).
pow(X,s(Y),Z) :- pow(X,Y,Z1), times(X,Z1,Z).

% even(X) is true if N is even

% even(X) is true if N is even
even(0).
even(s(s(X))) :- even(X).


% odd(X) is true if N is odd

odd(X) :- mod(X,2) =\= 0.


div2(N, D) :- plus(D, D, N).

divi2(N,D) :- times(D,s(s(0)),N).

log(X, B, N) :- pow(B, N, X).
find_n(N) :- log(s(s(s(s(s(s(s(s(0)))))))),s(s(0)), N).

fib(0, 0).
fib(s(0), s(0)).
fib(s(s(N)), Result) :- fib(s(N), F1), fib(N, F2), plus(F1, F2, Result).

% power(X, N, Y) is true if X^N = Y
power(X, 0, s(0)) :- isnumber(X).
power(X, s(N), Y) :- even(s(N)), pow(X, N, Z), times(Z, Z, Y).
power(X, s(N), Y) :- odd(s(N)), pow(X, N, Z), times(X, Z, Y).


% member(X, L) is true if X is a member of the list L
member(X, [X | _]).
member(X, [_ | Tail]) :- member(X, Tail).

% concat(L, X, Y) is true if L is the concatenation of lists X and Y
concat([], X, X).
concat([H | T], X, [H | Y]) :- concat(T, X, Y).

% reverse(L, R) is true if R is the reversal of the list L
reverse([], []).
reverse([H | T], R) :- reverse(T, RevT), concat(RevT, [H], R).

% palindrome(L) is true if L is a palindrome
palindrome(L) :- reverse(L, L).

connected(m, n).
connected(m, i).
connected(n, m).
connected(i, m).
connected(n, o).
connected(o, n).
connected(p, l).
connected(j, f).
connected(j, k).
connected(k, j).
connected(k, g).
connected(l, p).
connected(l, h).
connected(e, f).
connected(f, j).
connected(f, b).
connected(g, k).
connected(g, c).
connected(h, l).
connected(h, d).
connected(a, b).
connected(b, f).
connected(c, g).
connected(d, h).
connected(c, d).
connected(d, c).

% path(X, Y) is true if there is a path between X and Y

path(X, Y) :- path_helper(X, Y, []).

% path_helper(X, Y, Visited) is true if there is a path between X and Y, with the nodes in Visited already visited

path_helper(X, Y, _) :- connected(X, Y).
path_helper(X, Y, Visited) :- connected(X, Z), \+ member(Z, Visited), path_helper(Z, Y, [X | Visited]).




% Example queries:
% Isnumbers are represented as successors of 0. For example, 2 is s(s(0)).
% 2+2=4 is plus(s(s(0)), s(s(0)), s(s(s(s(0)))))
% 3*2=? is times(s(s(s(0))), s(s(0)), X)
