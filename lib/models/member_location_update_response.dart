class MemberLocationUpdateResponse {
  String? name;
  String? surname;
  String? picture;
  String? email;
  String? password;
  int? memberType;
  String? location;
  int? subscriptionsId;
  int? id;

  MemberLocationUpdateResponse(
      {this.name,
      this.surname,
      this.picture,
      this.email,
      this.password,
      this.memberType,
      this.location,
      this.subscriptionsId,
      this.id});

  MemberLocationUpdateResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    surname = json['surname'];
    picture = json['picture'];
    email = json['email'];
    password = json['password'];
    memberType = json['memberType'];
    location = json['location'];
    subscriptionsId = json['subscriptionsId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['surname'] = surname;
    data['picture'] = picture;
    data['email'] = email;
    data['password'] = password;
    data['memberType'] = memberType;
    data['location'] = location;
    data['subscriptionsId'] = subscriptionsId;
    data['id'] = id;
    return data;
  }
}
