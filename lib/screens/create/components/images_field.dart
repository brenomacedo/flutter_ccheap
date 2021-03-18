import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/screens/create/components/image_source_dialog.dart';

class ImagesField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      height: 120,
      child: ListView.builder(
        itemBuilder: (_, index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
            child: GestureDetector(
              onTap: () {
                if(Platform.isAndroid) {
                  showModalBottomSheet(context: context, builder: (_) => ImageSourceDialog());
                } else {
                  showCupertinoModalPopup(context: context, builder: (_) => ImageSourceDialog());
                }
              },
              child: CircleAvatar(
                radius: 44,
                backgroundColor: Colors.grey[300],
                child: Align(
                  alignment: Alignment.center,
                  child: Icon(Icons.camera_alt, color: Colors.white, size: 40)
                ),
              ),
            )
          );
        },
        itemCount: 5,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}