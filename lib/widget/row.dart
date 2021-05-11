import 'package:flutter/widgets.dart';
import 'package:flutter_lua_dardo/widget/_flex.dart';
import 'package:lua_dardo/lua.dart';




class FlutterRow{

  static const Map<String, DartFunction> _rowFunc = {
    "new": _newRow,
  };

  static const Map<String, Object> _const = {

  };

  static int _newRow(LuaState ls){
    if(FlutterFlex.newFlex<Row>(ls,"FlutterRow")){
      return 1;
    }
    throw Exception("Failed to instantiate FlutterFlex!");
  }

  static int _openRowLib(LuaState ls) {
    FlutterFlex.openFlex(ls);

    ls.newLib(_rowFunc);
    return 1;
  }

  static void require(LuaState ls){
    ls.requireF("Row", _openRowLib, true);
    ls.pop(1);
  }
}