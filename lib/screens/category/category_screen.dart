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
              final categories = showAll ? categoryStore.allCategoryList : categoryStore.categoryList;

              return ListView.separated(
                itemCount: categories.length,
                separatorBuilder: (_, __) {
                  return Divider(
                    height: 0.1,
                    color: Colors.grey
                  );
                },
                itemBuilder: (_, index) {
                  final category = categories[index];

                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 50,
                      color: category.id == selected?.id ? Colors.purple.withAlpha(50) : null,
                      child: Text(category.description, style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: category.id == selected?.id ? FontWeight.bold : null
                      )),
                      alignment: Alignment.center,
                    ),
                  );
                },
              );
            },
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 8,
        ),
      ),
    );
  }
}