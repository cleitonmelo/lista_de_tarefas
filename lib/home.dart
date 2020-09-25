import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/helpers/builder.dart';
import 'package:lista_de_tarefas/helpers/file.dart';
import 'package:lista_de_tarefas/model/todo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controler = TextEditingController();

  @override
  void initState() {
    super.initState();
    readData().then((data){
      setState(() {
        ToDo.toDoList = json.decode(data);
      });
    });
  }

  void _onPressed() {
    setState(() {
      ToDo.addToDo(_controler.text);
      _controler.text = "";
    });
  }

  void _onChecked(int index, bool value) {
    setState(() {
      ToDo.setCheckToDo(index, value);
    });
  }

  void _onRemoved(int index){
    setState(() {
      ToDo.removedToDo(index);
    });
  }

  void _onUndoRemoved(int position, dynamic item){
    setState(() {
      ToDo.addItem(position, item);
    });
  }

  Future<Null> _onRefresh() async{
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      ToDo.sortItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomeView(
            onPressed: _onPressed,
            textController: _controler,
            onChecked: _onChecked,
            onRemoved: _onRemoved,
            onUndoRemoved: _onUndoRemoved,
            onRefresh: _onRefresh )
        .build();
  }
}
