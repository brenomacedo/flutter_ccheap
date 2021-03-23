import 'package:flutter/material.dart';
import 'package:xlo_mobx/models/ad.dart';

class LocationPanel extends StatelessWidget {

  LocationPanel(this.ad);

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 18, bottom: 18),
          child: Text('Localização', style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600
          )),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text('CEP'),
                  SizedBox(
                    height: 12,
                  ),
                  Text('Município'),
                  SizedBox(
                    height: 12,
                  ),
                  Text('Bairro')
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(ad.address.cep),
                    SizedBox(
                      height: 12,
                    ),
                    Text(ad.address.city.name),
                    SizedBox(
                      height: 12,
                    ),
                    Text(ad.address.disctrict)
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}