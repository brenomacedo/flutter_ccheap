import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/screens/account/account_screen.dart';
import 'package:xlo_mobx/screens/create/create_screen.dart';
import 'package:xlo_mobx/screens/favorites/favorites_screen.dart';
import 'package:xlo_mobx/screens/home/home_screen.dart';
import 'package:xlo_mobx/screens/offline/offline_screen.dart';
import 'package:xlo_mobx/stores/connectivity_store.dart';
import 'package:xlo_mobx/stores/page_store.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {

  @override
  void initState() {
    super.initState();

    autorun((_) {
      if(!connectStore.connected) {
        Future.delayed(Duration(milliseconds: 50)).then((_) {
          showDialog(context: context, builder: (_) => OfflineScreen());
        });
      }
    });

    reaction((_) => pageStore.page, (page) {
      _page.jumpToPage(page);
    });
  }

  final _page = PageController();

  final PageStore pageStore = GetIt.I<PageStore>();
  final ConnectivityStore connectStore = GetIt.I<ConnectivityStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _page,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          CreateScreen(),
          Container(color: Colors.purple),
          FavoritesScreen(hideDrawer: false),
          AccountScreen(),
        ],
      )
    );
  }
}