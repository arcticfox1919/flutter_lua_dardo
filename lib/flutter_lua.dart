import 'package:flutter/widgets.dart';
import 'package:lua_dardo/lua.dart';



class FlutterLua{

  static final Map<String, DartFunction> _registry = {
    "debugPrint":_debugPrintWrap,
  };

  static int _openFlutterLib(LuaState ls) {
    ls.newLib(_registry);
    // ls.newTable();
    // ls.setField(-2, "widget");
    return 1;
  }

  static void open(LuaState ls){
    ls.requireF("flutter", _openFlutterLib, true);
    ls.pop(1);
  }

  static int _debugPrintWrap(LuaState ls){
    String s = ls.checkString(1);
    debugPrint(s);
    return 0;
  }
}
