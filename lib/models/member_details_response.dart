// To parse this JSON data, do
//
//     final memberDetailsResponse = memberDetailsResponseFromJson(jsonString);

import 'dart:convert';

MemberDetailsResponse memberDetailsResponseFromJson(String str) => MemberDetailsResponse.fromJson(json.decode(str));

String memberDetailsResponseToJson(MemberDetailsResponse data) => json.encode(data.toJson());

class MemberDetailsResponse {
    MemberDetailsResponse({
        this.name,
        this.surname,
        this.picture,
        this.email,
        this.password,
        this.memberType,
        this.location,
        this.memberLessons,
        this.subscriptionsId,
        this.subscriptions,
        this.id,
    });

    String? name;
    String? surname;
    dynamic picture;
    String? email;
    String? password;
    int? memberType;
    String? location;
    List<dynamic>? memberLessons;
    int? subscriptionsId;
    Subscriptions? subscriptions;
    int? id;

    factory MemberDetailsResponse.fromJson(Map<String, dynamic> json) => MemberDetailsResponse(
        name: json["name"],
        surname: json["surname"],
        picture: json["picture"],
        email: json["email"],
        password: json["password"],
        memberType: json["memberType"],
        location: json["location"],
        subscriptionsId: json["subscriptionsId"],
        subscriptions: Subscriptions.fromJson(json["subscriptions"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "surname": surname,
        "picture": picture,
        "email": email,
        "password": password,
        "memberType": memberType,
        "location": location,
        "subscriptionsId": subscriptionsId,
        "subscriptions": subscriptions?.toJson(),
        "id": id,
    };
}

class Subscriptions {
    Subscriptions({
        this.subsType,
        this.startDate,
        this.endDate,
        this.id,
    });

    int? subsType;
    DateTime? startDate;
    DateTime? endDate;
    int? id;

    factory Subscriptions.fromJson(Map<String, dynamic> json) => Subscriptions(
        subsType: json["subsType"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "subsType": subsType,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "id": id,
    };
}
