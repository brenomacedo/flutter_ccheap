import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/helpers/extensions.dart';

class AdTile extends StatelessWidget {

  AdTile(this.ad);

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        ),
        elevation: 8,
        child: Row(
          children: [
            SizedBox(
              height: 135,
              width: 127,
              child: CachedNetworkImage(imageUrl: ad.images.isEmpty
                ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/1200px-Unknown_person.jpg'
                : ad.images.first, fit: BoxFit.cover),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(ad.title, style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                    )),
                    Text('${ad.price.formattedMoney()}', style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700
                    )),
                    Text('${ad.created.formattedDate()} - '
                    '${ad.address.city.name} - '
                    '${ad.address.uf.initials}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300
                    )),
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}