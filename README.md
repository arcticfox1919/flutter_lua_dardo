# flutter_lua_dardo

This is an extension of the [LuaDardo](https://github.com/arcticfox1919/LuaDardo) library.LuaDardo library allows Flutter to execute Lua scripts, and this library which mainly wraps some of Flutter's interfaces, which gives Flutter the ability to dynamically update and generate interfaces using remote scripts in places where UI styles need to be changed frequently.

Please note that this is an experimental exploration. It only encapsulates a few simple Widgets. Others are welcome to encapsulate more Widgets for Lua.

![](https://gitee.com/arcticfox1919/ImageHosting/raw/master/img/GIF_2021-5-11_21-44-49.gif)

## Usage

New Lua script `test.lua`:


```lua
function getContent1()
    return Row:new({
        children={
            GestureDetector:new({
                onTap=function()
                    flutter.debugPrint("--------------onTap--------------")
                end,

                child=Text:new("click here")}),
            Text:new("label1"),
            Text:new("label2"),
            Text:new("label3"),
        },
        mainAxisAlign=MainAxisAlign.spaceEvenly,
    })
end

function getContent2()
    return Column:new({
        children={
            Row:new({
                children={Text:new("Hello"),Text:new("Flutter")},
                mainAxisAlign=MainAxisAlign.spaceAround
            }),
            Image:network('https://gitee.com/arcticfox1919/ImageHosting/raw/master/img/flutter_lua_test.png'
                ,{fit=BoxFit.cover})
        },
        mainAxisSize=MainAxisSize.min,
        crossAxisAlign=CrossAxisAlign.center
    })
end
```

In your Flutter project, add the dependency. `pubspec.yaml`

```yaml
dependencies:
  flutter_lua_dardo: ^0.0.2
```

Add Dart code:

```dart
class _MyHomePageState extends State<MyHomePage> {
  LuaState _ls;
  bool isChange = false;
    
  @override
  void initState() {
    loadLua();
    super.initState();
  }
    
  void loadLua() async {
    String src = await rootBundle.loadString('assets/test.lua');
    try {
      LuaState ls = LuaState.newState();
      ls.openLibs();
      FlutterLua.open(ls);
      FlutterWidget.open(ls);
      ls.doString(src);
      setState(() {
        _ls = ls;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: _ls == null
            ? CircularProgressIndicator()
             // call the specified Lua function
            : FlutterWidget.findViewByName<Widget>(
            _ls, isChange ? "getContent2" : "getContent1"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(CupertinoIcons.arrow_swap),
        onPressed: (){
          setState(() {
            isChange = !isChange;
          });
        },
      ),
    );
  }
}
```

**To learn how to bind the Dart class to Lua, you can view this [example](https://github.com/arcticfox1919/flutter_lua_dardo/tree/master/test).**

For usage of LuaDardo, see [here](https://github.com/arcticfox1919/libd/blob/main/README.md).

