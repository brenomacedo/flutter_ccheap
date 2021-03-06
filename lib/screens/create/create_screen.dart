import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/components/error_box/error_box.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/screens/create/components/category_field.dart';
import 'package:xlo_mobx/screens/create/components/cep_field.dart';
import 'package:xlo_mobx/screens/create/components/hide_phone_field.dart';
import 'package:xlo_mobx/screens/create/components/images_field.dart';
import 'package:xlo_mobx/screens/my_ads/my_ads_screen.dart';
import 'package:xlo_mobx/stores/create_store.dart';
import 'package:xlo_mobx/stores/page_store.dart';

class CreateScreen extends StatefulWidget {

  CreateScreen({this.ad});

  final Ad ad;

  @override
  _CreateScreenState createState() => _CreateScreenState(ad);
}

class _CreateScreenState extends State<CreateScreen> {

  _CreateScreenState(Ad ad)
    : createStore = CreateStore(ad ?? Ad()),
    editing = ad != null;

  bool editing;

  @override
  void initState() {
    super.initState();

    when((_) => createStore.savedAd, () {
      if(editing)
        Navigator.of(context).pop(true);
      else {
        GetIt.I<PageStore>().setPage(0);
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => MyAdsScreen(initialPage: 1))
        );
      }
        
    });
  }

  final labelStyle = TextStyle(
    fontWeight: FontWeight.w800,
    color: Colors.grey,
    fontSize: 18
  );

  final contentPadding = EdgeInsets.fromLTRB(16, 10, 12, 10);

  final CreateStore createStore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editing ? 'Editar anúncio' : 'Criar anúncio'),
        centerTitle: true,
      ),
      drawer: editing ? null : CustomDrawer(),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))
            ),
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Observer(builder: (_) {
              if(createStore.loading)
                return Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('Salvando anúncio', style: TextStyle(
                        fontSize: 18, color: Colors.purple
                      )),
                      SizedBox(height: 16),
                      CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.purple))
                    ],
                  ),
                );
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ImagesField(createStore),
                  Observer(builder: (_) {
                    return TextFormField(
                      initialValue: createStore.title,
                      onChanged: createStore.setTitle,
                      decoration: InputDecoration(
                        labelText: 'Título*',
                        labelStyle: labelStyle,
                        contentPadding: contentPadding,
                        errorText: createStore.titleError
                      ),
                    );
                  }),
                  Observer(builder: (_) {
                    return TextFormField(
                      onChanged: createStore.setDescription,
                      initialValue: createStore.description,
                      decoration: InputDecoration(
                        labelText: 'Descrição*',
                        labelStyle: labelStyle,
                        contentPadding: contentPadding,
                        errorText: createStore.descriptionError
                      ),
                      maxLines: null,
                    );
                  }),
                  CategoryField(createStore),
                  CepField(createStore),
                  Observer(builder: (_) {
                    return TextFormField(
                      onChanged: createStore.setPrice,
                      initialValue: createStore.priceText,
                      decoration: InputDecoration(
                        labelText: 'Preço*',
                        labelStyle: labelStyle,
                        contentPadding: contentPadding,
                        prefixText: 'R\$',
                        errorText: createStore.priceError
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        RealInputFormatter(centavos: true)
                      ],
                    );
                  }),
                  HidePhoneField(createStore),
                  Observer(builder: (_) {
                    return ErrorBox(message: createStore.error);
                  }),
                  SizedBox(
                    height: 50,
                    child: Observer(builder: (_) {
                      return GestureDetector(
                        child: ElevatedButton(onPressed: createStore.sendPressed,
                          child: Text('Enviar', style: TextStyle(color: Colors.white, fontSize: 18)),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith((states) {
                              if(states.contains(MaterialState.disabled))
                                return Colors.orange.withAlpha(120);
                              return Colors.orange;
                            }),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap
                        )),
                        onTap: createStore.invalidSendPressed,
                      );
                    },)
                  )
                ],
              );
            })
          ),
        ),
      )
    );
  }
}