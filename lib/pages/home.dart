import 'package:daywork/data/database.dart';
import 'package:daywork/utils/dialog_box.dart';
import 'package:daywork/utils/todolist.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //reference a box
  final _myBox = Hive.box('myBox');
  ToDoDatabase db = ToDoDatabase();
  //text controller
  final _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    //first time opening the app

    if(_myBox.get("TODO")==null){
      db.createInitialData();
    }else{
      //data is present in the app
      db.loadData();
    }
    super.initState();
  }
  

  //when check box is checked
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todo[index][1] = !db.todo[index][1];
      db.updateData();
    });
  }

  //Saving the task
  void onSaveTask() {
    setState(() {
      db.todo.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  //delete the task
  void deleteTask(int index) {
    setState(() {
      db.todo.removeAt(index);
    });
    db.updateData();
  }

  //alert box creation
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            onCancel: () => Navigator.of(context).pop(),
            onSave: onSaveTask,
            controller: _controller,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          title: Text("TO DO "),
          centerTitle: true,
          elevation: 0.0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: db.todo.length,
            itemBuilder: (context, index) {
              return ToDoList(
                taskname: db.todo[index][0],
                onChanged: (value) => checkBoxChanged(value, index),
                taskCompleted: db.todo[index][1],
                deleteFunction: (context) => deleteTask(index),
              );
            }));
  }
}
