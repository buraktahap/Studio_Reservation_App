class Member {
  int? id;
  String? name;
  String? surname;
  String? picture;
  String? email;
  String? password;
  int? memberType;
  String? location;
  int? subscriptionsId;

  Member(
      {this.id,
      this.name,
      this.surname,
      this.picture,
      this.email,
      this.password,
      this.memberType,
      this.location,
      this.subscriptionsId});

  Member.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    picture = json['picture'];
    email = json['email'];
    password = json['password'];
    memberType = json['memberType'];
    location = json['location'];
    subscriptionsId = json['subscriptionsId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['surname'] = surname;
    data['picture'] = picture;
    data['email'] = email;
    data['password'] = password;
    data['memberType'] = memberType;
    data['location'] = location;
    data['subscriptionsId'] = subscriptionsId;
    return data;
  }

  Member member = Member();
}
