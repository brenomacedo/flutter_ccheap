import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceDialog extends StatelessWidget {

  final Function(File) onImageSelected;

  ImageSourceDialog(this.onImageSelected);

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    if(Platform.isAndroid)
      return BottomSheet(onClosing: () {

      }, builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(onPressed: getFromCamera, child: Text('Camera')),
          TextButton(onPressed: getFromGallery, child: Text('Galeria'))
        ],
      ));
    else
      return CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(onPressed: getFromCamera, child: Text('Camera')),
          CupertinoActionSheetAction(onPressed: getFromGallery, child: Text('Galeria'))
        ],
        title: Text('Selecionar foto para o anúncio'),
        message: Text('Escolha a origem da foto'),
        cancelButton: CupertinoActionSheetAction(
          child: Text('Cancelar', style: TextStyle(color: Colors.red)),
          onPressed: Navigator.of(context).pop,
        ),
      );
  }

  Future<void> getFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if(pickedFile == null) return;
    final file = File(pickedFile.path);
    imageSelected(file);
  }

  Future<void> getFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if(pickedFile == null) return;
    final file = File(pickedFile.path);
    imageSelected(file);
  }

  Future<void> imageSelected(File image) async {
    final File croppedFile = await ImageCropper.cropImage(sourcePath: image.path, aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      androidUiSettings: AndroidUiSettings(toolbarTitle: 'Editar Imagem', toolbarColor: Colors.purple,
      toolbarWidgetColor: Colors.white), iosUiSettings: IOSUiSettings(title: 'Editar Imagem',
      cancelButtonTitle: 'Cancelar', doneButtonTitle: 'Concluir'));
    if(croppedFile == null) return;
    onImageSelected(croppedFile);
  }
}