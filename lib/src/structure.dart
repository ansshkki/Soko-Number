import 'package:equatable/equatable.dart';

import '../data/direction.dart';
import '../data/position.dart';

class Structure extends Equatable {
  final List<List<int>> board;
  final List<Position> goals;
  final int depth;
  final int cost;
  late final int f;
  final int r;
  final int c;
  final Structure? parent;

  Structure(this.board, this.goals, [this.parent, this.depth = 1, this.cost = 0])
      : r = board.length,
        c = board.first.length;

  List<Direction> checkMoves() {
    List<Direction> ds = [];
    for (var d in Direction.values) {
      if (this != move(d)) ds.add(d);
    }
    return ds;
  }

  Structure move(Direction d) {
    final board = List.generate(
      this.board.length,
      (index) => List.of(this.board[index]),
    );
    final List<Position> b = [];
    for (var i = 0; i < board.length; ++i) {
      for (var j = 0; j < board[i].length; ++j) {
        int cell = board[i][j];
        if (cell > 0) {
          int x = i;
          int y = j;
          d.when(
            up: () => x--,
            down: () => x++,
            right: () => y++,
            left: () => y--,
          );
          if (b.contains(Position(x, y)) || b.contains(Position(i, j))) {
            continue;
          }
          if (x < 0 || x >= r || y < 0 || y >= c) continue;
          if (board[x][y] == -1 || board[x][y] > 0) continue;
          board[x][y] = cell;
          board[i][j] = 0;
          b.add(Position(x, y));
          b.add(Position(i, j));
        }
      }
    }
    return Structure(board, goals, this, depth + 1, cost + 1);
  }

  List<Structure> getNextStates() {
    List<Structure> states = [];
    List<Direction> directions = checkMoves();
    for (final d in directions) {
      final s = move(d);
      states.add(s);
    }
    return states;
  }

  bool isFinal() {
    for (var i = 0; i < goals.length; ++i) {
      final pos = goals[i];
      if (board[pos.x][pos.y] != i + 1) {
        return false;
      }
    }
    return true;
  }

  int calcH() {
    int c = 0;
    for (var i = 0; i < goals.length; ++i) {
      final pos = goals[i];
      if (board[pos.x][pos.y] != i + 1) {
        c++;
      }
    }
    return c;
  }

  @override
  List<Object> get props => [board, goals];
}
