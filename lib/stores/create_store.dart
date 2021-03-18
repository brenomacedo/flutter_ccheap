import 'dart:io';

import 'package:mobx/mobx.dart';
part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store {

  ObservableList<File> images = ObservableList<File>();

}