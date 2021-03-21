import 'package:flutter/material.dart';
import 'package:xlo_mobx/screens/home/components/bar_button.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BarButton(
          onTap: () {},
          label: 'Categorias',
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey[400])
            )
          ),
        ),
        BarButton(
          onTap: () {},
          label: 'Filtros',
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey[400]),
              left: BorderSide(color: Colors.grey[400])
            )
          ),
        ),
      ],
    );
  }
}