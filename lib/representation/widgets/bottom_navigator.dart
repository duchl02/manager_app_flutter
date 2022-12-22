import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigator extends StatelessWidget {
  const BottomNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Tài ',
          backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt),
          label: 'Task',
          backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Dự án',
          backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Nhân viên',
          backgroundColor: Colors.red,
        ),
      ],
    );
  }
}
