import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/repositories/ad_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';
part 'my_ads_store.g.dart';

class MyAdsStore = _MyAdsStore with _$MyAdsStore;

abstract class _MyAdsStore with Store {

  _MyAdsStore() {
    _getMyAds();
  }

  @observable
  List<Ad> allAds = [];

  @computed
  List<Ad> get activeAds => allAds.where((ad) => ad.status == AdStatus.ACTIVE).toList();
  List<Ad> get pendingAds => allAds.where((ad) => ad.status == AdStatus.PENDING).toList();
  List<Ad> get soldAds => allAds.where((ad) => ad.status == AdStatus.SOLD).toList();

  @action
  Future<void> _getMyAds() async {
    final user = GetIt.I<UserManagerStore>().user;
    AdRepository().getMyAds(user);

    loading = true;
    print('setei true');
    try {
      allAds = await AdRepository().getMyAds(user);
      loading = false;
      print('setei false');
    } catch(e) {

    }
  }

  @observable
  bool loading = false;

  void refresh() => _getMyAds();

  @action
  Future<void> soldAd(Ad ad) async {
    loading = true;
    await AdRepository().sold(ad);
    refresh();
  }

  @action
  Future<void> deleteAd(Ad ad) async {
    loading = true;
    await AdRepository().delete(ad);
    refresh();
  }

}