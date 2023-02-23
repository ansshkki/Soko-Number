import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:isa/src/structure.dart';
import 'package:stack/stack.dart';

class Logic {
  Result dfs(Structure s) {
    if (s.isFinal()) return Result(s, 0);
    Stack<Structure> open = Stack();
    HashSet<Structure> close = HashSet();
    open.push(s);
    while (open.isNotEmpty) {
      final state = open.pop();
      if (state.isFinal()) return Result(state, close.length);
      close.add(state);
      final states = state.getNextStates();
      for (final state in states.reversed) {
        if (!close.contains(state) && !open.contains(state)) {
          open.push(state);
        }
      }
    }
    return Result(null, close.length);
  }

  Result bfs(Structure s) {
    if (s.isFinal()) return Result(s, 0);
    Queue<Structure> open = Queue();
    HashSet<Structure> close = HashSet();
    open.add(s);
    while (open.isNotEmpty) {
      final state = open.removeFirst();
      if (state.isFinal()) return Result(state, close.length);
      close.add(state);
      final states = state.getNextStates();
      for (final state in states) {
        if (!close.contains(state) && !open.contains(state)) {
          open.add(state);
        }
      }
    }
    return Result(null, close.length);
  }

  Result ucs(Structure s) {
    if (s.isFinal()) return Result(s, 0);
    PriorityQueue<Structure> open =
        PriorityQueue((a, b) => a.cost.compareTo(b.cost));
    PriorityQueue<Structure> sol =
        PriorityQueue((a, b) => a.cost.compareTo(b.cost));
    HashSet<Structure> close = HashSet();
    open.add(s);
    while (open.isNotEmpty) {
      final state = open.removeFirst();
      if (state.isFinal()) sol.add(state);
      close.add(state);
      final states = state.getNextStates();
      for (final state in states) {
        if (!close.contains(state)) {
          if (!open.contains(state)) {
            open.add(state);
          } else if (open.contains(state)) {
            if (state.cost <
                open.toList().firstWhere((element) => element == state).cost) {
              open.remove(state);
              open.add(state);
            }
          }
        }
      }
    }
    return Result(sol.first, close.length);
  }

  Result aStar(Structure s) {
    if (s.isFinal()) return Result(s, 0);
    PriorityQueue<Structure> open =
        PriorityQueue((a, b) => a.cost.compareTo(b.cost));
    HashSet<Structure> close = HashSet();
    s.f = s.calcH();
    open.add(s);
    while (open.isNotEmpty) {
      final state = open.removeFirst();
      if (state.isFinal()) return Result(state, close.length);
      close.add(state);
      final states = state.getNextStates();
      for (final state in states) {
        final h = state.calcH();
        state.f = state.cost + h;
        if (open.contains(state) && open.toList().firstWhere((e) => e == state).f < state.f) {
          continue;
        } else if (close.contains(state) && close.toList().firstWhere((e) => e == state).f < state.f) {
          continue;
        } else {
          open.add(state);
        }
      }
    }
    return Result(null, close.length);
  }
}

class Result {
  final Structure? state;
  final int cost;

  Result(this.state, this.cost);
}
