class UserModel {
  String? uid;
  String? email;
  String? phone;
  String? firstName;
  String? secondName;

  UserModel(
      {this.uid, this.phone, this.email, this.firstName, this.secondName});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      phone: map['phone'],
      firstName: map['firstName'],
      secondName: map['secondName'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'phone': phone,
      'firstName': firstName,
      'secondName': secondName,
    };
  }
}
