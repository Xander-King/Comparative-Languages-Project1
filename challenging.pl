
%% I will not accept a submission with the T0D0 comments left in place!

url("TODO: Replace this with the URL of the puzzle").

solution([ [41,	'Cory',		'Archery',	    	'John Travolta'	],
  [51,	'Anna',	    'Reading',			'Russell Crowe'	],
  [52,	'Teagan',	'Hang gliding',	    'Bruce Willis' 	],
  [73,	'Adrian',	'Music',			'Jude Law'  	], 
  [74,  'Maria',  	'Writing',			'Tom Cruise'	]
  ]).


solve(T) :-
   T =[[41,	N1,	H1,	A1],
      [51,	N2,	H2,	A2],
      [52,	N3,	H3,	A3],
      [73,	N4,	H4,	A4],
      [74, 	N5,	H5,	A5]
      ],
    
   permutation([H1, H2, H3, H4, H5], 
               ['Archery', 'Reading', 'Hang gliding', 'Music', 'Writing']),
   clue8(T), % _, H, _
   clue13(T), % _, H, _
    
   permutation([N1, N2, N3, N4, N5], 
               ['Cory',	'Anna',	'Teagan', 'Adrian', 'Maria' ]),
   clue2(T), % N, _, _
   clue5(T), % N, H, _
   clue9(T), % N, H, _
   clue10(T), % N, H, _
   clue12(T), % N, H, _
  
   clue10(T),
   permutation([A1, A2, A3, A4, A5], 
               ['John Travolta', 'Russell Crowe', 'Bruce Willis', 'Jude Law', 'Tom Cruise']),
   clue1(T), % _, H, A
   clue3(T), % N, H, A
   clue4(T), % _, H, A
   clue6(T), % N, _, A
   clue7(T), % _, _, A
   clue11(T). % N, _, A


	% 1. Tom Cruise's cousin enjoys writing.
clue1(T) :- member([_, _, 'Writing', 'Tom Cruise'], T).

% 2. The collector who has 74 baseball cards is Maria.
clue2(T) :- member([74, 'Maria', _, _], T).

% 3. The 5 people were the person who enjoys writing, Cory, 
% Jude Law's cousin, the collector who has 51 baseball cards, 
% and the person who enjoys hang gliding
clue3(T) :- member([Num, N, H, 'Jude Law'], T), 
    Num \= 51, N \= 'Cory', H \= 'Hang gliding', H \= 'Writing',
    member([Num1, N1, 'Writing', A1], T),
    Num1 \= 51, N1 \= 'Cory', A1 \= 'Jude Law',
    member([Num2, 'Cory', H2, A2], T), 
    Num2 \= 51, H2 \= 'Writing', H2 \= 'Hang gliding', A2 \= 'Jude Law',
    member([51, N3, H3, A3], T), 
    N3 \= 'Cory', H3 \= 'Hang gliding', H3 \= 'Writing', A3 \= 'Jude Law',
    member([Num4, N4, 'Hang gliding', A4], T),
    Num4 \= 51, N4 \= 'Cory', A4 \= 'Jude Law'.

% 4. Russell Crowe's cousin does not enjoy hang gliding.
clue4(T) :- member([_, _, H, 'Russell Crowe'], T), H \= 'Hang gliding'.


% 5. Adrian has more baseball cards than the person who enjoys reading.
clue5(T) :- member([Num1, 'Adrian', _, _], T), 
    member([Num2, _, 'Reading', _], T),
    Num1 > Num2.

% 6. John Travolta's cousin is Cory.
clue6(T) :- member([_, 'Cory', _, 'John Travolta'], T).


% 7. The collector who has 41 baseball cards isn't related to Bruce Willis.
clue7(T) :- member([41, _, _, A], T), A \= 'Bruce Willis'.

% 8. The person who enjoys archery has fewer baseball cards than the person
%  who enjoys reading.
clue8(T) :- member([Num1, _, 'Archery', _], T),
    member([Num2, _, 'Reading', _], T),
    Num1 < Num2.

% 9. The person who enjoys reading is not Cory.
clue9(T) :- member([_, N, 'Reading', _], T), N \= 'Cory'.

% 10. Maria has more baseball cards than the person who enjoys hang gliding.
clue10(T) :-  member([Num1, 'Maria', _, _], T), 
     member([Num2, _, 'Hang gliding', _], T),
    Num1 > Num2.

% 11. Russell Crowe's cousin is not Teagan.
clue11(T) :- member([_, N, _, 'Russell Crowe'], T), N \= 'Teagan'.

% 12. The person who enjoys music is Adrian.
clue12(T) :- member([_, 'Adrian', 'Music', _], T).

% 13. The collector who has 52 baseball cards does not enjoy music.
clue13(T) :- member([52, _, H, _], T), H \= 'Music'.
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
