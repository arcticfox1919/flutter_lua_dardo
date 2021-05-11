

import 'package:flutter/cupertino.dart';

class ParameterError implements Exception{

  String name;
  String type;
  String source;
  String expected;

  ParameterError({
    @required this.name,
    @required this.type,
    @required this.expected,
    @required this.source,
  });

  @override
  String toString() {
    return "The parameter'$name' is wrong, its type is $type, "
        "and the expected type is $expected. The error occurs at $source";
  }
}