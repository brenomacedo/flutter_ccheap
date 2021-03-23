import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/parse_errors.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class AdRepository {

  Future<List<Ad>> getHomeAdList({ FilterStore filter, String search, Category category, int page }) async {
    final queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyAdTable));

    queryBuilder
      ..setLimit(20)
      ..whereEqualTo(keyAdStatus, AdStatus.ACTIVE.index)
      ..setAmountToSkip(page * 20)
      ..includeObject([keyAdOwner, keyAdCategory]);

    if(search != null && search.trim().isNotEmpty) {
      queryBuilder.whereContains(keyAdTitle, search, caseSensitive: false);
    }

    if(category != null && category.id != '*') {
      queryBuilder.whereEqualTo(keyAdCategory,
        (ParseObject(keyCategoryTable)..set(keyCategoryId, category.id)).toPointer());
    }

    switch(filter.orderBy) {
      case OrderBy.PRICE:
        queryBuilder.orderByAscending(keyAdPrice);
        break;
      case OrderBy.DATE:
      default:
        queryBuilder.orderByDescending(keyAdCreatedAt);
        break;
    }

    if(filter.minPrice != null && filter.minPrice > 0) {
      queryBuilder.whereGreaterThanOrEqualsTo(keyAdPrice, filter.minPrice);
    }

    if(filter.maxPrice != null && filter.maxPrice > 0) {
      queryBuilder.whereLessThanOrEqualTo(keyAdPrice, filter.maxPrice);
    }

    if(filter.vendorType != null
      && filter.vendorType > 0
      && filter.vendorType < (VENDOR_TYPE_PROFESSIONAL | VENDOR_TYPE_PARTICULAR)) {
      
      final userQuery = QueryBuilder<ParseUser>(ParseUser.forQuery());

      if(filter.vendorType == VENDOR_TYPE_PARTICULAR) {
        userQuery.whereEqualTo(keyUserType, Type.PARTICULAR.index);
      }

      if(filter.vendorType == VENDOR_TYPE_PROFESSIONAL) {
        userQuery.whereEqualTo(keyUserType, Type.PARTICULAR.index);
      }

      queryBuilder.whereMatchesQuery(keyAdOwner, userQuery);
    }

    final response = await queryBuilder.query();

    if(response.success && response.results != null)
      return response.results.map((po) => Ad.fromParse(po)).toList();

    if(response.success && response.results == null)
      return [];

    return Future.error(ParseErrors.getDescription(response.error.code));
  }

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

      if(!response.success)
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

  Future<List<Ad>> getMyAds(User user) async {
    final currentUser = ParseUser('', '', '')
      ..set(keyUserId, user.id);

    final queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyAdTable));

    queryBuilder..setLimit(100)
      ..orderByDescending(keyAdCreatedAt)
      ..whereEqualTo(keyAdOwner, currentUser.toPointer())
      ..includeObject([keyAdCategory, keyAdOwner]);

    final response = await queryBuilder.query();

    if(response.success && response.results != null)
      return response.results.map((po) => Ad.fromParse(po)).toList();

    if(response.success && response.results == null)
      return [];

    return Future.error(ParseErrors.getDescription(response.error.code));
  }

}