// To parse this JSON data, do
//
//     final lessonResponseModel = lessonResponseModelFromJson(jsonString);

import 'dart:convert';

LessonResponseModel lessonResponseModelFromJson(String str) =>
    LessonResponseModel.fromJson(json.decode(str));

String lessonResponseModelToJson(LessonResponseModel data) =>
    json.encode(data.toJson());

class LessonResponseModel {
  LessonResponseModel({
    this.id,
    this.name,
    this.lessonType,
    this.lessonLevel,
    this.description,
    this.enrollQuota,
    this.waitingQueueQuota,
    this.enrollCount,
    this.waitingQueueCount,
    this.startDate,
    this.estimatedTime,
    this.trainerId,
    this.trainer,
    this.memberLessons,
    this.classesId,
    this.classes,
    this.isEnrolled,
    this.rate,
  });

  int? id;
  String? name;
  int? lessonType;
  int? lessonLevel;
  dynamic description;
  int? enrollQuota;
  int? waitingQueueQuota;
  int? enrollCount;
  int? waitingQueueCount;
  DateTime? startDate;
  DateTime? estimatedTime;
  int? trainerId;
  Trainer? trainer;
  List<dynamic>? memberLessons;
  int? classesId;
  Classes? classes;
  bool? isEnrolled;
  double? rate;

  factory LessonResponseModel.fromJson(Map<String, dynamic> json) =>
      LessonResponseModel(
        id: json["id"],
        name: json["name"],
        lessonType: json["lessonType"],
        lessonLevel: json["lessonLevel"],
        description: json["description"],
        enrollQuota: json["enrollQuota"],
        waitingQueueQuota: json["waitingQueueQuota"],
        enrollCount: json["enrollCount"],
        waitingQueueCount: json["waitingQueueCount"],
        startDate: DateTime.parse(json["startDate"]),
        estimatedTime: DateTime.parse(json["estimatedTime"]),
        trainerId: json["trainerId"],
        trainer: Trainer.fromJson(json["trainer"]),
        memberLessons: List<dynamic>.from(json["memberLessons"].map((x) => x)),
        classesId: json["classesId"],
        classes: Classes.fromJson(json["classes"]),
        isEnrolled: json["isEnrolled"],
        rate: json["rate"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lessonType": lessonType,
        "lessonLevel": lessonLevel,
        "description": description,
        "enrollQuota": enrollQuota,
        "waitingQueueQuota": waitingQueueQuota,
        "enrollCount": enrollCount,
        "waitingQueueCount": waitingQueueCount,
        "startDate": startDate?.toIso8601String(),
        "estimatedTime": estimatedTime?.toIso8601String(),
        "trainerId": trainerId,
        "trainer": trainer?.toJson(),
        "memberLessons": List<dynamic>.from(memberLessons?.map((x) => x) ?? []),
        "classesId": classesId,
        "classes": classes?.toJson(),
        "isEnrolled": isEnrolled,
        "rate": rate,
      };
}

class Classes {
  Classes({
    this.id,
    this.name,
    this.branchId,
    this.branch,
  });

  int? id;
  String? name;
  int? branchId;
  Branch? branch;

  factory Classes.fromJson(Map<String, dynamic> json) => Classes(
        id: json["id"],
        name: json["name"],
        branchId: json["branchId"],
        branch: Branch.fromJson(json["branch"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "branchId": branchId,
        "branch": branch?.toJson(),
      };
}

class Branch {
  Branch({
    this.id,
    this.name,
    this.location,
  });

  int? id;
  String? name;
  String? location;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        name: json["name"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location": location,
      };
}

class Trainer {
  Trainer({
    this.id,
    this.firstName,
    this.lastName,
    this.picture,
    this.description,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? picture;
  dynamic description;

  factory Trainer.fromJson(Map<String, dynamic> json) => Trainer(
        id: json["id"],
        firstName: json["first_Name"],
        lastName: json["last_Name"],
        picture: json["picture"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_Name": firstName,
        "last_Name": lastName,
        "picture": picture,
        "description": description,
      };
}
