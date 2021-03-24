import 'package:flutter/material.dart';

class EmptyCard extends StatelessWidget {

  EmptyCard(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 4,
            child: Icon(Icons.border_clear, size: 200, color: Colors.purple),
          ),
          Divider(color: Colors.black),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Hmmm', style: TextStyle(
                    color: Colors.orange,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  )),
                  Text(text, style: TextStyle(
                    fontSize: 16
                  ), textAlign: TextAlign.center)
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}