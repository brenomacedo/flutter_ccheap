import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';
part 'signup_store.g.dart';

class SignUpStore = _SignUpStore with _$SignUpStore;

abstract class _SignUpStore with Store {

  @observable
  String name;

  @action
  void setName(String value) => name = value;

  @computed
  bool get nameValid => name != null && name.length > 6;
  String get nameError {
    if(name == null || nameValid) return null;
    if(name.isEmpty) return 'Nome obrigat´orio!';
    return 'Nome muito curto!';
  }


  @observable
  String email;

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && email.isEmailValid();
  String get emailError {
    if(email == null || emailValid) return null;
    if(email.isEmpty) return 'Email obrigatório';
    return 'E-mail inválido';
  }


  @observable
  String phone;

  @action
  void setPhone(String value) => phone = value;

  @computed
  bool get phoneValid => phone != null && phone.length >= 14;
  String get phoneError {
    if(phone == null || phoneValid) return null;
    if(phone.isEmpty) return 'Campo obrigat´ório!';
    return 'Celular inválido!';
  }


  @observable
  String pass1;

  @action
  void setPass1(String value) => pass1 = value;

  @computed
  bool get pass1Valid => pass1 != null && pass1.length >= 6;
  String get pass1Error {
    if(pass1 == null || pass1Valid) return null;
    if(pass1.isEmpty) return 'Campo obrigatório!';
    return 'Senha muito curta!';
  }


  @observable
  String pass2;

  @action
  void setPass2(String value) => pass2 = value;

  @computed
  bool get pass2Valid => pass2 != null && pass2 == pass1;
  String get pass2Error {
    if(pass2 == null || pass2Valid) return null;
    return 'Senhas não coincidem';
  }

  @computed
  bool get isFormValid => nameValid && emailValid
    && phoneValid && pass1Valid && pass2Valid;

  @action
  Future<void> _signUp() async {
    loading = true;

    final user = User(
      name: name,
      email: email,
      phone: phone,
      password: pass1
    );

    try {
      final resultUser = await UserRepository().signUp(user);
      GetIt.I<UserManagerStore>().setUser(resultUser);
    } catch(e) {
      error = e;
    }

    loading = false;
  }

  @computed
  Function get signUpPressed => (isFormValid && !loading) ? _signUp : null;


  @observable
  bool loading = false;

  @observable
  String error;
}