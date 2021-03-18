import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/error_box/error_box.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/stores/category_store.dart';

class CategoryScreen extends StatelessWidget {

  final Category selected;
  final bool showAll;

  CategoryScreen({ this.selected, this.showAll = true });

  final categoryStore = GetIt.I<CategoryStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorias')
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.fromLTRB(32, 12, 32, 32),
          child: Observer(
            builder: (_) {
              if(categoryStore.error != null) return ErrorBox(message: categoryStore.error);
              if(categoryStore.categoryList.isEmpty)
                return Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.purple)
                ));
              return Container();              
            },
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 8,
        ),
      ),
    );
  }
}