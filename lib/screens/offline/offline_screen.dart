import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/stores/connectivity_store.dart';

class OfflineScreen extends StatefulWidget {
  @override
  _OfflineScreenState createState() => _OfflineScreenState();
}

class _OfflineScreenState extends State<OfflineScreen> {

  final connectStore = GetIt.I<ConnectivityStore>();

  @override
  void initState() {
    super.initState();
    when((_) => connectStore.connected, () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          title: Text('XLO'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Text('Sem conexão com a internet!', style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18
              )),
            ),
            Icon(Icons.cloud_off, color: Colors.white, size: 150),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Por favor, verifique sua conexão com a internet para continuar usando o app',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      )
    );
  }
}