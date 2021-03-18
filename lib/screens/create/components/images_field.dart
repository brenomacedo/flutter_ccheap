import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/create/components/image_dialog.dart';
import 'package:xlo_mobx/screens/create/components/image_source_dialog.dart';
import 'package:xlo_mobx/stores/create_store.dart';

class ImagesField extends StatelessWidget {

  final CreateStore createStore;

  ImagesField(this.createStore);

  @override
  Widget build(BuildContext context) {

    void onImageSelected(File image) {
      createStore.images.add(image);
      Navigator.of(context).pop();
    }

    return Container(
      color: Colors.grey[200],
      height: 120,
      child: Observer(
        builder: (_) {
          return ListView.builder(
            itemBuilder: (_, index) {
              if(index == createStore.images.length) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
                  child: GestureDetector(
                    onTap: () {
                      if(Platform.isAndroid) {
                        showModalBottomSheet(context: context, builder: (_) => ImageSourceDialog(onImageSelected));
                      } else {
                        showCupertinoModalPopup(context: context, builder: (_) => ImageSourceDialog(onImageSelected));
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
              }
              
              return Padding(
                padding: EdgeInsets.fromLTRB(8, 16, index == 4 ? 8 : 0, 16),
                child: GestureDetector(
                  onTap: () {
                    showDialog(context: context, builder: (_) {
                      return ImageDialog(
                        image: createStore.images[index],
                        onDelete: () {
                          createStore.images.removeAt(index);
                        }
                      );
                    });
                  },
                  child: CircleAvatar(
                    radius: 44,
                    backgroundImage: FileImage(createStore.images[index])
                  ),
                )
              );
            },
            itemCount: createStore.images.length < 5
              ? createStore.images.length + 1 : 5,
            scrollDirection: Axis.horizontal,
          );
        },
      )
    );
  }
}