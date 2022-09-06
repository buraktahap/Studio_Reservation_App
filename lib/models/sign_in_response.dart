class SignInResponseModel {
  String? name;
  String? surname;
  String? picture;
  String? email;
  String? password;
  int? memberType;
  String? location;
  // List<String>? memberLessons;
  int? subscriptionsId;
  // String? subscriptions;
  int? id;

  SignInResponseModel(
      {this.name,
      this.surname,
      this.picture,
      this.email,
      this.password,
      this.memberType,
      this.location,
      // this.memberLessons,
      this.subscriptionsId,
      // this.subscriptions,
      this.id});

  SignInResponseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    surname = json['surname'];
    picture = json['picture'];
    email = json['email'];
    password = json['password'];
    memberType = json['memberType'];
    location = json['location'];
    // if (json['memberLessons'] != null) {
    //   memberLessons = <String>[];
    //   json['memberLessons'].forEach((v) {
    //     memberLessons!.add(new String.fromJson(v));
    //   });
    // }
    subscriptionsId = json['subscriptionsId'];
    // subscriptions = json['subscriptions'];
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
    // if (this.memberLessons != null) {
    //   data['memberLessons'] =
    //       this.memberLessons!.map((v) => v.toJson()).toList();
    // }
    data['subscriptionsId'] = subscriptionsId;
    // data['subscriptions'] = this.subscriptions;
    data['id'] = id;
    return data;
  }
}
