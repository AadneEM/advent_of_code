import 'dart:io';

void main(List<String> arguments) {
  final input = File('./bin/input/day02.txt').readAsStringSync();

  List<String> commands = input.split('\n');

  print('Advent of code day 2:');
  print('Part 1: ${partOne(commands)}');
}

int partOne(List<String> commands) {
  final regExp = RegExp(r'(\w+)\s(\d)');
  int hori = 0;
  int depth = 0;

  for (final command in commands) {
    final match = regExp.firstMatch(command);
    if (match == null) {
      break;
    }
    final c = match.group(1);
    final amount = int.parse(match.group(2) ?? '0');

    switch (c) {
      case 'forward':
        hori += amount;
        break;
      case 'down':
        depth += amount;
        break;
      case 'up':
        depth -= amount;
        break;
      default:
        print("Unsupported command '$c'");
    }
  }

  return hori * depth;
}
