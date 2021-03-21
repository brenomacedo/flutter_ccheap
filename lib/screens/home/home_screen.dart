import 'package:flutter/material.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/screens/home/components/search_dialog.dart';

class HomeScreen extends StatelessWidget {

  void openSearch(BuildContext context) async {
    final search = await showDialog(context: context, builder: (_) => SearchDialog(currentSearch: 'Breno'));
    print(search);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      drawer: CustomDrawer(

      ),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => openSearch(context),
          )
        ],
      ),
    ));
  }
}