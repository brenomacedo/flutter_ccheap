import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/screens/create/components/category_field.dart';
import 'package:xlo_mobx/screens/create/components/images_field.dart';
import 'package:xlo_mobx/stores/create_store.dart';

class CreateScreen extends StatelessWidget {

  final labelStyle = TextStyle(
    fontWeight: FontWeight.w800,
    color: Colors.grey,
    fontSize: 18
  );

  final contentPadding = EdgeInsets.fromLTRB(16, 10, 12, 10);

  final createStore = CreateStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar anúncio'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))
        ),
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImagesField(createStore),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Título*',
                labelStyle: labelStyle,
                contentPadding: contentPadding
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Descrição*',
                labelStyle: labelStyle,
                contentPadding: contentPadding
              ),
              maxLines: null,
            ),
            CategoryField(createStore),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Preço*',
                labelStyle: labelStyle,
                contentPadding: contentPadding,
                prefixText: 'R\$'
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                RealInputFormatter(centavos: true)
              ],
            )
          ],
        ),
      ),
    );
  }
}