import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/user.dart';
part 'edit_account_store.g.dart';

class EditAccountStore = _EditAccountStore with _$EditAccountStore;

abstract class _EditAccountStore with Store {

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
  bool get isPassValid => pass1 != pass2 && (pass1.length >= 6 || pass1.isEmpty);
  bool get isFormValid => isNameValid && isPhoneValid && isPassValid;
  String get nameError => isNameValid || name == null ? null : 'Campo obrigatório!';
  String get phoneError => isPhoneValid || phone == null ? null : 'Campo obrigatório!';
  String get passError {
    if(pass1.isNotEmpty && pass1.length < 6)
      return 'Senha muito curta!';
    if(pass1 != pass2)
      return 'Senhas não coincidem!';
    return null;
  }

}