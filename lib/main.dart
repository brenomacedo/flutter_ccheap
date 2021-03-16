import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/config/config.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Parse().initialize(
    appId,
    serverUrl,
    clientKey: clientKey,
    autoSendSessionId: true,
    debug: true
  );

  runApp(MyApp());

  final category = ParseObject('Categories')
    ..set('Title', 'Camisetas')..set('Position', 2);

  final response = await category.save();
  print(response.success);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(),
      title: 'XLO',
      debugShowCheckedModeBanner: false
    );
  }
}