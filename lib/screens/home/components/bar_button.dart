import 'package:flutter/material.dart';

class BarButton extends StatelessWidget {

  BarButton({ this.label, this.decoration, this.onTap });

  final BoxDecoration decoration;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          alignment: Alignment.center,
          child: Text(label, style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600
          )),
          decoration: decoration,
        ),
      )
    );
  }
}