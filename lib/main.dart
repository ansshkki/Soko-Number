import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isa/data/board.dart';
import 'package:isa/data/direction.dart';
import 'package:isa/data/levels.dart';
import 'package:isa/src/logic.dart';
import 'package:isa/src/structure.dart';

late Structure s;
late Logic l;

void main() {
  s = Structure(Levels.one, Levels.oneGoals);
  l = Logic();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final focusNode = FocusNode();
  int level = 1;
  int cost = 0;
  int depth = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soko Number',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: RawKeyboardListener(
          focusNode: focusNode,
          onKey: (event) {
            if (event.runtimeType == RawKeyUpEvent) {
              if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                s = s.move(Direction.up);
              } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
                s = s.move(Direction.down);
              } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
                s = s.move(Direction.right);
              } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
                s = s.move(Direction.left);
              }
              setState(() {});
            }
          },
          child: Row(
            children: [
              buildLevelSelector(),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Color(0xffe1e9f9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        s.isFinal() ? "FINISHED!" : "",
                        style:
                            TextStyle(color: Color(0xffff8616), fontSize: 32),
                      ),
                      Expanded(
                        child: Center(
                          child: Board(s),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "${cost != 0 ? "Nodes count: $cost" : ""} | ${depth != 0 ? "Depth: $depth" : ""}",
                            style: TextStyle(
                              color: Color(0xff2d5f7d),
                              fontSize: 24,
                            ),
                          ),
                          Builder(builder: (context) {
                            return OutlinedButton(
                              onPressed: depth == 0
                                  ? null
                                  : () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return PathPreview();
                                          },
                                        ),
                                      ),
                              child: Text("See the path"),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              buildMethodSelector(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLevelSelector() {
    return Container(
      width: 200,
      child: ListView(
        children: [
          ListTile(
            title: Text("Levels:"),
            enabled: false,
          ),
          ListTile(
            title: Text("Level 1"),
            tileColor: level == 1 ? Color(0xffe1e9f9) : Colors.white,
            onTap: () => setState(() {
              level = 1;
              cost = 0;
              depth = 0;
              s = Structure(Levels.one, Levels.oneGoals);
            }),
          ),
          ListTile(
            title: Text("Level 2"),
            tileColor: level == 2 ? Color(0xffe1e9f9) : Colors.white,
            onTap: () => setState(() {
              level = 2;
              cost = 0;
              depth = 0;
              s = Structure(Levels.two, Levels.twoGoals);
            }),
          ),
          ListTile(
            title: Text("Level 3"),
            tileColor: level == 3 ? Color(0xffe1e9f9) : Colors.white,
            onTap: () => setState(() {
              level = 3;
              cost = 0;
              depth = 0;
              s = Structure(Levels.three, Levels.threeGoals);
            }),
          ),
          ListTile(
            title: Text("Level 4"),
            tileColor: level == 4 ? Color(0xffe1e9f9) : Colors.white,
            onTap: () => setState(() {
              level = 4;
              cost = 0;
              depth = 0;
              s = Structure(Levels.four, Levels.fourGoals);
            }),
          ),
          ListTile(
            title: Text("Level 5"),
            tileColor: level == 5 ? Color(0xffe1e9f9) : Colors.white,
            onTap: () => setState(() {
              level = 5;
              cost = 0;
              depth = 0;
              s = Structure(Levels.five, Levels.fiveGoals);
            }),
          ),
          ListTile(
            title: Text("Level 6"),
            tileColor: level == 6 ? Color(0xffe1e9f9) : Colors.white,
            onTap: () => setState(() {
              level = 6;
              cost = 0;
              depth = 0;
              s = Structure(Levels.six, Levels.sixGoals);
            }),
          ),
        ],
      ),
    );
  }

  Widget buildMethodSelector() {
    return Builder(builder: (context) {
      return Container(
        width: 200,
        child: ListView(
          children: [
            ListTile(
              title: Text("Algorithms:"),
              enabled: false,
            ),
            ListTile(
              title: Text("DFS"),
              onTap: () => setState(() {
                s = Structure(Levels.levels[level]!, s.goals);
                var dfs = l.dfs(s);
                if (dfs.state != null) {
                  s = dfs.state!;
                  cost = dfs.cost;
                  depth = dfs.state!.depth;
                }
              }),
            ),
            ListTile(
              title: Text("BFS"),
              onTap: () => setState(() {
                s = Structure(Levels.levels[level]!, s.goals);
                var bfs = l.bfs(s);
                if (bfs.state != null) {
                  s = bfs.state!;
                  cost = bfs.cost;
                  depth = bfs.state!.depth;
                }
              }),
            ),
            ListTile(
              title: Text("UCS"),
              onTap: () => setState(() {
                s = Structure(Levels.levels[level]!, s.goals);
                var ucs = l.ucs(s);
                if (ucs.state != null) {
                  s = ucs.state!;
                  cost = ucs.cost;
                  depth = ucs.state!.depth;
                }
              }),
            ),
            ListTile(
              title: Text("A*"),
              onTap: () => setState(() {
                s = Structure(Levels.levels[level]!, s.goals);
                var aStar = l.aStar(s);
                if (aStar.state != null) {
                  s = aStar.state!;
                  cost = aStar.cost;
                  depth = aStar.state!.depth;
                }
              }),
            ),
          ],
        ),
      );
    });
  }
}

class PathPreview extends StatelessWidget {
  const PathPreview({super.key});

  @override
  Widget build(BuildContext context) {
    List<Structure> path = [];
    var state = s;
    while (state.parent != null) {
      path.add(state);
      state = state.parent!;
    }
    path = path.reversed.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Path preview"),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: path.length,
        itemBuilder: (context, i) {
          return Center(child: Board(path[i]));
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }
}