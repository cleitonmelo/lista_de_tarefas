import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget homeView() {
  return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas", style: GoogleFonts.lato()),
        backgroundColor: Colors.deepPurple,
      ),
      body:_body()
  );
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
              padding: EdgeInsets.all(16.0),
              color: Colors.deepPurple,
              child: Text("+", style: TextStyle(fontSize: 25.0),),
              textColor: Colors.white,
              onPressed: (){},
            )
          ],
        ),
      )
    ],
  );
}
