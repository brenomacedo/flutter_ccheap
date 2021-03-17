enum Type {
  PARTICULAR, PROFESSIONAL
}

class User {

  User({ this.name, this.email, this.phone, this.password, this.type = Type.PARTICULAR, this.id, this.createdAt });

  String id;
  String name;
  String email;
  String phone;
  String password;
  Type type;
  DateTime createdAt;

  @override
  String toString() {
    return 'User: { name: $name, email: $email, phone: $phone }';
  }
}