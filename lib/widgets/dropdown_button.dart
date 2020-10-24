import 'package:flutter/material.dart';

class UnitDropdown extends StatelessWidget {
  final List<String> items;
  final String hintText;
  final IconData icon;
  final String value;
  final Function(String) onChanged;

  UnitDropdown(
      {@required this.items,
      @required this.hintText,
      this.icon,
      this.value,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    final items = ['Kisumu', 'Nairobi', 'Mombasa'];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8.0),
      child: Container(
        height: 50,
        width: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .size
            .width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(width: 2.0),
        ),
        child: Row(
          children: <Widget>[
            // Container(width: 35.0, child: ),
            Expanded(
              child: Center(
                child: DropdownButton<String>(
                  items: buildItems(items),
                  value: value,
                  hint: Text(hintText),
                  underline: Container(),
                  onChanged: (value) => onChanged(value),
                ),
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
