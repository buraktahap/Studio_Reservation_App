import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Member {
  int? id;
  String? creationTime;
  int? creatorUserId;
  String? lastModificationTime;
  int? lastModifierUserId;
  bool? isDeleted;
  int? deleterUserId;
  String? deletionTime;
  String? name;
  String? surname;
  String? picture;
  String? email;
  String? password;
  int? memberType;
  String? location;

  Member(
      {this.id,
      this.creationTime,
      this.creatorUserId,
      this.lastModificationTime,
      this.lastModifierUserId,
      this.isDeleted,
      this.deleterUserId,
      this.deletionTime,
      this.name,
      this.surname,
      this.picture,
      this.email,
      this.password,
      this.memberType,
      this.location});

  Member.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creationTime = json['creationTime'];
    creatorUserId = json['creatorUserId'];
    lastModificationTime = json['lastModificationTime'];
    lastModifierUserId = json['lastModifierUserId'];
    isDeleted = json['isDeleted'];
    deleterUserId = json['deleterUserId'];
    deletionTime = json['deletionTime'];
    name = json['name'];
    surname = json['surname'];
    picture = json['picture'];
    email = json['email'];
    password = json['password'];
    memberType = json['memberType'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['creationTime'] = this.creationTime;
    data['creatorUserId'] = this.creatorUserId;
    data['lastModificationTime'] = this.lastModificationTime;
    data['lastModifierUserId'] = this.lastModifierUserId;
    data['isDeleted'] = this.isDeleted;
    data['deleterUserId'] = this.deleterUserId;
    data['deletionTime'] = this.deletionTime;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['picture'] = this.picture;
    data['email'] = this.email;
    data['password'] = this.password;
    data['memberType'] = this.memberType;
    data['location'] = this.location;
    return data;
  }
}

Future<Member> fetchAlbum() async {
  final response =
      await http.get(Uri.parse('https://localhost:7240/api/Member'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Member.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load member');
  }
}
