import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:metar/metar.dart';
import 'package:test/test.dart';

const String metarsDirPath = 'test/integration/artifacts/metars';

Iterable<File> listMetars(String path) {
  final dir = Directory(path);
  if (!dir.existsSync()) {
    return Iterable.empty();
  }
  final List<FileSystemEntity> entities = dir.listSync();
  return entities.whereType<File>().where((file) => file.path.endsWith('.bz2'));
}

String decode(String path) {
  final inputStream = InputFileStream(path);
  final archive = BZip2Decoder().decodeBuffer(inputStream);
  return utf8.decode(archive);
}

void createTest(int number, String metar) {
  test('Test ${number.toString().padLeft(5, '0')}: `$metar`', () {
    String bodyRaw = metar.split(' RMK')[0];
    String bodyProcessed = Metar(metar).body.toString();

    expect(bodyRaw, bodyProcessed, reason: '`$metar`');
  });
}

void createTestGroup(File file) {
  group('${file.path.split('/').last.split('.').first}', () {
    List<String> lines = decode(file.path).split('\n');
    for (int i = 0; i < lines.length; ++i) {
      if (lines[i].isNotEmpty) {
        createTest(i, lines[i]);
      }
    }
    ;
  });
}

void main() {
  group('BodyIntegration', () {
    listMetars(metarsDirPath).forEach((file) {
      createTestGroup(file);
    });
  });
}
