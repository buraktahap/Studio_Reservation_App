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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['picture'] = this.picture;
    data['email'] = this.email;
    data['password'] = this.password;
    data['memberType'] = this.memberType;
    data['location'] = this.location;
    data['subscriptionsId'] = this.subscriptionsId;
    data['id'] = this.id;
    return data;
  }
}
