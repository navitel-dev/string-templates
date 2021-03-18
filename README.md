# string-templates
A simple library for handling string templates. Now can add symbols  
in string for requierment length (as in example).

## ChangeLog

[ChangeLog.md](CHANGELOG.md)

## Getting Started

Add the following to your **pubspec.yaml**:

```
dependencies:
  string_templates: "^0.0.3"
```

then run **pub install**.

Next, import string-templates:

```
import 'package:string_templates/string_templates.dart';
```

### Example

```
import 'package:string_templates/string_templates.dart' as templates;

void main(List<String> arguments) {
  var params = <String, Object>{'arg1': 10, 'arg2': 20};
  print(templates.interpolate('{arg1:%08d}-{   arg2 }-{arg1}', params));
}

```

```
00000010-20-10
```
