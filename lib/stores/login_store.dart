import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {

  @observable
  String email;

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && email.isEmailValid();
  String get emailError {
    if(email == null || emailValid) return null;
    return 'E-mail inválido';
  }


  @observable
  String pass1;

  @action
  void setPass1(String value) => pass1 = value;

  @computed
  bool get pass1Valid => pass1 != null && pass1.length >= 4;
  String get pass1Error {
    if(pass1 == null || pass1Valid) return null;
    return 'Senha inválida!';
  }

  @computed
  bool get isFormValid => emailValid && pass1Valid;

  @computed
  Function get loginPressed => isFormValid ? _login : null;

  @observable
  bool loading = false;

  @action
  Future<void> _login() async {
    loading = true;
    error = null;

    try {
      final user = await UserRepository().loginWithEmail(email, pass1);
      GetIt.I<UserManagerStore>().setUser(user);
      
    } catch(e) {
      error = e;
    }

    loading = false;
  }

  @observable
  String error;
}