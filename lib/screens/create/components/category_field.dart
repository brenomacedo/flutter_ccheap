import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/screens/category/category_screen.dart';
import 'package:xlo_mobx/stores/create_store.dart';

class CategoryField extends StatelessWidget {

  final CreateStore createStore;

  CategoryField(this.createStore);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Column(
        children: [
          ListTile(
            title: createStore.category == null
              ? Text('Categoria *', style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w800))
              : Text('Categoria *', style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w700)),
            trailing: Icon(Icons.keyboard_arrow_down),
            onTap: () async {
              final Category category = await showDialog(context: context, builder: (_) => CategoryScreen(
                showAll: false,
                selected: createStore.category,
              ));

              if(category != null) {
                createStore.setCategory(category);
              }
            },
            subtitle: createStore.category == null ? null : Text(createStore.category.description, style: TextStyle(
              color: Colors.black, fontSize: 17
            )),
          ),
          createStore.categoryError != null ? Container(
            child: Text(createStore.categoryError, style: TextStyle(
              color: Colors.red, fontSize: 12,
            )),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.red))
            ),
            padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
          ) : Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[500]))
            ),
          )
        ],
      );
    });
  }
}