import 'package:flutter/material.dart';
import 'package:moodletodo/sqlconn.dart';

class Var {

  static ValueNotifier<List<Task>> assignments = ValueNotifier(List<Task>());
  static updateList() async {
    SQLConn conn = SQLConn();
    //assignments.add(await conn.getTasks());
    //assignments.removeRange(0, assignments.length);
    for(Task t in await conn.getTasks()) {
      //print("name: "+t.name);
      assignments.value.add(t);
    }

  }

  static addList(String name, String due, String nClass, String id) {
    SQLConn conn = SQLConn();
    conn.addTask(name, due, nClass, id);
  }
}