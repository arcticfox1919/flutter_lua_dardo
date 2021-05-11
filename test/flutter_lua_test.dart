
import 'package:lua_dardo/lua.dart';
import 'package:lua_dardo/debug.dart';
import 'person.dart';

///
/// Example of binding Dart class to Lua
///
void main() {
  LuaState ls = LuaState.newState();
  ls.openLibs();
  Person.require(ls);
  ls.loadFile("test.lua");
  // check the stack,only for debugging
  ls.printStack();
  ls.pCall(0, 0, 1);
}
