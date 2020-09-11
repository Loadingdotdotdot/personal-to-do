import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moodletodo/sqlconn.dart';
import 'package:moodletodo/var.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'To-Do'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  showAddDialog(BuildContext context) {

    TextEditingController tc = TextEditingController();
    TextEditingController dc = TextEditingController();
    TextEditingController cc = TextEditingController();
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Add"),
      onPressed: () {
        setState(() {
          //print(tc.text);
          //assignments.add(tc.text);
          Var.addList(tc.text, dc.text, cc.text, "14567");
          Var.assignments.value.add(Task(tc.text, dc.text, cc.text, "12345"));
          //sleep(const Duration(seconds: 1));
          //vars.updateList();
        });
        Navigator.pop(context);
      },
    );



    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Add an assignment"),
      content: Column(
        children: <Widget>[
          TextField(
            controller: tc,
          ),
          TextField(
            controller: dc,
          ),
          TextField(
            controller: cc,
          ),
        ],
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  @override
  void initState() {
    super.initState();
    Var.updateList();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(
            Icons.refresh
          ),
          onPressed: () {
            Var.assignments.value.clear();
            Var.updateList();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: ValueListenableBuilder<List<Task>>(
          valueListenable: Var.assignments,
          builder: (BuildContext context, List value, Widget child) {
            return Column(
              children: Var.assignments.value.map((e) {
                bool cb = false;
                return CheckboxListTile(
                  title: Text(e.name),
                  value: cb,
                  onChanged: (bool value) {
                    cb = !cb;
                  },
                );
              }).toList(),
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {showAddDialog(context)},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
