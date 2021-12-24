import 'dart:io';

void main(List<String> arguments) {
  final input = File('./bin/input/day03.txt').readAsStringSync();

  List<List<int>> bytes = input.split('\n').map((e) => e.trim().split('').map((e) => int.parse(e)).toList()).toList();

  print('Advent of code day 2:');
  print('Part 1: ${solve(bytes)}');
}

int solve(List<List<int>> bytes) {
  List<int> mostCommonBits = <int>[];

  for (int i = 0; i < bytes.first.length; i++) {
    mostCommonBits.add((bytes.fold<int>(0, (a, b) => a + b[i]) / bytes.length).round());
  }

  final leastCommonBits = mostCommonBits.map((e) => (e + 1) % 2).toList();

  int gamma = int.parse(mostCommonBits.join(), radix: 2);
  int epsilon = int.parse(leastCommonBits.join(), radix: 2);

  return gamma * epsilon;
}
