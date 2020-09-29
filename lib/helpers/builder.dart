import 'package:flutter/cupertino.dart';
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
      {@required this.onPressed,
      @required this.onChecked,
      @required this.textController,
      @required this.onRemoved,
      @required this.onUndoRemoved,
      @required this.onRefresh});

  Widget build() {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de Tarefas", style: GoogleFonts.lato()),
          backgroundColor: Colors.redAccent,
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
                      labelStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 18.0)),
                  controller: textController,
                ),
              ),
              RaisedButton(
                padding: EdgeInsets.all(15.0),
                color: Colors.redAccent,
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
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: _listView(),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white,
                width: 12,
              ),
            ),
          ),
        ))
      ],
    );
  }

  Widget _listView() {
    if(ToDo.toDoList.isEmpty){
      return _listEmpty();
    }
    return ListView.builder(
      padding: EdgeInsets.only(top: 10.0),
      itemCount: ToDo.toDoList.length,
      itemBuilder: _buildItem,
    );
  }

  Widget _listEmpty() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.thumb_up,
          size: 120,
          color: Colors.white,
        ),
        Divider(),
        Text(
          'Sem tarefa(s) pendente(s)!',
          style: GoogleFonts.lato(fontSize: 26, color: Colors.white),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
          activeColor: Colors.white,
          checkColor: Colors.redAccent,
          title: Text(ToDo.toDoList[index]["title"],
              style: GoogleFonts.aBeeZee(
                fontSize: 18,
                color: Colors.white,
                decoration: ToDo.toDoList[index]["ok"]
                    ? TextDecoration.lineThrough
                    : null,
              )),
          value: ToDo.toDoList[index]["ok"],
          secondary: CircleAvatar(
            child: Icon(
                ToDo.toDoList[index]["ok"] ? Icons.check_circle : Icons.label,
                color: Colors.white),
            backgroundColor: Colors.redAccent,
          ),
          onChanged: (value) {
            return onChecked(index, value);
          }),
      onDismissed: (direction) {
        _lastRemoved = Map.from(ToDo.toDoList[index]);
        _lastRemovedPosition = index;
        onRemoved(index);
        final snack = SnackBar(
          content: Text("Tarefa ${_lastRemoved["title"]} removida."),
          action: SnackBarAction(
            label: "Desfazer",
            onPressed: () {
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
