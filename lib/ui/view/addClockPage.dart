import 'package:flutter/material.dart';

class AddClockPage extends StatefulWidget {
  const AddClockPage({Key? key}) : super(key: key);

  @override
  _AddClockPageState createState() => _AddClockPageState();
}

class _AddClockPageState extends State<AddClockPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Text("item1"),
          Text("item2"),
          Text("item3"),
        ],
      ),
    );
  }
}
