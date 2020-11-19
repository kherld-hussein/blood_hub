import 'package:blood_hub/screens/notification.dart';
import 'package:blood_hub/screens/profile.dart';
import 'package:blood_hub/screens/settings.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      extendBody: true,
      body: PageView(
        children: [Settings(), Notifications(), Profile()],
      ),
    );
  }
}
