// ignore_for_file: non_constant_identifier_names

class MyUser {
  static const String collectionName = 'Users';

  String? id;
  String? name;
  String? email;

  MyUser({required this.id, required this.name, required this.email});

  Map<String, dynamic> tofirebase() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  MyUser.FromFirebase(Map<String, dynamic> data)
      : this(
          id: data['id'],
          name: data['name'],
          email: data['email'],
        );
}
