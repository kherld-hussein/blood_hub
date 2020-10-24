import 'package:blood_hub/screens/auth/signIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final passwordController = TextEditingController();
  bool _isShowPassWord = false;

  void _showPassWord() => setState(() {
        _isShowPassWord = !_isShowPassWord;
      });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('SignUp', style: TextStyle(fontSize: 30)),
                  InkWell(
                    child: Text('SignIn', style: TextStyle(fontSize: 20)),
                    onTap: () => Get.to(SignInScreen(),
                        transition: Transition.rightToLeft),
                  ),
                ],
              ),
            ),
            toolbarHeight: 200,
            backgroundColor: Colors.red.shade400,
          ),
          SliverFillRemaining(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 0.076.wp,
                vertical: ScreenUtil().setHeight(50.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'username',
                      hintText: 'Full Name',
                      border: OutlineInputBorder(
                        gapPadding: 10,
                        borderRadius: BorderRadius.circular(0.039.hp),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      hintText: '+254 7922 818 71',
                      border: OutlineInputBorder(
                        gapPadding: 10,
                        borderRadius: BorderRadius.circular(0.039.hp),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'email',
                      hintText: 'kherld.hussein@gmail.com',
                      border: OutlineInputBorder(
                        gapPadding: 10,
                        borderRadius: BorderRadius.circular(0.039.hp),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Strong pass',
                      suffixIcon: IconButton(
                        icon: FaIcon(
                          _isShowPassWord
                              ? FontAwesomeIcons.solidEyeSlash
                              : FontAwesomeIcons.solidEye,
                        ),
                        onPressed: () => _showPassWord(),
                      ),
                      border: OutlineInputBorder(
                        gapPadding: 10,
                        borderRadius: BorderRadius.circular(0.039.hp),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    obscureText: !_isShowPassWord,
                  ),
                  RaisedButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(27)),
                    ),
                    color: Colors.red.shade400,
                    padding: EdgeInsets.symmetric(
                      vertical: 0.0357.wp,
                      horizontal: 30,
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(color: Colors.white, fontSize: 23),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
