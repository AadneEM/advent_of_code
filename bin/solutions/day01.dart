import 'dart:io';

void main(List<String> arguments) {
  final input = File('./bin/input/day01.txt').readAsStringSync();

  List<int> values = input.split('\n').map(int.parse).toList();

  print('Advent of code day 1:');
  print('Part 1: ${partOne(values)}');
}

int partOne(List<int> values) {
  int? previousValue;

  return values.fold<int>(0, (count, currentValue) {
    if (previousValue != null) {
      if (currentValue > previousValue!) count++;
    }
    previousValue = currentValue;
    return count;
  });
}
