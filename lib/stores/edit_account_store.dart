import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';
part 'edit_account_store.g.dart';

class EditAccountStore = _EditAccountStore with _$EditAccountStore;

abstract class _EditAccountStore with Store {

  _EditAccountStore() {

    user = userManagerStore.user;

    userType = user.type;
    name = user.name;
    phone = user.phone;
  }

  final userManagerStore = GetIt.I<UserManagerStore>();

  User user;

  @observable
  Type userType;

  @action
  void setUserType(int value) => userType = Type.values[value];

  @observable
  String name;

  @action
  void setName(String value) => name = value;

  @observable
  String phone;

  @action
  void setPhone(String value) => phone = value;

  @observable
  String pass1 = '';

  @action
  void setPass1(String value) => pass1 = value;

  @observable
  String pass2 = '';

  @action
  void setPass2(String value) => pass2 = value;


  @computed
  bool get isNameValid => name != null && name.length >= 6;
  bool get isPhoneValid => phone != null && phone.length >= 14;
  bool get isPassValid => pass1 == pass2 && (pass1.length >= 6 || pass1.isEmpty);
  bool get isFormValid => isNameValid && isPhoneValid && isPassValid;
  String get nameError => isNameValid || name == null ? null : 'Campo obrigatório!';
  String get phoneError => isPhoneValid || phone == null ? null : 'Campo obrigatório!';
  String get passError {
    if(pass1 != null && pass1.isNotEmpty && pass1.length < 6)
      return 'Senha muito curta!';
    if(pass1 != pass2)
      return 'Senhas não coincidem!';
    return null;
  }

  @observable
  bool loading = false;

  @action
  Future<void> _save() async {
    loading = true;

    user.name = name;
    user.phone = phone;
    user.type = userType;

    if(pass1.isNotEmpty)
      user.password = pass1;
    else
      user.password = null;

    try {
      await UserRepository().save(user);
      userManagerStore.setUser(user);
    } catch(e) {

    }

    loading = false;
  }

  @computed
  VoidCallback get savePressed => (isFormValid && !loading) ? _save : null;

  void logout() {
    userManagerStore.logout();
  }

}