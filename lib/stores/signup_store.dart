import 'package:mobx/mobx.dart';
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

}