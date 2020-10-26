import 'package:blood_hub/screens/auth/signIn.dart';
import 'package:blood_hub/widgets/dropdown_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:gps/gps.dart';
import 'package:latlng/latlng.dart';
import 'package:lottie/lottie.dart';
import 'package:map/map.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController phone = TextEditingController(text: '+254');
  TextEditingController name = TextEditingController(text: '');
  TextEditingController email = TextEditingController(text: '');
  TextEditingController city = TextEditingController(text: '');
  TextEditingController password = TextEditingController(text: '');
  TextEditingController address = new TextEditingController(text: '');
  TextEditingController zip = new TextEditingController(text: '');

  @override
  void initState() {
    getGps();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  bool _isShowPassWord = false;
  var latlng;

  void _showPassWord() => setState(() {
        _isShowPassWord = !_isShowPassWord;
      });

  final controller = MapController(
    location: LatLng(0.0, 0.0),
  );
  double lat, lng;

  void getGps() async {
    latlng = await Gps.currentGps();
    lat = double.parse(latlng.lat);
    lng = double.parse(latlng.lng);
    setState(() {
      controller.center = LatLng(lat, lng);
      getLocation();
      print(latlng);
    });
  }

  getLocation() async {
    final coordinates = new Coordinates(lat, lng);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print(first.subAdminArea);
    setState(() {
      address.text = first.addressLine;
      zip.text = first.postalCode;
    });
  }

  void writeData() async {
    // ignore: deprecated_member_use
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var dbRef =
        FirebaseDatabase.instance.reference().child('users').child(user.uid);
    dbRef.set({
      'uid': user.uid,
      'name': name.text,
      'phoneNo': phone.text,
      'address': address.text,
      'zip': zip.text,
      'lat': lat.toString(),
      'lng': lng.toString()
    });
  }

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
                      controller: name,
                      validator: (value) {
                        if (value.length == 0) {
                          return 'Can\'t be left blank.';
                        } else {
                          return null;
                        }
                      },
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
                      controller: phone,
                      validator: (value) {
                        if (value.length < 13) {
                          return 'Invalid phone number.';
                        } else {
                          return null;
                        }
                      },
                      style: const TextStyle(fontWeight: FontWeight.w700),
                      textInputAction: TextInputAction.send,
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
                      controller: email,
                      validator: (value) {
                        if (!value.toString().contains("@.com")) {
                          return 'invalid email address';
                        } else {
                          return null;
                        }
                      },
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
                      controller: password,
                      validator: (value) {
                        if (value.length < 6) {
                          return 'password too shot';
                        } else {
                          return null;
                        }
                      },
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
                    StreamBuilder<Object>(
                        stream: null,
                        builder: (context, snapshot) {
                          return UnitDropdown(
                            items: null,
                            hintText: 'County',
                            value: snapshot.data,
                          );
                        }),
                    RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {}
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
}
