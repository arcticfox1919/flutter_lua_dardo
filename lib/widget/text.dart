import 'package:flutter/widgets.dart';
import 'package:lua_dardo/lua.dart';



class FlutterText{
  static const Map<String, DartFunction> _TextWrap = {
    "new": _newText,
    "rich":null
  };

  static const Map<String, DartFunction> _TextMembers = {
    "id": null};

  static int _newText(LuaState ls){
    if(ls.getTop()>0){
      var data = ls.toStr(-1);
      Userdata u = ls.newUserdata<Text>();
      u.data = Text(data);
      ls.getMetatableAux('TextClass');
      ls.setMetatable(-2);
    }

    return 1;
  }

  static int _openTextLib(LuaState ls) {
    ls.newMetatable("TextClass");
    ls.pushValue(-1);
    ls.setField(-2, "__index");
    ls.setFuncs(_TextMembers, 0);

    ls.newLib(_TextWrap);
    return 1;
  }

  static void require(LuaState ls){
    ls.requireF("Text", _openTextLib, true);
    ls.pop(1);
  }
}