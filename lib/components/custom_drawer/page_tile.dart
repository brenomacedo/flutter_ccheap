import 'package:flutter/material.dart';

class PageTile extends StatelessWidget {

  final String label;
  final IconData icon;
  final Function onTap;
  final bool highlighted;

  PageTile({ this.label, this.icon, this.onTap, this.highlighted });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label, style: TextStyle(color: highlighted ? Colors.purple : Colors.black54,
        fontWeight: FontWeight.w700)),
      leading: Icon(icon, color: highlighted ? Colors.purple : Colors.black),
      onTap: onTap,
    );
  }
}