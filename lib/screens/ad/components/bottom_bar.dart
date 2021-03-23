import 'package:flutter/material.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomBar extends StatelessWidget {

  BottomBar(this.ad);

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 26),
            height: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19),
              color: Colors.orange
            ),
            child: Row(
              children: [
                if(!ad.hidePhone)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        final phone = ad.user.phone.replaceAll(RegExp('[^0-9]'), '');
                        launch('tel:$phone');
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 25,
                        child: Text('Ligar', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 15
                        )),
                        decoration: BoxDecoration(
                          border: Border(right: BorderSide(color: Colors.black45, width: 1))
                        ),
                      ),
                    )
                  ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      height: 25,
                      child: Text('Chat', style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 15
                      )),
                    ),
                  )
                )
              ],
            ),
          ),
          SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(249, 249, 249, 1),
              border: Border(top: BorderSide(color: Colors.grey[400]))
            ),
            height: 38,
            alignment: Alignment.center,
            child: Text(
              '${ad.user.name} (anunciante)',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    );
  }
}