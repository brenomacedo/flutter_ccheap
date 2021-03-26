import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/repositories/categorie_repository.dart';
import 'package:xlo_mobx/stores/connectivity_store.dart';
part 'category_store.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {

  final connectStore = GetIt.I<ConnectivityStore>();
  
  _CategoryStore() {
    autorun((_) {
      if(connectStore.connected && categoryList.isEmpty)
        loadAllCategories();
    });
  }

  final ObservableList<Category> categoryList = ObservableList<Category>();

  @computed
  List<Category> get allCategoryList =>
    List.from(categoryList)..insert(0, Category(id: '*', description: 'Todas'));

  @action
  setCategories(List<Category> categories) {
    categoryList.clear();
    categoryList.addAll(categories);
  }

  Future<void> loadAllCategories() async {

    try {
      final categories = await CategoryRepository().getList();
      setCategories(categories);
    } catch(e) {
      setError(e);
    }

  }

  @observable
  String error;

  @action
  void setError(String value) => error = value;

}