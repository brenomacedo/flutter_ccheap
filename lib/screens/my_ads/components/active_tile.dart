import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/helpers/extensions.dart';

class ActiveTile extends StatelessWidget {

  ActiveTile(this.ad);

  final Ad ad;

  final List<MenuChoice> choices = [
    MenuChoice(index: 0, title: 'Editar', iconData: Icons.edit),
    MenuChoice(index: 1, title: 'Já vendi', iconData: Icons.thumb_up),
    MenuChoice(index: 2, title: 'Excluir', iconData: Icons.delete),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 80,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: CachedNetworkImage(imageUrl: ad.images.isEmpty
                ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/1200px-Unknown_person.jpg'
                : ad.images.first, fit: BoxFit.cover),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(ad.title, overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(ad.price.formattedMoney(),
                      style: TextStyle(fontWeight: FontWeight.w300)),
                    Text('${ad.views} visitas',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[800]
                      ))
                  ],
                ),
              )
            ),
            PopupMenuButton<MenuChoice>(itemBuilder: (_) {
              return choices.map((i) => PopupMenuItem<MenuChoice>(
                value: i,
                child: Row(
                  children: [
                    Icon(i.iconData, color: Colors.purple, size: 20),
                    SizedBox(width: 8),
                    Text(i.title, style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.purple
                    ))
                  ],
                ),
              )).toList();
            },
            icon: Icon(Icons.more_vert, size: 20),
            onSelected: (choice) {
              switch(choice.index) {
                case 0:
                  break;
                case 1:
                  break;
                case 2:
                  break;
              }
            })
          ],
        ),
      ),
    );
  }
}

class MenuChoice {
  MenuChoice({ this.index, this.title, this.iconData });

  final int index;
  final String title;
  final IconData iconData;
}