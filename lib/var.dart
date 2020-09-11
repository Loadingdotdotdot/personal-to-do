import 'package:moodletodo/sqlconn.dart';

class Var {
  SQLConn conn = SQLConn();
  static List<Task> assignments = List<Task>();
  updateList() async {
    //assignments.add(await conn.getTasks());
    //assignments.removeRange(0, assignments.length);
    for(Task t in await conn.getTasks()) {
      assignments.add(t);
    }

  }

  addList(String name, String due, String nClass, String id) {
    conn.addTask(name, due, nClass, id);
  }
}