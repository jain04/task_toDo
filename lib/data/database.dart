
import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase{
  List todo = [];
  //reference the box
  final _myBox = Hive.box('myBox');

  // run the method if the app is installed for first time
  void createInitialData(){
    todo = [
      ["This is the demo",false],
      ["This is just for testing",false]
    ];
  }

  //load the data
  void loadData(){
    todo = _myBox.get("TODO");
  }

  //update the data
  void updateData(){
    _myBox.put("TODO", todo);
  }
}