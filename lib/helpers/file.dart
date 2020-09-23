import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

const _FILE_NAME = "data.json";

Future<File> _getFile() async{
  final directory = await getApplicationDocumentsDirectory();
  return File("${directory.path}/$_FILE_NAME");
}

Future<File> saveData(List values) async{
  String data = json.encode(values);
  final file = await _getFile();
  return file.writeAsString(data);
}

Future<String> readData() async{
  try{
    final file = await _getFile();
    return file.readAsString();
  }catch(e){
    return null;
  }
}