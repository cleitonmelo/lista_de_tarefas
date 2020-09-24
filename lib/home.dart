import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/helpers/builder.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return homeView();
  }
}
