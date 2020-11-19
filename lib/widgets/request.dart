import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class RequestBlood extends StatefulWidget {
  @override
  _RequestBloodState createState() => _RequestBloodState();
}

class _RequestBloodState extends State<RequestBlood> {
  final items = [
    'Kisumu Regional Center',
    'Nairobi Nation Donation',
    'Mombasa Blood Center'
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return WillPopScope(
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
        // Get.snackbar('Dismissed', 'Did not save changes');
        return shouldClose;
      },
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          // leading: Container(),
          middle: Text('Make Donation Request'),
        ),
        child: ListView(
          padding: EdgeInsets.fromLTRB(20, 100, 10, 20),
          children: [
            SizedBox(height: 20),
            Material(
              child: TextFormField(
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
            ),
            SizedBox(height: 20),
            Material(
              child: StreamBuilder<Object>(
                  stream: null,
                  builder: (context, snapshot) {
                    return DropdownButton<String>(
                      items: buildItems(items),
                      value: snapshot.data,
                      hint: Text('Center'),
                      underline: Container(),
                      onChanged: (value) => (value),
                    );
                  }),
            ),
            SizedBox(height: 30),
            Material(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Age',
                  hintText: 'Full Age',
                  border: OutlineInputBorder(
                    gapPadding: 10,
                    borderRadius: BorderRadius.circular(0.039.hp),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ),
            Material(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Gender',
                  hintText: 'Full Gender',
                  border: OutlineInputBorder(
                    gapPadding: 10,
                    borderRadius: BorderRadius.circular(0.039.hp),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
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
    );
  }

  List<DropdownMenuItem<String>> buildItems(List<String> items) {
    return (items != null)
        ? items
            .map(
              (item) => DropdownMenuItem<String>(
                child: Text(item, textAlign: TextAlign.center),
                value: item,
              ),
            )
            .toList()
        : [];
  }
}

class DateTimeForm extends StatefulWidget {
  @override
  _DateTimeFormState createState() => _DateTimeFormState();
}

class _DateTimeFormState extends State<DateTimeForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BasicDateField(),
          SizedBox(height: 24),
          BasicTimeField(),
          SizedBox(height: 24),
          RaisedButton(
            child: Text('Save'),
            onPressed: () => formKey.currentState.save(),
          ),
          RaisedButton(
            child: Text('Reset'),
            onPressed: () => formKey.currentState.reset(),
          ),
          RaisedButton(
            child: Text('Validate'),
            onPressed: () => formKey.currentState.validate(),
          ),
        ],
      ),
    );
  }
}

class BasicDateField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic date field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    ]);
  }
}

class BasicTimeField extends StatelessWidget {
  final format = DateFormat("hh:mm a");

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic time field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}
