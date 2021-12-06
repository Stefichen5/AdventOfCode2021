import 'dart:async';
import 'dart:io';

import 'package:test/test.dart';

void main(List<String> arguments) async {
  final days = 256;

  var file = File('/path/to/Advent/2021/Day6/input.txt');

  await file.exists();

  var fishes_string = file.readAsStringSync();
  var fishList = fishes_string.split(',').map((e) => int.parse(e)).toList();

  for (var curday = 0; curday < days; curday++) {
    var len = fishList.length;
    for (var i = 0; i < len; i++) {
      if (fishList[i] == 0) {
        fishList[i] = 6;
        fishList.add(8);
      } else {
        fishList[i] = fishList[i] - 1;
      }
    }
  }

  print(fishList.length);
}
