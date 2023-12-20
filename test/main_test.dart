import 'package:icons_launcher/src/version.dart';
import 'package:test/test.dart';
import 'package:universal_io/io.dart';
import 'package:yaml/yaml.dart';

// Unit tests for main.dart
void main() {
  test('Version checker', () {
    //! dart run build_runner build
    // Read yaml config file
    final file = File('pubspec.yaml');
    final content = file.readAsStringSync();
    final yaml = loadYaml(content) as Map;

    expect(packageVersion, yaml['version'].toString(),
        reason: 'Version is not correct');
  });

  test('Description checker', () {
    // Read yaml config file
    final file = File('pubspec.yaml');
    final content = file.readAsStringSync();
    final yaml = loadYaml(content) as Map;

    final length = yaml['description'].toString().length;
    expect(length, greaterThan(60),
        reason: 'Description should be greater than 60 characters');
    expect(length, lessThan(180),
        reason: 'Description should be less than 180 characters');
  });
}
