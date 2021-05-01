# flutter_lua_dardo

This is an extension of the [LuaDardo](https://github.com/arcticfox1919/LuaDardo) library.It wraps the methods in flutter for lua to call.

## Getting Started

pubspec.yaml

```yaml
  libd:
    git: https://github.com/arcticfox1919/LuaDardo.git
  libd_flutter:
    git: https://github.com/arcticfox1919/flutter_lua_dardo.git
```

Example:

```dart
  // calling the debugPrint() function in lua
  void _call() {
    LuaState state = newState();
    state.openLibs();
    // Initialize this extension
    FlutterLua.init(state);
    state.loadString('''
a=10
while( a < 20 ) do
   flutter.debugPrint("a value is "..a)
   a = a+1
end
''');
    state.call(0, 0);
  }
```

For usage of libd, see [here](https://github.com/arcticfox1919/libd/blob/main/README.md).
