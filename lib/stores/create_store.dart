import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/repositories/ad_repository.dart';
import 'package:xlo_mobx/stores/cep_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store {

  final Ad ad;

  _CreateStore(this.ad) {
    title = ad.title;
    description = ad.description;
    images = ad.images.asObservable();
    category = ad.category;
    priceText = ad.price.toStringAsFixed(2);
    hidePhone = ad.hidePhone;

    if(ad.address != null)
      cepStore = CepStore(ad.address.cep);
    else
      cepStore = CepStore(null);
    
  }

  ObservableList images = ObservableList();

  @computed
  bool get imagesValid => images.isNotEmpty;
  String get imagesError => (!showErrors || imagesValid) ? null : 'Selecione ao menos uma imagem';

  @observable
  String title = '';

  @action
  void setTitle(String value) => title = value;

  @computed
  bool get titleValid => title.length > 6;

  String get titleError {
    if(!showErrors || titleValid) return null;
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
    if(!showErrors || descriptionValid) return null;
    if(description.isEmpty) return 'Campo obrigat´orio!';
    return 'Descrição muito curta!';
  }

  @observable
  Category category;

  @action
  void setCategory(Category value) => category = value;

  @computed
  bool get categoryValid => category != null;
  String get categoryError => (!showErrors || categoryValid) ? null : 'Campo obrigatório!';

  @observable
  bool hidePhone = false;

  @action
  void setHidePhone(bool value) => hidePhone = value;

  CepStore cepStore;

  @computed
  Address get address => cepStore.address;
  bool get addressValid => address != null;
  String get addressError => (!showErrors || addressValid) ? null : 'Campo obrigatório';

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
    if(!showErrors || priceValid) return null;
    if(priceText.isEmpty) return 'Campo obrigatório!';
    return 'Preço inválido';
  }

  @computed
  get formValid => imagesValid && titleValid && descriptionValid
    && categoryValid && addressValid && priceValid;

  @computed
  Function get sendPressed => formValid ? _send : null;

  @observable
  bool showErrors = false;

  @action
  void invalidSendPressed() => showErrors = true;

  @observable
  bool loading = false;

  @observable
  String error;

  @observable
  bool savedAd = false;

  @action
  Future<void> _send() async {
    
    ad.title = title;
    ad.description = description;
    ad.category = category;
    ad.price = price;
    ad.hidePhone = hidePhone;
    ad.images = images;
    ad.address = address;
    ad.user = GetIt.I<UserManagerStore>().user;
    
    loading = true;
    try {
      await AdRepository().save(ad);

      savedAd = true;
    } catch(e) {
      error = e;
    }
    loading = false;
  }


}