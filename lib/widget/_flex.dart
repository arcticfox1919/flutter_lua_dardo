

import 'package:flutter/widgets.dart';
import 'package:flutter_lua_dardo/widget/parameter_exception.dart';
import 'package:lua_dardo/lua.dart';

import 'enumerate.dart';


class FlutterFlex{

  static const className = "FlexClass";

  static const Map<String, DartFunction> _flexMembers = {
    "id": _id};

  static int _id(LuaState ls) {
    Widget p = ls.toUserdata<Object>(1).data;
    ls.pushInteger(identityHashCode(p));
    return 1;
  }

  static void openFlex(LuaState ls) {
    ls.newMetatable(className);
    ls.pushValue(-1);
    ls.setField(-2, "__index");
    ls.setFuncs(_flexMembers, 0);
  }

  static bool newFlex<T>(LuaState ls,[String subclass]){
    var args = ls.getTop();
    if( args == 0 || !ls.isTable(-1)){
      return false;
    }

    MainAxisSize mainAxisSize;
    MainAxisAlignment mainAxisAlignment;
    CrossAxisAlignment crossAxisAlignment;
    List<Widget> children = <Widget>[];

    var fieldType = ls.getField(-1, "mainAxisSize");
    if(fieldType == LuaType.luaNumber){
      mainAxisSize = FlutterMainAxisSize.get(ls.toIntegerX(-1));
      ls.pop(1);
    }else if(fieldType == LuaType.luaNil){
      mainAxisSize = MainAxisSize.max;
      ls.pop(1);
    }else{
      throw ParameterError(name: 'mainAxisSize',
          type: ls.typeName(fieldType),
          expected: "int",
          source: subclass+" newFlex"
      );
    }

    fieldType = ls.getField(-1, "mainAxisAlign");
    if(fieldType == LuaType.luaNumber){
      mainAxisAlignment = FlutterMainAxisAlign.get(ls.toIntegerX(-1));
      ls.pop(1);
    }else if(fieldType == LuaType.luaNil){
      mainAxisAlignment = MainAxisAlignment.start;
      ls.pop(1);
    }else{
      throw ParameterError(name: 'mainAxisAlign',
          type: ls.typeName(fieldType),
          expected: "int",
          source:subclass+" newFlex"
      );
    }

    fieldType = ls.getField(-1, "crossAxisAlign");
    if(fieldType == LuaType.luaNumber){
      crossAxisAlignment = FlutterCrossAxisAlign.get(ls.toIntegerX(-1));
      ls.pop(1);
    }else if(fieldType == LuaType.luaNil){
      crossAxisAlignment = CrossAxisAlignment.center;
      ls.pop(1);
    }else{
      throw ParameterError(name: 'crossAxisAlign',
          type: ls.typeName(fieldType),
          expected: "int",
          source: subclass+" newFlex"
      );
    }

    fieldType = ls.getField(-1, "children");
    if(fieldType == LuaType.luaTable){
      var len = ls.len2(-1);

      for(int i = 1;i<=len;i++){
        if(ls.rawGetI(-1, i) == LuaType.luaUserdata){
          children.add(ls.toUserdata(-1).data as Widget);
        }

        ls.pop(1);
      }
    }else if(fieldType == LuaType.luaNil){
      ls.pop(1);
    }else{
      throw ParameterError(name: 'children',
          type: ls.typeName(fieldType),
          expected: "List",
          source:subclass+" newFlex"
      );
    }

    Userdata u = ls.newUserdata<T>();
    if(T == Column){
      u.data = Column(children: children,mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,mainAxisSize: mainAxisSize,);
    }else if(T == Row){
      u.data = Row(children: children,mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,mainAxisSize: mainAxisSize,);
    }

    ls.getMetatableAux(className);
    ls.setMetatable(-2);

    return true;
  }
}