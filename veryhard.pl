
%% I will not accept a submission with the T0D0 comments left in place!

url("TODO: Replace this with the URL of the puzzle").

solution([ [5.75,	'Basketball',		'Johnnie',	    	'Perris'		],
  [6.75,	'Fruit basket',	    'Everett',			'Quimby'		],
  [7.75,	'Computer',			'Pablo',	    	'Fontanelle'	],
  [8.75,	'Rare book',		'Luther',			'Oakdale'  		], 
  [9.75,  	'Toaster',  		'Willie',			'Newport'		],
  [10.75,  	'Tea set',  		'Brad',				'Mattawamkeag'	]
  ]).

solve(T) :-
	T =[[5.75,	I1,	C1,	T1],
      [6.75,	I2,	C2,	T2],
      [7.75,	I3,	C3,	T3],
      [8.75,	I4,	C4,	T4],
      [9.75, 	I5,	C5,	T5],
      [10.75, 	I6,	C6,	T6]
      ],
    
   permutation([I1, I2, I3, I4, I5, I6], 
               ['Basketball', 'Fruit basket', 'Computer', 'Rare book', 'Toaster', 'Tea set']),
   
    
   permutation([C1, C2, C3, C4, C5, C6], 
               ['Johnnie',	'Everett',	'Pablo', 'Luther', 'Willie', 'Brad']),
   
   
   clue4(T), % I, C, _
   clue9(T), % I, C, _
   clue10(T), % _, C, _
   clue11(T), % _, C, _
   clue12(T), % I, C, _
  
 
   permutation([T1, T2, T3, T4, T5, T6], 
               ['Perris', 'Quimby', 'Fontanelle', 'Oakdale', 'Newport', 'Mattawamkeag']),
   clue1(T), % I, _, T
   clue2(T), % _, C, T
   clue3(T), % I, C, T
   clue5(T), % I, _, T
   clue6(T), % I, _, T
   clue7(T), % _, C, T
   clue8(T), % I, C, T
   clue13(T). % _, C, T
  
% 1. The package with the rare book in it cost 2 dollars less
%  than the package going to Mattawamkeag.
clue1(T) :- member([P1, 'Rare book', _, T1], T),
    member([P2, I1, _, 'Mattawamkeag'], T),
    T1 \= 'Mattawamkeag', I1 \= 'Rare book',
    (P1 is P2 - 2.00).
    

% 2. The shipment going to Quimby cost somewhat less than Pablo's package.
clue2(T) :- member([P1, _, _, 'Quimby'], T),
    member([P2, _, 'Pablo', _], T),
    P1 < P2.

% 3. The six packages are Luther's package, the shipment 
% going to Mattawamkeag, the package going to Newport Beach, 
% the package with the basketball in it, the package with the 
% fruit basket in it and the package going to Fontanelle.

clue3(T) :- member([_, I, 'Luther', T0], T), 
    I \= 'Basketball', I \= 'Fruit basket', 
    T0 \= 'Mattawamkeag', T0 \= 'Newport Beach', T0 \= 'Fontanelle',
    
    member([_, I1, C1, 'Mattawamkeag'], T),
    I1 \= 'Basketball', I1 \= 'Fruit basket', C1 \= 'Luther',
    
    member([_, I2, C2, 'Newport'], T), 
    I2 \= 'Basketball', I2 \= 'Fruit basket', C2 \= 'Luther',
    
    member([_, 'Basketball', C3, T3], T), 
    C3 \= 'Luther', T3 \= 'Mattawamkeag', 
    T3 \= 'Newport Beach', T3 \= 'Fontanelle',
    
    member([_, 'Fruit basket', C4, T4], T),
    C4 \= 'Luther', T4 \= 'Mattawamkeag', 
    T4 \= 'Newport Beach', T4 \= 'Fontanelle',
    
    member([_, I5, C5, 'Fontanelle'], T),
    I5 \= 'Basketball', I5 \= 'Fruit basket', C5 \= 'Luther'.

% 4. The package with the tea set in it isn't Pablo's.
clue4(T) :- member([_, 'Tea set', C, _], T), C \= 'Pablo'.


% 5. The shipment going to Fontanelle is either the shipment with the
%  toaster in it or the package that cost $7.75.
clue5(T) :-  member([P, I, _, 'Fontanelle'], T), 
   (P = 7.75, I \= 'Toaster' ; I = 'Toaster', P \= 7.75).

% 6. The package with the basketball in it cost
%  2 dollars less than the shipment going to Fontanelle.
clue6(T) :- member([P1, 'Basketball', _, _], T),
    member([P2, _, _, 'Fontanelle'], T),
    (P1 is P2 - 2.0).


% 7. Of the shipment going to Perris and the shipment going to Mattawamkeag,
%  one cost $5.75 and the other is Brad's.
clue7(T) :- member([P1, _, C1, 'Mattawamkeag'], T),
    member([P2, _, C2, 'Perris'], T),
    (P1 = 5.75, C1 \= 'Brad', P2 \= 5.75, C2 = 'Brad' ; 
	P1 \= 5.75, C1 = 'Brad', P2 = 5.75, C2 \= 'Brad').

% 8. Of the package going to Mattawamkeag and the shipment that cost $6.75,
%  one is Brad's and the other contains the fruit basket.
clue8(T) :- member([P1, I1, C1, 'Mattawamkeag'], T),
    member([6.75, I2, C2, T2], T),
    (I1 = 'Fruit basket', C1 \= 'Brad', I2 \= 'Fruit basket', C2 = 'Brad' ;
     I1 \= 'Fruit basket', C1 = 'Brad', I2 = 'Fruit basket', C2 \= 'Brad'),
    P1 \= 6.75, T2 \= 'Mattawamkeag'.

% 9. Everett's package is either the shipment with the toaster in it
%  or the package that cost $6.75.
clue9(T) :- member([P, I, 'Everett', _], T), 
     (P = 6.75, I \= 'Toaster' ; I = 'Toaster', P \= 6.75).

% 10. The shipment that cost $9.75 isn't Everett's.
clue10(T) :-  member([9.75, _, C, _], T), C \= 'Everett'. 


% 11. The shipment that cost $7.75 isn't Willie's.
clue11(T) :- member([7.75, _, C, _], T), C \= 'Willie'.

% 12. Brad's shipment is either the package with the toaster in it
%  or the shipment that cost $10.75.
clue12(T) :- member([P, I, 'Brad', _], T),
 (P = 10.75, I \= 'Toaster' ; I = 'Toaster', P \= 10.75).

% 13. Johnnie's package cost 4 dollars less than
%  the shipment going to Newport Beach.
clue13(T) :- member([P1, _, 'Johnnie', _], T), 
    member([P2, _, _, 'Newport'], T),
    (P1 is P2 - 4.00).



check :- 
	% Confirm that the correct solution is found
	solution(S), (solve(S); not(solve(S)), writeln("Fails Part 1: Does  not eliminate the correct solution"), fail),
	% Make sure S is the ONLY solution 
	not((solve(T), T\=S, writeln("Failed Part 2: Does not eliminate:"), print_table(T))),
	writeln("Found 1 solutions").

print_table([]).
print_table([H|T]) :- atom(H), format("~|~w~t~20+", H), print_table(T). 
print_table([H|T]) :- is_list(H), print_table(H), nl, print_table(T). 


% Show the time it takes to conform that there are no incorrect solutions
checktime :- time((not((solution(S), solve(T), T\=S)))).
