import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/repositories/ad_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';
part 'my_ads_store.g.dart';

class MyAdsStore = _MyAdsStore with _$MyAdsStore;

abstract class _MyAdsStore with Store {

  _MyAdsStore() {
    _getMyAds();
  }

  Future<void> _getMyAds() async {
    final user = GetIt.I<UserManagerStore>();
    AdRepository().getMyAds(user.user);
  }

}