import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

class Category {
  String id;
  String description;

  Category({ this.id, this.description });

  Category.fromParse(ParseObject object) :
    id = object.objectId,
    description = object.get(keyCategoryDescription);

  @override
  String toString() {
    return 'Category: { id: $id, description: $description }';
  }
}