import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade200,
      body: Column(
        children: [
          Container(height: 278),
          Center(
            child: Text('Blood Notifications', style: TextStyle(fontSize: 30)),
          ),
          Icon(Icons.notifications)
        ],
      ),
    );
  }
}
