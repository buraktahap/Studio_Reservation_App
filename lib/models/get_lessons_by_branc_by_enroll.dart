// To parse this JSON data, do
//
//     final getLessonsByBranchNameWithEnroll = getLessonsByBranchNameWithEnrollFromJson(jsonString);

import 'dart:convert';

List<GetLessonsByBranchNameWithEnroll> getLessonsByBranchNameWithEnrollFromJson(
        String str) =>
    List<GetLessonsByBranchNameWithEnroll>.from(json
        .decode(str)
        .map((x) => GetLessonsByBranchNameWithEnroll.fromJson(x)));

String getLessonsByBranchNameWithEnrollToJson(
        List<GetLessonsByBranchNameWithEnroll> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetLessonsByBranchNameWithEnroll {
  GetLessonsByBranchNameWithEnroll({
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
  dynamic trainer;
  dynamic memberLessons;
  int? classesId;
  dynamic classes;
  bool? isEnrolled;

  factory GetLessonsByBranchNameWithEnroll.fromJson(
          Map<String, dynamic> json) =>
      GetLessonsByBranchNameWithEnroll(
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
        trainer: json["trainer"],
        memberLessons: json["memberLessons"],
        classesId: json["classesId"],
        classes: json["classes"],
        isEnrolled: json["isEnrolled"],
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
        "trainer": trainer,
        "memberLessons": memberLessons,
        "classesId": classesId,
        "classes": classes,
        "isEnrolled": isEnrolled,
      };
}
