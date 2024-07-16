import 'package:flutter/material.dart';
import 'package:todo_aap/customExtension/customExtension.dart';
import 'package:todo_aap/theme/myColors.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorTheme.whiteBold,
        actions: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/profilepic.png'),
          ).padAll(8)
        ],
      ),
    );
  }
}
