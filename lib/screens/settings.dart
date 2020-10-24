import 'dart:convert';
import 'dart:io';

import 'package:blood_hub/widgets/float.dart';
import 'package:floaty_head/floaty_head.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final FloatyHead floatyHead = FloatyHead();
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

  final header = FloatyHeadHeader(
    title: FloatyHeadText(
      text: "Outgoing Call",
      fontSize: 10,
      textColor: Colors.black45,
    ),
    padding: FloatyHeadPadding.setSymmetricPadding(12, 12),
    subTitle: FloatyHeadText(
      text: "8989898989",
      fontSize: 14,
      fontWeight: FontWeight.bold,
      textColor: Colors.black87,
    ),
    decoration: FloatyHeadDecoration(startColor: Colors.grey[100]),
    button: FloatyHeadButton(
        text: FloatyHeadText(
          text: "Personal",
          fontSize: 10,
          textColor: Colors.black45,
        ),
        tag: "personal_btn"),
  );
  final body = FloatyHeadBody(
    rows: [
      EachRow(
        columns: [
          EachColumn(
            text: FloatyHeadText(
                text: "Updated body", fontSize: 12, textColor: Colors.black45),
          ),
        ],
        gravity: ContentGravity.center,
      ),
      EachRow(columns: [
        EachColumn(
          text: FloatyHeadText(
              text: "Updated long data of the body",
              fontSize: 12,
              textColor: Colors.black87,
              fontWeight: FontWeight.bold),
          padding: FloatyHeadPadding.setSymmetricPadding(6, 8),
          decoration: FloatyHeadDecoration(
              startColor: Colors.black12, borderRadius: 25.0),
          margin: FloatyHeadMargin(top: 4),
        ),
      ], gravity: ContentGravity.center),
      EachRow(
        columns: [
          EachColumn(
            text: FloatyHeadText(
                text: "Notes", fontSize: 10, textColor: Colors.black45),
          ),
        ],
        gravity: ContentGravity.left,
        margin: FloatyHeadMargin(top: 8),
      ),
      EachRow(
        columns: [
          EachColumn(
            text: FloatyHeadText(
                text: "Updated random notes.",
                fontSize: 13,
                textColor: Colors.black54,
                fontWeight: FontWeight.bold),
          ),
        ],
        gravity: ContentGravity.left,
      ),
    ],
    padding: FloatyHeadPadding(left: 16, right: 16, bottom: 12, top: 12),
  );
  final footer = FloatyHeadFooter(
    buttons: [
      FloatyHeadButton(
        text: FloatyHeadText(
            text: "Simple button",
            fontSize: 12,
            textColor: Color.fromRGBO(250, 139, 97, 1)),
        tag: "simple_button",
        padding: FloatyHeadPadding(left: 10, right: 10, bottom: 10, top: 10),
        width: 0,
        height: FloatyHeadButton.WRAP_CONTENT,
        decoration: FloatyHeadDecoration(
            startColor: Colors.white,
            endColor: Colors.white,
            borderWidth: 0,
            borderRadius: 0.0),
      ),
      FloatyHeadButton(
        text: FloatyHeadText(
            text: "Focus button", fontSize: 12, textColor: Colors.white),
        tag: "focus_button",
        width: 0,
        padding: FloatyHeadPadding(left: 10, right: 10, bottom: 10, top: 10),
        height: FloatyHeadButton.WRAP_CONTENT,
        decoration: FloatyHeadDecoration(
            startColor: Color.fromRGBO(250, 139, 97, 1),
            endColor: Color.fromRGBO(247, 28, 88, 1),
            borderWidth: 0,
            borderRadius: 30.0),
      )
    ],
    padding: FloatyHeadPadding(left: 16, right: 16, bottom: 12),
    decoration: FloatyHeadDecoration(startColor: Colors.white),
    buttonsPosition: ButtonPosition.center,
  );

  @override
  void initState() {
    super.initState();
    FloatyHead.registerOnClickListener(callBack);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      drawer: Drawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              // IconButton(
              //   icon:
              //       Image.asset('assets/images/drawer.png', color: Colors.red),
              //   onPressed: () => _globalKey.currentState.openDrawer(),
              // ),
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
                      'Kherld Hussein',
                      style:
                          TextStyle(fontSize: 20, color: Colors.red.shade400),
                    ),
                    Text('Kisumu County'),
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
              'Hi Kherld enjoy donating blood and saving lives, you\'re our hero',
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              color: Color(0xffFFF1F1),
              child: Column(
                children: [
                  ListTile(
                      leading: FaIcon(FontAwesomeIcons.bell),
                      title: Text('Notification'),
                      onTap: () => closeFloatyHead()),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cog),
                    title: Text('General'),
                    onTap: () => setIcon(),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.user),
                    title: Text('Account'),
                    onTap: () => setCloseIcon(),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.lock),
                    title: Text('Privacy'),
                    onTap: () => setNotificationIcon(),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.blog),
                    title: Text('Blog'),
                    onTap: () => setCustomHeader(),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.questionCircle),
                    title: Text('Help'),
                    onTap: () => setCloseIconBackground(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void setCustomHeader() {
    floatyHead.updateFloatyHeadContent(
      header: header,
      body: body,
      footer: footer,
    );
  }

  void closeFloatyHead() {
    if (floatyHead.isOpen) {
      floatyHead.closeHead();
    }
  }

  Future<void> setNotificationTitle() async {
    String result;
    try {
      result = await floatyHead
          .setNotificationTitle("OH MY GOD! THEY KILL KENNY!!!");
    } on PlatformException {
      result = 'Failed to get icon. $result';
    }
    if (!mounted) return;
  }

  Future<void> setNotificationIcon() async {
    String result;
    String assetPath = "assets/weight.png";
    try {
      result = await floatyHead.setNotificationIcon(assetPath);
      print(result);
    } on PlatformException {
      result = 'Failed to get icon.';
      print("failed: $result");
    }
    if (!mounted) return;
  }

  Future<void> setIcon() async {
    String result;
    String assetPath = "assets/graph.png";
    try {
      result = await floatyHead.setIcon(assetPath);
    } on PlatformException {
      result = 'Failed to get icon.';
    }
    if (!mounted) return;
  }

  Future<void> setCloseIcon() async {
    String assetPath = "assets/phone.png";
    try {
      await floatyHead.setCloseIcon(assetPath);
    } on PlatformException {
      return;
    }
    if (!mounted) return;
  }

  Future<void> setCloseIconBackground() async {
    String assetPath = "assets/phone.png";
    try {
      await floatyHead.setCloseBackgroundIcon(assetPath);
    } on PlatformException {
      return;
    }
    if (!mounted) return;
  }
}

void callBack(String tag) {
  print('CALLBACK FROM FRAGMENT BUILDED: $tag');
  switch (tag) {
    case "simple_button":
    case "updated_simple_button":
      break;
    case "focus_button":
      print("Focus button has been called");
      break;
    default:
      print("OnClick event of $tag");
  }
}
