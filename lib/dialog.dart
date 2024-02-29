
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget{
  final inputTask;
  VoidCallback onSave;

  DialogBox(this.inputTask, this.onSave);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow.shade200,
      content:
          Container(
            height: 200,
            child: Column(
              children: [
                SizedBox(height: 30),

                TextField(
                  controller: inputTask,
                ),
                SizedBox(height: 50),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                        onPressed: () => Navigator.of(context).pop(), child: Text("Cancel")),
                    SizedBox(width: 15),
                    ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                        onPressed: onSave,
                        child: Text("Save"))
                  ],
                )
              ],
            ),
          ),


    );
  }

}