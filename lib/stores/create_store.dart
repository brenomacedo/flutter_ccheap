import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/stores/cep_store.dart';
part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store {

  ObservableList images = ObservableList();

  @computed
  bool get imagesValid => images.isNotEmpty;
  String get imagesError => imagesValid ? null : 'Selecione ao menos uma imagem';

  @observable
  String title = '';

  @action
  void setTitle(String value) => title = value;

  @computed
  bool get titleValid => title.length > 6;

  String get titleError {
    if(titleValid) return null;
    if(title.isEmpty) return 'Campo obrigat´orio';
    return 'Campo muito curto!';
  }

  @observable
  String description = '';

  @action
  void setDescription(String value) => description = value;

  @computed
  bool get descriptionValid => description.length >= 10;
  String get descriptionError {
    if(descriptionValid) return null;
    if(description.isEmpty) return 'Campo obrigat´orio!';
    return 'Descrição muito curta!';
  }

  @observable
  Category category;

  @action
  void setCategory(Category value) => category = value;

  @computed
  bool get categoryValid => category != null;
  String get categoryError => categoryValid ? null : 'Campo obrigatório!';

  @observable
  bool hidePhone = false;

  @action
  void setHidePhone(bool value) => hidePhone = value;

  CepStore cepStore = CepStore();

  @computed
  Address get address => cepStore.address;
  bool get addressValid => address != null;
  String get addressError => addressValid ? null : 'Campo obrigatório';

  @observable
  String priceText = '';

  @action
  void setPrice(String value) => priceText = value;

  @computed
  num get price {
    if(priceText.contains(','))
      return num.tryParse(priceText.replaceAll(RegExp('[^0-9]'), '')) / 100;
    return num.tryParse(priceText);
  }
  bool get priceValid => price != null && price <= 9999999;
  String get priceError {
    if(priceValid) return null;
    if(priceText.isEmpty) return 'Campo obrigatório!';
    return 'Preço inválido';
  }

}