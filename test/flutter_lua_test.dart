
import 'package:lua_dardo/lua.dart';


void main() {
  LuaState ls = newState();
  ls.openLibs();
  ls.doFile("test.lua");
}
