import 'package:daywork/utils/my_buttons.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox({Key? key ,
   required this.controller,
   required this.onCancel,
   required this.onSave
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellowAccent,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //get user input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  hintText: "Add a new Task"),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //add task button
                MyButton(btnName: "Create", onPressed: onSave),

                const SizedBox(
                  width: 8,
                ),

                //cancel button
                MyButton(
                    btnName: "Cancel",
                    onPressed: onCancel)
              ],
            ),

            //
          ],
        ),
      ),
    );
  }
}
