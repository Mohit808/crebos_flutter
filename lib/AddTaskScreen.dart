import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Add Task"),),
      body: SingleChildScrollView(
        child: Column(children: [
          TextField(decoration: InputDecoration(hintText: "Title..."),),
          TextField(decoration: InputDecoration(hintText: "Description..."),),
        ],),
      ),
    );
  }
}
