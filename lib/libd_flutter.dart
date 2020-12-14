library libd_flutter;

import 'package:flutter/widgets.dart';
import 'package:libd/libd.dart';

class FlutterLua{

  static final Map<String, DartFunction> _registry = {
    "debugPrint":_debugPrintWrap
  };

  static int _openFlutterLib(LuaState ls) {
    ls.newLib(_registry);
    return 1;
  }

  static void init(LuaState ls){
    ls.requireF("flutter", _openFlutterLib, true);
    ls.pop(1);
  }

  static int _debugPrintWrap(LuaState ls){
    String s = ls.checkString(1);
    debugPrint(s);
    return 0;
  }
}
