import 'dart:io';

void main(List<String> arguments) {
  final input = File('./bin/input/day02.txt').readAsStringSync();

  List<String> commands = input.split('\n');

  print('Advent of code day 2:');
  print('Part 1: ${solve(commands)}');
  print('Part 2: ${solve(commands, part2: true)}');
}

int solve(List<String> commands, {bool part2 = false}) {
  final regExp = RegExp(r'(\w+)\s(\d)');
  int hori = 0;
  int aim = 0;
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
        if (part2) {
          depth += aim * amount;
        }
        break;
      case 'down':
        if (!part2) {
          depth += amount;
        } else {
          aim += amount;
        }
        break;
      case 'up':
        if (!part2) {
          depth -= amount;
        } else {
          aim -= amount;
        }
        break;
      default:
        print("Unsupported command '$c'");
    }
  }

  return hori * depth;
}
