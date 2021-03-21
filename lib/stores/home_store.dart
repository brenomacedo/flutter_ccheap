import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/repositories/ad_repository.dart';
import 'package:xlo_mobx/stores/filter_store.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {

  _HomeStore() {
    autorun((_) async {
      setLoading(true);
      try {
        final newAds = await AdRepository().getHomeAdList(
          filter: filter,
          search: search,
          category: category
        );

        adList.clear();
        adList.addAll(newAds);
        setError(null);
      } catch(e) {
        setError(e);
      }

      setLoading(false);
    });
  }

  @observable
  String search = '';

  @action
  void setSearch(String value) => search = value;

  @observable
  Category category;

  @action
  void setCategory(Category value) => category = value;

  @observable
  FilterStore filter = FilterStore();

  FilterStore get clonedFilter => filter.clone();

  @action
  void setFilter(FilterStore value) => filter = value;

  ObservableList<Ad> adList = ObservableList<Ad>();

  @observable
  String error;

  @action
  void setError(String value) => error = value;

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

}