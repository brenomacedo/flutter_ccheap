import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/parse_errors.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

class FavoriteRepository {
  
  Future<void> save({Ad ad, User user}) async {

    final favoriteObject = ParseObject(keyFavoritesTable);
    favoriteObject
      ..set(keyFavoritesOwner, user.id)
      ..set(keyFavoritesAd, ParseObject(keyAdTable)..set(keyAdId, ad.id));

    final response = await favoriteObject.save();

    if(!response.success)
      return Future.error(ParseErrors.getDescription(response.error.code));

  } 

}