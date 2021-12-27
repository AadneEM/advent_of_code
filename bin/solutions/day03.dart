import 'dart:io';

void main(List<String> arguments) {
  final input = File('./bin/input/day03.txt').readAsStringSync();

  List<List<int>> bytes = input.split('\n').map((e) => e.trim().split('').map((e) => int.parse(e)).toList()).toList();

  print('Advent of code day 2:');
  print('Part 1: ${solve(bytes)}');
  print('Part 2: ${solve2(bytes)}');
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

int solve2(List<List<int>> bytes) {
  final List<List<int>> oxygen = List.from(bytes);
  final List<List<int>> co2 = List.from(bytes);

  for (int i = 0; i < bytes.first.length; i++) {
    final mostCommon = (oxygen.fold<int>(0, (a, b) => a + b[i]) / oxygen.length).round();
    final leastCommon = (co2.map((e) => e[i]).toList()..removeWhere((e) => e != 1)).length < (co2.length / 2) ? 1 : 0;

    if (oxygen.length > 1) oxygen.removeWhere((e) => e[i] != mostCommon);
    if (co2.length > 1) co2.removeWhere((e) => e[i] != leastCommon);
  }

  int o = int.parse(oxygen.first.join(), radix: 2);
  int c = int.parse(co2.first.join(), radix: 2);

  return o * c;
}
