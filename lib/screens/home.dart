import 'dart:math' as math;

import 'package:blood_hub/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  AnimationController _controller;
  var _breathe = 0.0;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );
    _controller.addStatusListener((breath) {
      if (breath == AnimationStatus.completed) {
        _controller.reverse();
      } else if (breath == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.addStatusListener((status) {
      setState(() {
        _breathe = _controller.value;
      });
    });
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = 200.0 - 20.0 * _breathe;
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 30),
          Text('Good Morning,', style: TextStyle(fontSize: 20)),
          Text(
            'Welcome & help us save Lives',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 30),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            color: Color(0xff00001c),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Looking for the nearest Transfusion Center?\n'
                'Please select a blood group to proceed',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 70),
          Center(
            child: Container(
              height: size,
              width: size,
              child: Transform.rotate(
                angle: -math.pi / 1.3,
                child: Material(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(100),
                    bottomLeft: Radius.circular(100),
                  ),
                  color: Color(0xff00001c),
                  child: Center(
                    child: InkWell(
                      child: FaIcon(
                        FontAwesomeIcons.heartbeat,
                        color: Colors.red,
                        size: 70,
                      ),onTap: (){
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => HomeScreen()));
                    },
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 200),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              color: Color(0xff00001c),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    'T & C of Service',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
