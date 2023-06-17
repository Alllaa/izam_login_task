class LoginRecords {
  int? id;
  String? email;
  String? password;
  int? loginCounts;

  LoginRecords({this.id, this.email, this.password, this.loginCounts});

  LoginRecords.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'].toString();
    password = json['password'].toString();
    loginCounts = json['loginCounts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['password'] = this.password;
    data['loginCounts'] = this.loginCounts;
    return data;
  }
}
