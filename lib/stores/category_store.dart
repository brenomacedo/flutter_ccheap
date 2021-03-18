import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/repositories/categorie_repository.dart';
part 'category_store.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  
  _CategoryStore() {
    loadAllCategories();
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