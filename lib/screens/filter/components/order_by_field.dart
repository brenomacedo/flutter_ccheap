import 'package:flutter/material.dart';
import 'package:xlo_mobx/screens/filter/components/section_title.dart';

class OrderByField extends StatelessWidget {

  Widget buildOption(String title) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.purple,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Text(title, style: TextStyle(color: Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle('Ordenar por'),
        Row(
          children: [
            buildOption('Data'),
            SizedBox(width: 12),
            buildOption('Preço')
          ],
        )
      ],
    );
  }
}