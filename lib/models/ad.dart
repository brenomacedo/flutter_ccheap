import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/models/city.dart';
import 'package:xlo_mobx/models/uf.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';

enum AdStatus {
  PENDING, ACTIVE, SOLD, DELETED
}

class Ad {

  Ad();

  Ad.fromParse(ParseObject object) {
    id = object.objectId;
    title = object.get<String>(keyAdTitle);
    description = object.get<String>(keyAdDescription);
    images = object.get<List>(keyAdImages).map((e) => e.url).toList();
    hidePhone = object.get<bool>(keyAdHidePhone);
    price = object.get<num>(keyAdPrice);
    created = object.createdAt;
    address = Address(
      disctrict: object.get<String>(keyAdDistrict),
      city: City(name: object.get<String>(keyAdCity)),
      cep: object.get<String>(keyAdPostalCode),
      uf: UF(initials: object.get<String>(keyAdFederativeUnit))
    );
    views = object.get<int>(keyAdViews, defaultValue: 0);
    user = UserRepository().mapParseToUser(object.get<ParseUser>(keyAdOwner));
    category = Category.fromParse(object.get<ParseObject>(keyAdCategory));
    status = AdStatus.values[object.get<int>(keyAdStatus)];
  }

  String id;

  List images;

  String title;
  String description;
  
  Category category;
  Address address;

  num price;
  bool hidePhone;

  AdStatus status = AdStatus.PENDING;
  DateTime created;

  User user;

  int views;

}