import 'dart:io';

Future<String> readJson(String filepath) async {
  return File('test/commons/jsons/$filepath').readAsStringSync();
}
