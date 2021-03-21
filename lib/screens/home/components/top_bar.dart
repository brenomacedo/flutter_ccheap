import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/screens/category/category_screen.dart';
import 'package:xlo_mobx/screens/filter/filter_screen.dart';
import 'package:xlo_mobx/screens/home/components/bar_button.dart';
import 'package:xlo_mobx/stores/home_store.dart';

class TopBar extends StatelessWidget {

  final HomeStore homeStore = GetIt.I<HomeStore>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Observer(builder: (_) {
          return BarButton(
            onTap: () async {
              final Category category = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => CategoryScreen(
                showAll: true,
                selected: homeStore.category,
              )));
              if(category != null) homeStore.setCategory(category);
            },
            label: homeStore.category?.description ?? 'Categorias',
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[400])
              )
            ),
          );
        }),
        BarButton(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => FilterScreen()));
          },
          label: 'Filtros',
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey[400]),
              left: BorderSide(color: Colors.grey[400])
            )
          ),
        ),
      ],
    );
  }
}