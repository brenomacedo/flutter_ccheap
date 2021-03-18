import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {

  final dynamic image;
  final VoidCallback onDelete;

  ImageDialog({ this.image, this.onDelete });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          Image.file(image),
          TextButton(onPressed: () {
            Navigator.of(context).pop();
            onDelete();
          }, child: Text('Excluir', style: TextStyle(color: Colors.red)))
        ],
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}