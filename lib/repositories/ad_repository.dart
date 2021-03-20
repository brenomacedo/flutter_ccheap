import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/repositories/parse_errors.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

class AdRepository {

  Future<void> save(Ad ad) async {
    try {
      final parseImages = await saveImages(ad.images);

      final parseUser = ParseUser('', '', '')..set(keyUserId, ad.user.id);

      final adObject = ParseObject(keyAdTable);

      final parseAcl = ParseACL(owner: parseUser);
      parseAcl.setPublicReadAccess(allowed: true);
      parseAcl.setPublicWriteAccess(allowed: false);
      adObject.setACL(parseAcl);

      adObject
      ..set<String>(keyAdTitle, ad.title)
      ..set<String>(keyAdDescription, ad.description)
      ..set<bool>(keyAdHidePhone, ad.hidePhone)
      ..set<num>(keyAdPrice, ad.price)
      ..set<int>(keyAdStatus, ad.status.index)
      ..set<String>(keyAdDistrict, ad.address.disctrict)
      ..set<String>(keyAdCity, ad.address.city.name)
      ..set<String>(keyAdFederativeUnit, ad.address.uf.initials)
      ..set<String>(keyAdPostalCode, ad.address.cep)
      ..set<List<ParseFile>>(keyAdImages, parseImages)
      ..set<ParseUser>(keyAdOwner, parseUser)
      ..set<ParseObject>(keyAdCategory, ParseObject(keyCategoryTable)..set(keyCategoryId, ad.category.id));

      final response = await adObject.save();

      if(response.success)
        return response.results.first;
      return Future.error(ParseErrors.getDescription(response.error.code));
    } catch(e) {
      return Future.error('Falha ao salvar anuncio');
    }
  }

  Future<List<ParseFile>> saveImages(List images) async {
    final parseImages = <ParseFile>[];

    try {

      for(final image in images) {
        if(image is File) {
          final parseFile = ParseFile(image, name: path.basename(image.path));
          final response = await parseFile.save();

          if(!response.success) return Future.error(ParseErrors.getDescription(response.error.code));

          parseImages.add(parseFile);
        } else {
          final parseFile = ParseFile(null);
          parseFile.name = path.basename(image);
          parseFile.url = image;
          parseImages.add(parseFile);
        }
      }

      return parseImages;

    } catch(e) {
      return Future.error('Falha ao salvar imagens');
    }
  }

}