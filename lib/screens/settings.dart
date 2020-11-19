import 'dart:convert';
import 'dart:io';

import 'package:blood_hub/models/AppUser.dart';
import 'package:blood_hub/screens/about.dart';
import 'package:blood_hub/widgets/float.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:floaty_head/floaty_head.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final FloatyHead floatyHead = FloatyHead();
  final InAppReview _inAppReview = InAppReview.instance;
  bool _isAvailable;
  String _appStoreId = '';
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  final String _url = 'path server';
  File _image;

  final picker = ImagePicker();

  Future getImage() async {
    var image = await picker.getImage(
        source: ImageSource.gallery, maxHeight: 120.0, maxWidth: 120.0);
    setState(() {
      _image = File(image.path);
    });
  }

  String city = '';

  Future _submit(BuildContext context) async {
    final form = _formKey.currentState;
    try {
      if (form.validate()) {
        form.save();

        var request = http.MultipartRequest("POST", Uri.parse(_url));
        request.files.add(http.MultipartFile(
            'file',
            File(_image.path).readAsBytes().asStream(),
            File(_image.path).lengthSync(),
            filename: _image.path.split("/").last));

        final response = await request.send();
        final respStr = await response.stream.bytesToString();

        print("response.respStr: $respStr");

        var resp = json.decode(respStr);

        if (resp['data'] == null) {}
      }
    } catch (e) {} finally {}
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  AppUser currentUser = AppUser();

  getUser() async {
    FirebaseUser user = await auth.currentUser();
    final dbRef =
        FirebaseDatabase.instance.reference().child('Users').child(user.uid);
    dbRef.once().then((DataSnapshot snapshot) async {
      currentUser.uid = await snapshot.value['uid'];
      currentUser.phoneNumber = await snapshot.value['phoneNumber'];
      currentUser.zip = await snapshot.value['zip'];
      currentUser.lat = await snapshot.value['lat'];
      currentUser.lng = await snapshot.value['lng'];
      currentUser.name = await snapshot.value['name'];
      currentUser.address = await snapshot.value['address'];
      setState(() {
        print('User fetched');
        getLocation();
      });
    });
  }

  getLocation() async {
    double lat, lng;
    lat = double.parse(currentUser.lat);
    lng = double.parse(currentUser.lng);
    final coordinates = new Coordinates(lat, lng);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print(first.subAdminArea);
    setState(() {
      city = first.subAdminArea;
    });
  }

  @override
  void initState() {
    getUser();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Platform.isIOS || Platform.isMacOS) {
        _inAppReview.isAvailable().then((bool isAvailable) {
          setState(() {
            _isAvailable = isAvailable;
          });
        });
      } else {
        setState(() {
          _isAvailable = false;
        });
      }
    });
    super.initState();
  }

  void _setAppStoreId(String id) => _appStoreId = id;

  Future<void> _openStoreListing() =>
      _inAppReview.openStoreListing(appStoreId: _appStoreId);

  Future<void> _requestReview() => _inAppReview.requestReview();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                ' Settings',
                style: TextStyle(fontSize: 30, color: Colors.red.shade400),
              ),
              CircleAvatar(radius: 30, backgroundColor: Colors.red.shade400)
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _image == null
                    ? InkWell(
                        child: CircleAvatar(
                          radius: 40,
                          child: IconButton(
                            icon: FaIcon(FontAwesomeIcons.userAlt),
                            onPressed: getImage,
                          ),
                        ),
                      )
                    : Image.file(_image),
                SizedBox(width: 20),
                Column(
                  children: [
                    Text(
                      currentUser.name,
                      style:
                          TextStyle(fontSize: 20, color: Colors.red.shade400),
                    ),
                    Text(currentUser.address),
                  ],
                ),
                SizedBox(width: 20),
                CircleAvatar(
                  child: IconButton(
                    icon: FaIcon(FontAwesomeIcons.pen),
                    onPressed: () {
                      showMaterialModalBottomSheet(
                        expand: false,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context, scrollController) =>
                            ModalWillScope(scrollController: scrollController),
                      );
                    },
                  ),
                )
              ],
            ),
            Text(
              'Hi ${currentUser.name} enjoy donating blood and saving lives, you\'re our hero ⚡️',
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              color: Color(0xffFFF1F1),
              child: Column(
                children: [
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.bell),
                    title: Text('Notification'),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cog),
                    title: Text('General'),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.lock),
                    title: Text('Privacy'),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.info),
                    title: Text('About'),
                    onTap: () => Get.to(AboutBlood()),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.questionCircle),
                    title: Text('Review In Store'),
                    onTap: _requestReview,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
