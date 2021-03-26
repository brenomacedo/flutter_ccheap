import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/components/empty_card.dart';
import 'package:xlo_mobx/screens/favorites/components/favorite_tile.dart';
import 'package:xlo_mobx/stores/favorite_store.dart';

class FavoritesScreen extends StatelessWidget {

  FavoritesScreen({ this.hideDrawer });

  final bool hideDrawer;
  final favoriteStore = GetIt.I<FavoriteStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
        centerTitle: true,
      ),
      drawer: hideDrawer ? null : CustomDrawer(),
      body: Observer(builder: (_) {
        if(favoriteStore.favoriteList.isEmpty)
          return EmptyCard('Nenhum anúncio favoritado!');
        
        return ListView.builder(
          padding: EdgeInsets.all(2),
          itemCount: favoriteStore.favoriteList.length,
          itemBuilder: (_, index) {
            return FavoriteTile(favoriteStore.favoriteList[index]);
          },
        );
      }),
    );
  }
}