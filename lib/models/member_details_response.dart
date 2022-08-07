class MemberDetailsResponse {
  int? id;
  String? name;
  String? surname;
  String? picture;
  String? email;
  String? password;
  int? memberType;
  String? location;
  int? subscriptionsId;

  MemberDetailsResponse(
      {this.id,
      this.name,
      this.surname,
      this.picture,
      this.email,
      this.password,
      this.memberType,
      this.location,
      this.subscriptionsId});

  MemberDetailsResponse.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['picture'] = this.picture;
    data['email'] = this.email;
    data['password'] = this.password;
    data['memberType'] = this.memberType;
    data['location'] = this.location;
    data['subscriptionsId'] = this.subscriptionsId;
    return data;
  }
}
