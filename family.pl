% female(?Name)
% female(++Name) - перевірка, чи є людина жінкою
% female(--Name) - найти всіх жінок
% female(_)      - чи є у базі хоча б одна жінка?
female(jane).
female(anna).
female(mary).
female(catlyn).
female(sarah).

% male(?Name)
% male(++Name) - перевірка, чи є людина чоловіком
% male(--Name) - знайти всіх чоловіків
% male(_)      - чи є у базі хоча б один чоловік?
male(john).
male(jim).
male(peter).
male(alex).
male(tom).
male(micky).

% parent(?Parent, ?Child)
% parent(++, ++) - чи є X батьком Y?
% parent(++, --) - знайти всіх дітей конкретної людини
% parent(--, ++) - знайти батьків конкретної дитини
% parent(--, --) - вивести всі пари батько-дитина
% parent(+, _)   - чи людина має хоч одну дитину?
% parent(_, +)   - чи людина має батьків?
% parent(_, -)   - всі діти
% parent(-, _)   - всі батьки
% parent(_, _)   - чи є батьки та діти у базі?
parent(john, jim).
parent(jane, jim).
parent(jim, anna).
parent(jim, tom).
parent(anna, peter).
parent(tom, mary).
parent(tom, alex).


% Union
% person(?Name)
% person(++) - чи є людиною?
% person(--) - знайти всіх людей
% person(_)  - чи існує хоча б одна людина?
person(X) :- female(X).
person(X) :- male(X).

% Intersection
% father(?Father, ?Child)
% father(++, --) - хто діти цього чоловіка?
% father(--, ++) - хто батько цієї дитини?
% father(+, _)   - чи є цей чоловік батьком?
% father(_, -)   - хто є дітьми батьків-чоловіків?
father(X, Y) :- 
    male(X),
    parent(X, Y).

mother(X, Y) :- 
    female(X),
    parent(X, Y).

% Difference
% woman_by_diff(?Name)
% woman_by_diff(++) - чи людина не чоловік
% woman_by_diff(--) - люди, які не є в множині чоловіків
woman_by_diff(X) :- 
    person(X), 
    \+ male(X).


% Projection
% is_parent(?Name)
% is_parent(++) - чи має людина дітей?
% is_parent(--) - знайти всіх батьків
is_parent(X) :- 
    parent(X, _).

% Декартів добуток
% possible_pair(?Male, ?Female)
% possible_pair(--, --) - всі можливі пари
% possible_pair(+, +)   - чи можлива така пара
possible_pair(X, Y) :- 
    male(X), 
    female(Y).

% Тета-зєднання
% grandfather_of_peter(?Grandfather)
% grandfather_of_peter(--) - знайти дідусів Петра
% grandfather_of_peter(++) - чи є X дідусем Петра
% grandfather_of_peter(_)  - чи є у Петра взааглі дідусь
grandfather_of_peter(X) :- 
    father(X, Y), 
    parent(Y, peter).

% Оберненість
% child(?Child, ?Parent)
% child(++, ++) - чи є Y дитиною X?
% child(--, --) - всі пари дитина-батько
% child(+, _)   - чи має Y батьків?
child(Y, X) :- 
    parent(X, Y).

% Нерівність
% sibling(?X, ?Y)
% sibling(++, --) - знайти всіх братів/сестер
% sibling(++, ++) - чи дві людини є родичами сіблінгс
% sibling(_, _)   - чи існують у базі взагалі брати/сестри?
sibling(X, Y) :-
    parent(Z, X),
    parent(Z, Y),
    X \= Y.

% Транзитивне замикання
% ancestor(?Ancestor, ?Descendant)
% ancestor(++, --) - знайти всіх нащадків
% ancestor(--, ++) - знайти всіх пращурів
% ancestor(+, +)   - чи є X предком Y?
% ancestor(+, _)   - чи має X нащадків?
ancestor(X, Y) :- 
    parent(X, Y).
ancestor(X, Y) :-
    parent(X, Z),
    ancestor(Z, Y).

% descendant(?Descendant, ?Ancestor)
descendant(X, Y) :- 
    ancestor(Y, X).

% Симетричне замикання
% blood_relative_base(?X, ?Y)
blood_relative_base(X, Y) :-
    ancestor(Z, X),
    ancestor(Z, Y),
    X \= Y.

% Рефлексивне замикання
% in_genetic_clan(?X, ?Y)
% in_genetic_clan(++, --) - знайти всіх, хто в групі ризику з X (+ сам X)
% in_genetic_clan(+, +)   - чи належать X та Y одному клану(?)
in_genetic_clan(X, Y) :- 
    blood_relative(X, Y).
in_genetic_clan(X, X) :- 
    person(X).