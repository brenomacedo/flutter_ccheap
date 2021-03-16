import 'package:flutter/material.dart';
import 'package:xlo_mobx/components/custom_drawer/page_tile.dart';

class PageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageTile(label: 'Anúncios', icon: Icons.list, onTap: () {}, highlighted: true),
        PageTile(label: 'Inserir Anúncio', icon: Icons.edit, onTap: () {}, highlighted: false),
        PageTile(label: 'Chat', icon: Icons.chat, onTap: () {}, highlighted: false),
        PageTile(label: 'Favoritos', icon: Icons.favorite, onTap: () {}, highlighted: false),
        PageTile(label: 'Minha conta', icon: Icons.person, onTap: () {}, highlighted: false)
      ],
    );
  }
}