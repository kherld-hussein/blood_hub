import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade300,
      body: Row(
        children: [
          Container(height: 278),
          Center(
              child: Text(
            'Blood Profile',
            style: TextStyle(fontSize: 30),
          )),
          Container(width: 28),
          Icon(Icons.person)
        ],
      ),
    );
  }
}
