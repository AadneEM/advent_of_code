import 'dart:io';

void main(List<String> arguments) {
  final input = File('./bin/input/day01.txt').readAsStringSync();

  List<int> values = input.split('\n').map(int.parse).toList();

  print('Advent of code day 1:');
  // print('Part 1: ${partOne(values)}');
  print('Part 2: ${partTwo(values)}');
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

int partTwo(List<int> values) {
  int? previousValue;
  int index = 0;

  return values.fold<int>(0, (count, currentValue) {
    var treeSum = 0;

    if ((index + 2) >= values.length) return count;

    treeSum = currentValue + values[index + 1] + values[index + 2];
    if (previousValue != null) {
      if (treeSum > previousValue!) count++;
    }

    previousValue = treeSum;
    index++;

    return count;
  });
}
