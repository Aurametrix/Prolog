?- length([],0).      % is the length of empty list zero?
?- length([a,b,c],X). % what's the length of list consisting of a,b and c?
?- length(L,5).       % give me all lists that have length of 5

/**
 * insertion in a red-black-tree
 */
 
color(r).
color(b).

tree(_,e).
tree(P,t(C,L,X,R)) :- color(C), tree(P,L), call(P,X), tree(P,R).

bal(b, t(r,t(r,A,X,B),Y,C), Z, D, t(r,t(b,A,X,B),Y,t(b,C,Z,D))).
bal(b, t(r,A,X,t(r,B,Y,C)), Z, D, t(r,t(b,A,X,B),Y,t(b,C,Z,D))).
bal(b, A, X, t(r,t(r,B,Y,C),Z,D), t(r,t(b,A,X,B),Y,t(b,C,Z,D))).
bal(b, A, X, t(r,B,Y,t(r,C,Z,D)), t(r,t(b,A,X,B),Y,t(b,C,Z,D))).

balance(C,A,X,B,S) :- ( bal(C,A,X,B,T) -> S = T ; S = t(C,A,X,B) ).

ins(X,e,t(r,e,X,e)).
ins(X,t(C,A,Y,B),R) :- ( X < Y -> ins(X,A,Ao), balance(C,Ao,Y,B,R)
                       ; X > Y -> ins(X,B,Bo), balance(C,A,Y,Bo,R)
                       ; X = Y -> R = t(C,A,Y,B)
                       ).

insert(X,S,t(b,A,Y,B)) :- ins(X,S,t(_,A,Y,B)).
