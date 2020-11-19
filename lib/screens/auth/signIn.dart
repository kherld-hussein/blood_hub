import 'package:blood_hub/screens/auth/signUp.dart';
import 'package:blood_hub/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController phone = TextEditingController(text: '');
  TextEditingController otp = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();
  FirebaseUser _firebaseUser;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('SignIn', style: TextStyle(fontSize: 30)),
                    InkWell(
                      child: Text('SignUp', style: TextStyle(fontSize: 20)),
                      onTap: () => Get.to(SignUpScreen(),
                          transition: Transition.rightToLeft),
                    ),
                  ],
                ),
              ),
              toolbarHeight: 200,
              backgroundColor: Colors.red.shade400,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Lottie.asset(
                    'assets/lottie/loading.json',
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomLeft,
                    height: 100,
                  ),
                  Lottie.asset(
                    'assets/lottie/loader.json',
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomLeft,
                    height: 100,
                  ),
                ],
              ),
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
                      validator: (value) {
                        if (value.length < 10) {
                          return 'Invalid phone number';
                        } else {
                          return null;
                        }
                      },
                      controller: phone,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Enter Mobile Number',
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
                      validator: (value) {
                        if (value.length < 6) {
                          return 'Invalid OTP';
                        } else {
                          return null;
                        }
                      },
                      controller: otp,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Enter OTP',
                        border: OutlineInputBorder(
                          gapPadding: 10,
                          borderRadius: BorderRadius.circular(0.039.hp),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _onFormSubmitted();
                        }
                      },
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
      ),
    );
  }

  void showToast(message, Color color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: color,
      fontSize: 16.0,
    );
  }

  bool isCodeSent = false;
  String _verificationId;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void _onVerifyCode() async {
    setState(() {
      isCodeSent = true;
    });

    final PhoneVerificationCompleted verificationCompleted =
        (phoneAuthCredential) {
      _firebaseAuth
          .signInWithPhoneNumber(
              verificationId: _verificationId, smsCode: otp.text)
          .then((value) {
        if (value != null) {
          final dbRef = FirebaseDatabase.instance
              .reference()
              .child('users')
              .child(value.uid);
          dbRef.once().then((DataSnapshot snapshot) async {
            if (snapshot.value == null) {
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) => SignUpScreen(),
                ),
              );
            } else {
              print(snapshot.value);
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) => Home(),
                ),
              );
            }
          });
        } else {
          showToast("Error validating OTP, try again", Colors.white);
        }
      }).catchError((error) {
        showToast("Try again in sometime", Colors.white);
      });
    };
    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      showToast(authException.message, Colors.white);
      setState(() {
        isCodeSent = false;
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      showToast('sent', Colors.white);
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+254${phone.text}",
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void _onFormSubmitted() async {
    _firebaseAuth
        .signInWithPhoneNumber(
            verificationId: _verificationId, smsCode: otp.text)
        .then((value) {
      if (value != null) {
        final dbRef = FirebaseDatabase.instance
            .reference()
            .child('users')
            .child(value.uid);
        dbRef.once().then((DataSnapshot snapshot) async {
          if (snapshot.value == null) {
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (context) => SignUpScreen(),
              ),
            );
          } else {
            print(snapshot.value);
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (context) => Home(),
              ),
            );
          }
        });
      } else {
        showToast("Error validating OTP, try again", Colors.white);
      }
    });
  }
}
