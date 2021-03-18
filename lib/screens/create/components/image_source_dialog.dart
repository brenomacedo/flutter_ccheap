import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageSourceDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(Platform.isAndroid)
      return BottomSheet(onClosing: () {

      }, builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(onPressed: () {}, child: Text('Camera')),
          TextButton(onPressed: () {}, child: Text('Galeria'))
        ],
      ));
    else
      return CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(onPressed: () {

          }, child: Text('Camera')),
          CupertinoActionSheetAction(onPressed: () {

          }, child: Text('Galeria'))
        ],
        title: Text('Selecionar foto para o anúncio'),
        message: Text('Escolha a origem da foto'),
        cancelButton: CupertinoActionSheetAction(
          child: Text('Cancelar', style: TextStyle(color: Colors.red)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
  }
}