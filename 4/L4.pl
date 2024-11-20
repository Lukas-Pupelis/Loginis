% Main predicate: Find a planar embedding of the graph
find_embedding(Vertices, Edges, Assignment) :-
    generate_positions(Vertices, Positions),
    assign_positions(Vertices, Positions, Assignment),
    edges_do_not_cross(Edges, Assignment).

% Generate possible positions for the vertices
generate_positions(Vertices, Positions) :-
    length(Vertices, N),
    MaxCoord is N * 2, % Adjust grid size based on the number of vertices
    findall((X, Y), (between(0, MaxCoord, X), between(0, MaxCoord, Y)), PositionsList),
    list_to_set(PositionsList, Positions).

% Assign positions to vertices without repetition
assign_positions([], _, []).
assign_positions([V|Vs], Positions, [pos(V, X, Y)|Assignment]) :-
    select((X, Y), Positions, RemainingPositions),
    assign_positions(Vs, RemainingPositions, Assignment).

% Retrieve the position of a vertex from the assignment
vertex_position(V, [pos(V, X, Y)|_], X, Y).
vertex_position(V, [_|Rest], X, Y) :-
    vertex_position(V, Rest, X, Y).

% Determine the orientation of three points
orientation((X1, Y1), (X2, Y2), (X3, Y3), O) :-
    Val is (Y2 - Y1) * (X3 - X2) - (X2 - X1) * (Y3 - Y2),
    (Val > 0  -> O = clockwise;
     Val < 0  -> O = counterclockwise;
     Val =:= 0 -> O = colinear).

% Check if two line segments cross
lines_cross(P1, P2, Q1, Q2) :-
    orientation(P1, P2, Q1, O1),
    orientation(P1, P2, Q2, O2),
    orientation(Q1, Q2, P1, O3),
    orientation(Q1, Q2, P2, O4),
    O1 \= O2,
    O3 \= O4.

% Check if two edges cross in the given assignment
edges_cross((V1, V2), (U1, U2), Assignment) :-
    \+ member(V1, [U1, U2]),
    \+ member(V2, [U1, U2]),
    vertex_position(V1, Assignment, X1, Y1),
    vertex_position(V2, Assignment, X2, Y2),
    vertex_position(U1, Assignment, X3, Y3),
    vertex_position(U2, Assignment, X4, Y4),
    lines_cross((X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)).

% Ensure that no edges cross in the assignment
edges_do_not_cross([], _).
edges_do_not_cross([E|Es], Assignment) :-
    \+ (member(E2, Es), edges_cross(E, E2, Assignment)),
    edges_do_not_cross(Es, Assignment).

% Second predicate: Output the embedding in DOT format
print_embedding(Vertices, Edges, Assignment) :-
    writeln('graph G {'),
    writeln('  node [shape=circle, fixedsize=true, width=0.5];'),
    % Output vertex positions
    forall(member(pos(V, X, Y), Assignment),
           format('  "~w" [pos="~w,~w!"];\n', [V, X, Y])),
    % Output edges
    forall(member((V1, V2), Edges),
           format('  "~w" -- "~w";\n', [V1, V2])),
    writeln('}').

% Example usage:
% Define your graph by listing vertices and edges
% ?- Vertices = [a, b, c, d, e],
%    Edges = [(a, b), (b, c), (c, d), (d, e), (e, a), (a, c), (b, d)],
%    find_embedding(Vertices, Edges, Assignment),
%    print_embedding(Vertices, Edges, Assignment).
