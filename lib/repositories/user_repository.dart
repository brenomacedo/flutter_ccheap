import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/parse_errors.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

class UserRepository {

  Future<User> signUp(User user) async {
    final parseUser = ParseUser(user.email, user.password, user.email);

    parseUser
      ..set<String>(keyUserName, user.name)
      ..set<String>(keyUserPhone, user.phone)
      ..set(keyUserType, user.type.index);

    final response = await parseUser.signUp();

    if(response.success) {
      return mapParseToUser(response.results.first);
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<User> loginWithEmail(String email, String password) async {
    final parseUser = ParseUser(email, password, null);
    final response = await parseUser.login();

    if(response.success)
      return mapParseToUser(response.results.first);
    
    return Future.error(ParseErrors.getDescription(response.error.code));
  }

  User mapParseToUser(ParseUser parseUser) {
    return User(
      id: parseUser.objectId,
      name: parseUser.get(keyUserName),
      email: parseUser.get(keyUserEmail),
      phone: parseUser.get(keyUserPhone),
      type: Type.values[parseUser.get(keyUserType)],
      createdAt: parseUser.get(keyUserCreatedAt)
    );
  }

}