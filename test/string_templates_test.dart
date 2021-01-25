import 'package:string_templates/string_templates.dart';
import 'package:test/test.dart';

void main() {
  test('interpolate', () {
    var values = <String, dynamic>{'arg1': 10, 'arg2': 20};
    expect(
        interpolate('{arg1:%08d}-{   arg2 }-{arg1}', values), '00000010-20-10');
  });
  test('coords', () {
    var values = <String, dynamic>{'x': 1235, 'y': 1411, 'z': 3};
    expect(interpolate('{x:%08i},{y:%08i},{z:%02i}', values),
        '00001235,00001411,03');
  });
}
