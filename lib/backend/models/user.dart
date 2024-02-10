class User {
  int? id;
  String? name;
  String? mobile;
  String? avatar;

  User({this.id, this.name, this.mobile, this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['avatar'] = this.avatar;
    return data;
  }
}