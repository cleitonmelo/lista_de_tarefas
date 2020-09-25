import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lista_de_tarefas/model/todo.dart';

class HomeView {
  Map<String, dynamic> _lastRemoved;
  int _lastRemovedPosition;

  Function onPressed;
  Function onChecked;
  Function onRemoved;
  Function onRefresh;
  Function onUndoRemoved;

  TextEditingController textController;

  HomeView(
      {@required onPressed,
      @required onChecked,
      @required textController,
      @required onRemoved,
      @required onUndoRemoved,
      @required onRefresh}) {
    this.onPressed = onPressed;
    this.onChecked = onChecked;
    this.textController = textController;
    this.onRemoved = onRemoved;
    this.onUndoRemoved = onUndoRemoved;
    this.onRefresh = onRefresh;
  }

  Widget build() {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tarefas", style: GoogleFonts.lato()),
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
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
                  controller: textController,
                ),
              ),
              RaisedButton(
                padding: EdgeInsets.all(15.0),
                color: Colors.deepPurple,
                shape: CircleBorder(),
                child: Icon(Icons.add),
                textColor: Colors.white,
                onPressed: onPressed,
              )
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
              onRefresh: onRefresh,
              child: _listView(),
          )
        )
      ],
    );
  }

  Widget _listView() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10.0),
      itemCount: ToDo.toDoList.length,
      itemBuilder: _buildItem,
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
          title: Text(ToDo.toDoList[index]["title"],
              style: GoogleFonts.lato(
                fontSize: 22,
                color: Colors.deepPurple,
                decoration: ToDo.toDoList[index]["ok"]
                    ? TextDecoration.lineThrough
                    : null,
              )),
          value: ToDo.toDoList[index]["ok"],
          secondary: CircleAvatar(
            child: Icon(ToDo.toDoList[index]["ok"] ? Icons.check : Icons.label),
          ),
          onChanged: (value) {
            return onChecked(index, value);
          }),
      onDismissed: (direction) {
        _lastRemoved = Map.from(ToDo.toDoList[index]);
        _lastRemovedPosition = index;
        onRemoved(index);
        final snack = SnackBar(
          content: Text("Tarefa ${ _lastRemoved["title"] } removida."),
          action: SnackBarAction(
            label: "Desfazer",
            onPressed: (){
              onUndoRemoved(_lastRemovedPosition, _lastRemoved);
            },
          ),
          duration: Duration(seconds: 2),
        );
        Scaffold.of(context).removeCurrentSnackBar();
        Scaffold.of(context).showSnackBar(snack);
      },
    );
  }
}
