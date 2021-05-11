import 'package:lua_dardo/lua.dart';



class Person {
  static const Map<String, DartFunction> _registry = {
    "new": _newPerson,
  };

  static const Map<String, DartFunction> _personMember = {"sayHi": _sayHi};

  static int _openPersonLib(LuaState ls) {
    ls.newMetatable("PersonClass");
    ls.pushValue(-1);
    ls.setField(-2, "__index");
    ls.setFuncs(_personMember, 0);

    ls.newLib(_registry);
    return 1;
  }

  static int _newPerson(LuaState ls) {
    if(ls.getTop()>0) {
      var data = ls.toStr(-1);
      print("new : $data");
    }
    Userdata u = ls.newUserdata<Person>();
    u.data = Person();
    ls.getMetatableAux('PersonClass');
    ls.setMetatable(-2);
    return 1;
  }

  static int _sayHi(LuaState ls) {
    Person p = ls.toUserdata<Person>(1).data;
    if (ls.isString(-1)) {
      p.sayHi(ls.toStr(-1));
    }
    return 0;
  }

  static void require(LuaState ls){
    ls.requireF("Person", _openPersonLib, true);
    ls.pop(1);
  }


  void sayHi(String name) {
    print("Hi,$name");
  }
}