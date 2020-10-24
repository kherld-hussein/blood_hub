import 'package:blood_hub/widgets/dropdown_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:lottie/lottie.dart';

class ModalWillScope extends StatelessWidget {
  final ScrollController scrollController;

  const ModalWillScope({Key key, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var items = Provider.of<List<String>>(context);
    return Material(
      child: WillPopScope(
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
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            SizedBox(height: 20),
            StreamBuilder<Object>(
                stream: null,
                builder: (context, snapshot) {
                  return UnitDropdown(
                    items: null,
                    hintText: 'County',
                    value: snapshot.data,
                  );
                }),
            MaterialButton(
                onPressed: () {},
                child: Lottie.asset('assets/lottie/start.json')),
            LiteRollingSwitch(
              value: false,
              onChanged: (bool state) {
                print('turned ${(state) ? 'on' : 'off'}');
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: LiteRollingSwitch(
                value: true,
                textOn: 'active',
                textOff: 'inactive',
                colorOn: Colors.deepOrange,
                colorOff: Colors.blueGrey,
                iconOn: Icons.lightbulb_outline,
                iconOff: Icons.power_settings_new,
                onChanged: (bool state) {
                  print('turned ${(state) ? 'on' : 'off'}');
                  if (state) {
                    Get.snackbar('Dismissed', 'Did not save changes');
                  }
                },
              ),
            ),
            // RaisedButton(
            //   onPressed: () {},
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(27)),
            //   ),
            //   color: Colors.red.shade400,
            //   padding: EdgeInsets.symmetric(
            //     vertical: 10,
            //     horizontal: 30,
            //   ),
            //   child: Text(
            //     'Continue',
            //     style: TextStyle(color: Colors.white, fontSize: 23),
            //   ),
            // ),
          ]),
        ),
      ),
    );
  }
}
