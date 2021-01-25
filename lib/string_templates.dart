import 'package:sprintf/sprintf.dart';

const chLeftCurlyBracket = 123;
const chRightCurlyBracket = 125;
const chSpace = 32;
const chColon = 0x3a;

enum ParserState { Template, Argument, Format }

class _ParserContext {
  final Map<String, dynamic> params;

  var state = ParserState.Template;
  var result = '';
  var argument = '';
  var format = '';

  _ParserContext(this.params);

  void addChar(int rune) {
    var ch = String.fromCharCode(rune);
    switch (state) {
      case ParserState.Template:
        result += ch;
        break;
      case ParserState.Argument:
        argument += ch;
        break;
      case ParserState.Format:
        format += ch;
        break;
    }
  }

  void addColon() {
    switch (state) {
      case ParserState.Template:
        result += ':';
        break;
      case ParserState.Argument:
        state = ParserState.Format;
        break;
      case ParserState.Format:
        format += ':';
        break;
    }
  }

  void addSpace() {
    if (state == ParserState.Template) {
      result += ' ';
    }
  }

  void addLeftCurlyBracket() {
    if (state != ParserState.Template) {
      throw Exception('Invalid string template');
    }
    state = ParserState.Argument;
  }

  void addRightCurlyBracket() {
    var value = params[argument];
    if (value != null) {
      result += format.isNotEmpty ? sprintf(format, [value]) : value.toString();
    }
    argument = '';
    format = '';
    state = ParserState.Template;
  }
}

String interpolate(String template, Map<String, dynamic> params) {
  var ctx = _ParserContext(params);
  template.runes.forEach((int rune) {
    switch (rune) {
      case chLeftCurlyBracket:
        ctx.addLeftCurlyBracket();
        break;
      case chRightCurlyBracket:
        ctx.addRightCurlyBracket();
        break;
      case chSpace:
        ctx.addSpace();
        break;
      case chColon:
        ctx.addColon();
        break;

      default:
        ctx.addChar(rune);
    }
  });
  return ctx.result;
}
