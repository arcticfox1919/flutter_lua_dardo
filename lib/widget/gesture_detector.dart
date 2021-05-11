
import 'package:flutter/widgets.dart';
import 'package:flutter_lua_dardo/widget/parameter_exception.dart';
import 'package:lua_dardo/lua.dart';

class FlutterGestureDetector{
  static const Map<String, DartFunction> _gestureDetectorFunc = {
    "new": _newGestureDetector,
  };

  static const Map<String, DartFunction> _gestureMembers = {
    "id":null};

  static int _newGestureDetector(LuaState ls){
    int onTapId = -1;

    if(ls.getTop()>0){
      var fieldType = ls.getField(-1, "onTap");
      if(fieldType == LuaType.luaFunction){
        onTapId = ls.ref(lua_registryindex);
      }else if(fieldType == LuaType.luaNil){
        ls.pop(1);
      }else{
        throw ParameterError(name: 'onTap',
            type: ls.typeName(fieldType),
            expected: "Function",
            source: "FlutterGestureDetector _newGestureDetector"
        );
      }

      Widget child;
      fieldType = ls.getField(-1, "child");
      if(fieldType == LuaType.luaUserdata){
        child = ls.toUserdata(-1).data as Widget;
        ls.pop(1);
      }else if(fieldType == LuaType.luaNil){
        ls.pop(1);
      }else{
        throw ParameterError(name: 'child',
            type: ls.typeName(fieldType),
            expected: "Widget",
            source: "FlutterGestureDetector _newGestureDetector"
        );
      }

      Userdata u = ls.newUserdata<GestureDetector>();
      u.data = GestureDetector(child: child,onTap: (){
        if(onTapId != -1){
          ls.rawGetI(lua_registryindex, onTapId);
          ls.pCall(0, 0, 1);
        }
      });
      ls.getMetatableAux('GestureDetectorClass');
      ls.setMetatable(-2);
    }
    return 1;
  }

  static int _openTextLib(LuaState ls) {
    ls.newMetatable("GestureDetectorClass");
    ls.pushValue(-1);
    ls.setField(-2, "__index");
    ls.setFuncs(_gestureMembers, 0);

    ls.newLib(_gestureDetectorFunc);
    return 1;
  }

  static void require(LuaState ls){
    ls.requireF("GestureDetector", _openTextLib, true);
    ls.pop(1);
  }
}