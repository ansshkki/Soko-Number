enum Direction {
  up,
  down,
  right,
  left;

  void when({
    required Function() up,
    required Function() down,
    required Function() right,
    required Function() left,
  }) {
    switch (this) {
      case Direction.up:
        up();
        break;
      case Direction.down:
        down();
        break;
      case Direction.right:
        right();
        break;
      case Direction.left:
        left();
        break;
    }
  }
}
