import 'package:blood_hub/models/AppUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModalWillScope extends StatefulWidget {
  final ScrollController scrollController;

  const ModalWillScope({Key key, this.scrollController}) : super(key: key);

  @override
  _ModalWillScopeState createState() => _ModalWillScopeState();
}

class _ModalWillScopeState extends State<ModalWillScope> {
  AppUser currentUser = AppUser();

  @override
  Widget build(BuildContext context) {
    // var items = Provider.of<List<String>>(context);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          bool shouldClose = true;
          await showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                    title: Text('Should Close?'),
                    actions: <Widget>[
                      CupertinoButton(
                        child: Text('Yes'),
                        onPressed: () {
                          shouldClose = true;
                          Navigator.of(context).pop();
                        },
                      ),
                      CupertinoButton(
                        child: Text('No'),
                        onPressed: () {
                          shouldClose = false;
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ));

          return shouldClose;
        },
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: Container(),
            middle: Text('Edit Profile'),
          ),
          child: ListView(children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: currentUser.name,
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'County',
                hintText: currentUser.address,
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                hintText: currentUser.phoneNumber,
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
