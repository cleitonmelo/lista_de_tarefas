import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lista_de_tarefas/model/todo.dart';

Widget homeView() {
  return Scaffold(
      appBar: AppBar(
        title: Text("Tarefas", style: GoogleFonts.lato()),
        backgroundColor: Colors.deepPurple,
      ),
      body: _body());
}

Widget _body() {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.fromLTRB(17.0, 10.0, 7.0, 1.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                    labelText: "Nova Tarefa",
                    labelStyle: TextStyle(color: Colors.deepPurpleAccent)),
              ),
            ),
            RaisedButton(
              padding: EdgeInsets.all(15.0),
              color: Colors.deepPurple,
              shape: CircleBorder(),
              child: Icon(Icons.add),
              textColor: Colors.white,
              onPressed: () {},
            )
          ],
        ),
      ),
      Expanded(
        child: listView(),
      )
    ],
  );
}

Widget listView() {
  return ListView.builder(
    padding: EdgeInsets.only(top: 10.0),
    itemCount: toDoList.length,
    itemBuilder: (context, index) {
      return CheckboxListTile(
        title: Text(toDoList[index]["title"]),
        value: toDoList[index]["ok"],
        secondary: CircleAvatar(
          child: Icon(toDoList[index]["ok"] ? Icons.check : Icons.error),
          
        ),
      );
    },
  );
}
