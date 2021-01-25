import 'package:string_templates/string_templates.dart' as templates;

void main(List<String> arguments) {
  var params = <String, dynamic>{'arg1': 10, 'arg2': 20};
  print(templates.interpolate('{arg1:%08d}-{   arg2 }-{arg1}', params));
}
