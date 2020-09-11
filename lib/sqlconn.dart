import 'package:http/http.dart';
import 'dart:convert';

class SQLConn {

  Future<List<Task>> _getAssignments() async {
    String url = 'http://srinath.tech/api/info';
    Response response = await get(url);
    int statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    String json = response.body;
    Map decoded = jsonDecode(json);
    List<Task> tasks = new List<Task>();
    for (var entry in decoded['info']) {
      //print("Name: " + entry['Name'])
      tasks.add(new Task(entry['Name'], entry['Due'], entry['Class'], entry['Id']));
    }
    return tasks;
  }

  getTasks() async{
    return await _getAssignments();
  }

  _addTask(String name, String due, String nClass, String id) async {
    String url = 'http://srinath.tech/api/add-to-do';
    Map<String, String> headers = {"Content-type": "application/x-www-form-urlencoded"};
    Map data = {
      "name": name,
      "due": due,
      "class": nClass,
      "id": id
    };

    Response response = await post(url, headers: headers, body: data);
    int statusCode = response.statusCode;
    String body = response.body;
    print("BODY" + body);
  }

  addTask(String name, String due, String nClass, String id) async{
    await _addTask(name, due, nClass, id);
  }


}

class Task {
  Task(this.name, this.due, this.nClass, this.id);
  final String name;
  final String due;
  final String nClass;
  final String id;
}