import 'package:flutter/material.dart';
import 'package:isa/data/position.dart';

import '../src/structure.dart';

class Board extends StatelessWidget {
  final Structure s;

  const Board(this.s, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: s.r * 60.0,
      width: s.c * 60.0,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: s.c,
        ),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: s.r * s.c,
        itemBuilder: buildBlock,
      ),
    );
  }


  Widget buildBlock(BuildContext context, int i) {
    final x = i ~/ s.c;
    final y = i % s.c;
    final cell = s.board[x][y];
    if (cell == -1) {
      return empty(block: true);
    } else if (cell == 0 && s.goals.contains(Position(x, y))) {
      return goal(x, y, reached: false);
    } else if (s.goals.contains(Position(x, y)) &&
        cell == s.goals.indexOf(Position(x, y)) + 1) {
      return goal(x, y, reached: true);
    } else if (cell == 0) {
      return empty();
    } else {
      return numberBlock(cell);
    }
  }

  Widget numberBlock(int cell) => _block(Color(0xff97def2), cell.toString());

  Widget empty({bool block = false}) =>
      _block(block ? Colors.black : Colors.white);

  Widget goal(int x, int y, {required bool reached}) => _block(
    reached ? Color(0xff4ccc7e) : Colors.white,
    "${s.goals.indexOf(Position(x, y)) + 1}",
  );

  Widget _block(Color color, [String? text]) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 3,
      margin: EdgeInsets.all(3),
      child: text == null
          ? null
          : Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24.0,
          ),
        ),
      ),
    );
  }
}
