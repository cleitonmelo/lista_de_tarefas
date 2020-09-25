import 'package:lista_de_tarefas/helpers/file.dart';

class ToDo {
  static List toDoList = [];

  String title;
  bool check;

  static const bool _DEFAULT_EXECUTED = false;

  static void addToDo(String title) {
    Map<String, dynamic> toDo = new Map();
    toDo["title"] = title;
    toDo["ok"] = _DEFAULT_EXECUTED;
    toDoList.add(toDo);
    saveData(toDoList);
  }

  static void setCheckToDo(int index, bool value) {
    toDoList[index]["ok"] = value;
    saveData(toDoList);
  }

  static void removedToDo(int index) {
    toDoList.removeAt(index);
    saveData(toDoList);
  }

  static void addItem(int position, dynamic item) {
    toDoList.insert(position, item);
    saveData(toDoList);
  }

  static void sortItems(){
    toDoList.sort((a, b) {
      if (a["ok"] && !b["ok"])
        return 1;
      else if (!a["ok"] && b["ok"])
        return -1;
      else
        return 0;
    });
    saveData(toDoList);
  }
}
