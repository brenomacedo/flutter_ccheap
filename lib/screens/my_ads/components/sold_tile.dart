import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/helpers/extensions.dart';

class SoldTile extends StatelessWidget {

  SoldTile(this.ad);

  final Ad ad;

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
            SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(ad.title, overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(ad.price.formattedMoney(),
                      style: TextStyle(fontWeight: FontWeight.w300)),
                  ],
                ),
              )
            ),
            Column(
              children: [
                IconButton(icon: Icon(Icons.delete, color: Colors.purple, size: 20), onPressed: () {})
              ],
            )
          ],
        ),
      ),
    );
  }
}