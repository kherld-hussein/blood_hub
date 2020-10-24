import 'package:blood_hub/screens/notification.dart';
import 'package:blood_hub/screens/profile.dart';
import 'package:blood_hub/screens/settings.dart';

// import 'package:custom_navigation_bar/custom_navigation_bar.dart';
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

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      extendBody: true,
      // bottomNavigationBar: _buildFloatingBar(),
      body: PageView(
        children: [Settings(), Notifications(), Profile()],
      ),
    );
  }

  // Widget _buildFloatingBar() {
  //   // return CustomNavigationBar(
  //   //   iconSize: 30.0,
  //   //   selectedColor: Color(0xff0c18fb),
  //   //   strokeColor: Color(0x300c18fb),
  //   //   unSelectedColor: Colors.grey[600],
  //   //   backgroundColor: Colors.white,
  //   //   borderRadius: Radius.circular(20.0),
  //   //   items: [
  //   //     CustomNavigationBarItem(
  //   //       icon: FontAwesomeIcons.home,
  //   //     ),
  //   //     CustomNavigationBarItem(
  //   //       icon: FontAwesomeIcons.home,
  //   //     ),
  //   //     CustomNavigationBarItem(
  //   //       icon: FontAwesomeIcons.home,
  //   //     ),
  //   //     CustomNavigationBarItem(
  //   //       icon: FontAwesomeIcons.home,
  //   //     ),
  //   //     CustomNavigationBarItem(
  //   //       icon: FontAwesomeIcons.home,
  //   //     ),
  //   //   ],
  //   //   currentIndex: _currentIndex,
  //   //   onTap: (index) {
  //   //     setState(() {
  //   //       _currentIndex = index;
  //   //     });
  //   //   },
  //   //   isFloating: true,
  //   // );
  // }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
