%___________________________________________________________________________
% Bubble sort

bubblesort(Rel, List, SortedList) :-
swap(Rel, List, NewList), !,
bubblesort(Rel, NewList, SortedList).
bubblesort(_, SortedList, SortedList).
% Go recursively through a list until you finds a pair A/B to swap and
% return the new list, or fail if there is no such pair:
swap(Rel, [A,B|List], [B,A|List]) :-
check(Rel, B, A).
swap(Rel, [A|List], [A|NewList]) :-
swap(Rel, List, NewList).

% Just to prove that it really works:
?- bubblesort(<, [5,3,7,5,2,8,4,3,6], List).
List = [2, 3, 3, 4, 5, 5, 6, 7, 8]
Yes
?- bubblesort(is_bigger, [donkey,horse,elephant], List).
List = [elephant, horse, donkey]
Yes
?- bubblesort(@<, [donkey,horse,elephant], List).
List = [donkey, elephant, horse]
Yes
