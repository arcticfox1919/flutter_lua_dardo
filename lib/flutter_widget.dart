import 'package:flutter/widgets.dart';
import 'package:flutter_lua_dardo/widget/column.dart';
import 'package:flutter_lua_dardo/widget/enumerate.dart';
import 'package:flutter_lua_dardo/widget/gesture_detector.dart';
import 'package:flutter_lua_dardo/widget/image.dart';
import 'package:flutter_lua_dardo/widget/row.dart';
import 'package:flutter_lua_dardo/widget/text.dart';
import 'package:lua_dardo/lua.dart';




class FlutterWidget{

  static void open(LuaState ls){
    FlutterCrossAxisAlign.require(ls);
    FlutterMainAxisAlign.require(ls);
    FlutterMainAxisSize.require(ls);
    FlutterBoxFit.require(ls);
    FlutterRow.require(ls);
    FlutterColumn.require(ls);
    FlutterText.require(ls);
    FlutterImage.require(ls);
    FlutterGestureDetector.require(ls);
  }


  static T findViewByName<T extends Widget>(LuaState ls,String name){
    ls.getGlobal(name);
    ls.pCall(0, 1, 1);
    if(ls.isUserdata(-1)){
      var w = ls.toUserdata<T>(-1).data;
      ls.setTop(0);
      return w;
    }
    throw Exception("Cannot find $name, "
        "please check the function name in the Lua script.");
  }

}