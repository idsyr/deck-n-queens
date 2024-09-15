


% Проверка вертикального пересечения через равенство Y
ninter_v(pos(_,EQ1), pos(_, EQ2)) :-
		\==(EQ1,EQ2).

% Проверка горизонтального пересечения через равенство X
ninter_h(pos(EQ1,_), pos(EQ2,_)) :-
		\==(EQ1,EQ2).

% Проверка диагонального пересечения через равенство модуля разницы XY
% abs(): не работает: f(4,4,6,2)->true 
ninter_d(pos(X1,Y1), pos(X2,Y2)) :-
		plus(X1, BETX, X2),
		plus(Y1, BETY, Y2),
		\=(BETX, BETY),
		plus(X2,BETXA, X1),
		\==(BETXA, BETY).

% Проверка на нахождение в границах доски и непересечение Q
ninter_q(pos(X1, Y1), pos(X2, Y2), N) :-
		between(1, N, X1),
		between(1, N, Y1),
		between(1, N, X2),
		between(1, N, Y2),
		ninter_v(pos(X1, Y1), pos(X2, Y2)),
		ninter_d(pos(X1, Y1), pos(X2, Y2)),
		ninter_h(pos(X1, Y1), pos(X2, Y2)).



% Обход листа и его вывод в консоль
print_pos_list([]).
print_pos_list([pos(X, Y)|T]):-
		write('X: '), write(X), write('\t'),
		write('Y: '), write(Y), write('\n'),
		print_pos_list(T).



% Стартовый кейс добавляющий Q на позицию X_RAND:Y_RAND и вызов базового случая
% Возможно использование X1Y1, но тогда отбрасываются кейсы где первая позиция не X1Y1
% Без добавления происходит зависание
queen_problem(N) :-
		between(1, N, X1),
		between(1, N, Y1),
		append([[pos(X1,Y1)]], QL),
		queen_problem(N, QL).

% Базовый кейс проверяющий новый элемент на пересечение хоть одной уже установленной Q
% Добавляет в лист подходящий элемент и вызывает Базовый кейс с обновленным списком размещенных Q 
% Использование check_through_all возвращает false и не повторяет проверку TODO: CHECK
queen_problem(N, QL) :-
		between(1, N, X),
		between(1, N, Y),
		%check_through_all(pos(X,Y), [QL]),
		forall(member(pos(X1,Y1), QL),
					 ninter_q(pos(X,Y), pos(X1,Y1), N)),
		append(QL, [pos(X,Y)], QLN),
		queen_problem(N, QLN).

% Завершающий кейс проверяет достижение количества расставленных Q размеру N и выводит список Q
queen_problem(N, QL) :-
		length(QL, L),
		L==N,
		print_pos_list(QL).





