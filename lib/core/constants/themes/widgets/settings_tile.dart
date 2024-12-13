import 'package:flutter/material.dart';

import '../../auth/auth_sevice.dart';
import '../../costants.dart';

class SettingsTile extends StatefulWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  State<SettingsTile> createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {
  late bool switchValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: switchValue ? Colors.black : Pallete.lightGrey,
      child: ListTile(
        leading: Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(widget.icon, color: Colors.white),
            )),
        title: Text(
          widget.title,
          style: TextStyle(
            color: switchValue ? Colors.white : Colors.black,
          ),
        ),
        trailing: Switch(
          value: widget.value,
          onChanged: (value) {
            setState(() {
              switchValue = value; 
            });
            widget.onChanged(value); 
          },
        ),
      ),
    );
  }
}
