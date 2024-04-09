import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todobasic/dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late SharedPreferences sp;
  List toDoList = [];
  final textValue = TextEditingController();

  @override
  void initState() {
    super.initState();
    getValue();
  }

  void getValue() async {
    sp = await SharedPreferences.getInstance();
    String? savedTask = sp.getString('task');
    setState(() {
      if (savedTask != null && savedTask.isNotEmpty) {
        toDoList =
            savedTask.split(';').where((task) => task.isNotEmpty).toList();
      }
    });
  }

  void deleteTask(int index){
    setState(() {
      toDoList.removeAt(index);
      saveValue();
    });
  }

  void saveValue() {
    String taskString = toDoList.join(';');
    sp.setString("task", taskString);
  }

  void saveNewTask() {
    setState(() {
      toDoList.add(textValue.text);
      saveValue();
      textValue.clear();
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade300,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text("Basic ToDo"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        child: ListView.builder(
          itemCount: toDoList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Card(
                  color: Colors.yellow.shade200,
                  borderOnForeground: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: StretchMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) => deleteTask(index),
                          borderRadius: BorderRadius.circular(15),
                          icon: Icons.delete,
                          backgroundColor: Colors.red,
                        )
                      ],
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.yellow),
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Text(toDoList[index]),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20)
              ],
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return DialogBox(textValue, saveNewTask);
            },
          );
        },
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
