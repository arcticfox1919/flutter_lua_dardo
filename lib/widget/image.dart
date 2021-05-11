
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_lua_dardo/widget/enumerate.dart';
import 'package:flutter_lua_dardo/widget/parameter_exception.dart';
import 'package:lua_dardo/lua.dart';


enum _Image{
  asset,
  file,
  memory,
  network
}

class FlutterImage{
  static const Map<String, DartFunction> _TextWrap = {
    "asset": _asset,
    "file":_file,
    "memory":_memory,
    "network":_network,
    "new":null,
  };

  static const Map<String, DartFunction> _TextMembers = {
    "id": null};

  static int _asset(LuaState ls){
    return _init(ls, _Image.asset);
  }

  static int _file(LuaState ls){
    return _init(ls, _Image.file);
  }

  static int _memory(LuaState ls){
    return 1;
  }

  static int _network(LuaState ls){
    return _init(ls, _Image.network);
  }

  static int _init(LuaState ls,_Image type){
    if(ls.getTop()>0){
      double width, height;
      BoxFit fit;

      var fieldType = ls.getField(-1, "width");
      if(fieldType == LuaType.luaNumber){
        width = ls.toNumber(-1);
        ls.pop(1);
      }else if(fieldType == LuaType.luaNil){
        ls.pop(1);
      }else{
        throw ParameterError(name: 'width',
            type: ls.typeName(fieldType),
            expected: "double",
            source: "FlutterImage _assetText"
        );
      }

      fieldType = ls.getField(-1, "height");
      if(fieldType == LuaType.luaNumber){
        height = ls.toNumber(-1);
        ls.pop(1);
      }else if(fieldType == LuaType.luaNil){
        ls.pop(1);
      }else{
        throw ParameterError(name: 'height',
            type: ls.typeName(fieldType),
            expected: "double",
            source: "FlutterImage _assetText"
        );
      }

      fieldType = ls.getField(-1, "fit");
      if(fieldType == LuaType.luaNumber){
        fit = FlutterBoxFit.get(ls.toIntegerX(-1));
        ls.pop(1);
      }else if(fieldType == LuaType.luaNil){
        ls.pop(1);
      }else{
        throw ParameterError(name: 'fit',
            type: ls.typeName(fieldType),
            expected: "double",
            source: "FlutterImage _assetText"
        );
      }

      String first;
      if(ls.isString(-1)){
        first = ls.toStr(-1);
      }else if(ls.isTable(-1)){
        first = ls.toStr(-2);
      } else{
        throw ParameterError(name: 'first',
            type: ls.typeName(fieldType),
            expected: "String",
            source: "FlutterImage _assetText"
        );
      }

      Userdata u = ls.newUserdata<Image>();
      switch(type){
        case _Image.asset:
          u.data = Image.asset(first,width: width,height: height,fit: fit);
          break;
        case _Image.file:
          u.data = Image.file(File(first),width: width,height: height,fit: fit);
          break;
        case _Image.network:
          u.data = Image.network(first,width: width,height: height,fit: fit);
          break;
      }

      ls.getMetatableAux('ImageClass');
      ls.setMetatable(-2);
    }
    return 1;
  }

  static int _openImageLib(LuaState ls) {
    ls.newMetatable("ImageClass");
    ls.pushValue(-1);
    ls.setField(-2, "__index");
    ls.setFuncs(_TextMembers, 0);

    ls.newLib(_TextWrap);
    return 1;
  }

  static void require(LuaState ls){
    ls.requireF("Image", _openImageLib, true);
    ls.pop(1);
  }
}