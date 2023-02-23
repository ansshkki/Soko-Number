import 'package:isa/data/position.dart';

class Levels {
  static const levels = {
    1: one,
    2: two,
    3: three,
    4: four,
    5: five,
    6: six,
  };

  static const List<List<int>> one = [
    [1, 0, 0, 0, 0],
  ];
  static const List<Position> oneGoals = [
    Position(0, 4),
  ];

  static const List<List<int>> two = [
    [1, -1, 2],
    [0, -1, 0],
    [0, -1, 0],
    [0, -1, 0],
  ];
  static const List<Position> twoGoals = [
    Position(3, 0),
    Position(3, 2),
  ];

  static const List<List<int>> three = [
    [1, 0, 0],
    [-1, 0, -1],
    [0, 0, 2],
  ];
  static const List<Position> threeGoals = [
    Position(2, 1),
    Position(0, 1),
  ];

  static const List<List<int>> four = [
    [1, -1, 2, -1, 3],
    [0, 0, 0, 0, 0],
    [-1, -1, 0, -1, -1],
  ];
  static const List<Position> fourGoals = [
    Position(1, 4),
    Position(1, 2),
    Position(1, 0),
  ];

  static const List<List<int>> five = [
    [1, -1, -1, -1],
    [0, 2, -1, 0],
    [0, 0, 3, 0],
    [0, 0, 0, 4],
  ];
  static const List<Position> fiveGoals = [
    Position(1, 0),
    Position(2, 1),
    Position(3, 2),
    Position(2, 3),
  ];

  static const List<List<int>> six = [
    [0, 0, 2, -1],
    [0, 1, 0, 5],
    [3, -1, 4, 0],
  ];
  static const List<Position> sixGoals = [
    Position(1, 2),
    Position(0, 2),
    Position(2, 2),
    Position(2, 3),
    Position(1, 3),
  ];
}
