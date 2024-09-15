/*
:- use_module(library(clpfd)). % for ops like #=< 

% Использование с not() приводит к остановке выполнения TODO: CHECK
inter_v(pos(_, EQ), pos(_, EQ)).
inter_h(pos(EQ, _), pos(EQ, _)).
inter_d(pos(X1, Y1), pos(X2, Y2)):-
		plus(X1, EQ, Y1),
		plus(X2, EQ, Y2).
inter_q(pos(X1, Y1), pos(X2, Y2)):-
		inter_v(pos(X1, Y1), pos(X2, Y2));
		inter_h(pos(X1, Y1), pos(X2, Y2));
		inter_d(pos(X1, Y1), pos(X2, Y2)).

% Попытка использовать динамические факты вместо листа
:- dynamic field_in_usage/2.

checkall([], pos(X,Y), _, QPOS1) :-
		append(pos(X, Y), QPOS, QPOS1).	

checkall([pos(X1,Y1)|T], pos(X,Y), N, QPOS1) :-
		ninter_q(pos(X1,Y1), pos(X,Y), N),
		checkall(T,pos(X,Y), N, QPOS1).

queen_proc(N, X, Y) :-
		between(1, N, Y),
		between(1, N, X),
		%checkall(QL, pos(X, Y), N, QPOS1),
		forall(field_in_usage(XB,YB),
					 ninter_q(pos(X,Y), pos(XB, YB), N)),
		asserta(field_in_usage(X,Y)),
		write('\n'), write(X), write(' '), write(Y),
		
		queen_proc(N, X, Y).
		%assertz(field_in_usage(X,Y)).
%		assert(field_in_usage(pos(X, Y))).

check_through_all(pos(X,Y), QL):-
		length(QL, L),
		L==0.

check_through_all(pos(X,Y), [pos(XD,YD)|T]) :-
		ninter_q(pos(X,Y), pos(XD,YD), N),
		check_through_all(pos(X,Y), T).
*/

