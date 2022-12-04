import 'package:flutter/material.dart';

import 'add_list_screen.dart';

class HomeScreen extends StatelessWidget {
  final String appBarText;

  const HomeScreen({
    super.key,
    required this.appBarText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_circle_rounded),
            onPressed: () {
              showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return const AddListScreen();
                  });
            },
          ),
        ],
      ),
    );
  }
}
