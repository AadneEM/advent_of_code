import 'dart:io';

void main(List<String> arguments) {
  final input = File('./bin/input/day04.txt').readAsStringSync();

  List<String> parts = input.split('\n');
  List<int> draws = parts.removeAt(0).split(',').map((e) => int.parse(e)).toList();

  List<List<List<int>>> values = [];

  for (int i = 0; i < parts.length; i++) {
    final part = parts[i].trim();
    if (part.trim().isEmpty) {
      values.add([]);
    } else {
      values.last.add(part.split(RegExp(r'\s+')).map((e) => int.parse(e)).toList());
    }
  }

  List<Board> boards = List.generate(values.length, (i) => Board(values[i]));

  print('Advent of code day 4:');
  print('Part 1: ${solve(draws, boards)}');
}

int solve(List<int> draws, List<Board> boards) {
  var bingoIndex = -1;
  var lastDraw = -1;
  for (int draw in draws) {
    for (Board board in boards) {
      board.check(draw);
    }

    bingoIndex = boards.indexWhere((board) => board.checkBingo());
    if (bingoIndex >= 0) {
      lastDraw = draw;
      print('Found bingo board at index $bingoIndex, last draw: $lastDraw');
      print('Board:\n${boards[bingoIndex].toString()}');
      break;
    }
  }

  final bingoBoard = boards[bingoIndex];
  var unCheckedSum = bingoBoard.getUnChecked().fold<int>(0, (a, b) => a + b);
  print('Un-checked sum: $unCheckedSum');

  return unCheckedSum * lastDraw;
}

class Board {
  final List<List<int>> values;
  late final List<List<bool>> checked;

  Board(this.values) {
    checked = List.generate(values.first.length, (_) => List.generate(values.first.length, (__) => false));
  }

  @override
  String toString() {
    return values
        .map((row) => row
            .map((value) => '${value.toString().padLeft(2, ' ')} [${checked[values.indexOf(row)][row.indexOf(value)] ? 'x' : ' '}]')
            .join('\t'))
        .join('\n');
  }

  void check(int number) {
    for (int i = 0; i < values.length; i++) {
      for (int j = 0; j < values[i].length; j++) {
        if (values[i][j] == number) {
          checked[i][j] = true;
        }
      }
    }
  }

  bool checkBingo() {
    return checkRowBingo() || checkColumnBingo();
  }

  bool checkRowBingo() {
    return checked.any((row) => !row.any((check) => !check));
  }

  bool checkColumnBingo() {
    for (int i = 0; i < checked.first.length; i++) {
      if (!checked.map((e) => e[i]).any((check) => !check)) {
        return true;
      }
    }
    return false;
  }

  List<int> getUnChecked() {
    final unChecked = <int>[];
    for (int i = 0; i < values.length; i++) {
      for (int j = 0; j < values[i].length; j++) {
        if (!checked[i][j]) {
          unChecked.add(values[i][j]);
        }
      }
    }
    return unChecked;
  }
}
