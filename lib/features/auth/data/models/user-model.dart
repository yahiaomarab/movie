class UserModel {
  final String? uid;
  final String email;
  final String userName;
  final String? password;
  final String phone;

  UserModel({
    required this.phone,
    required this.email,
     this.password,
    required this.userName,
    required this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      phone: json['phone'],
      email: json['email'],
      password: json['password'],
      userName: json['username'],
      uid: json['uid'],
    );
  }

  toMap(){
    return {
      'email':email,
      'username':userName,
      'password':password,
      'phone':phone,
      'uid':uid
    };
  }
}
