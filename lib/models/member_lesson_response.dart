// To parse this JSON data, do
//
//     final memberLessonResponse = memberLessonResponseFromJson(jsonString);

import 'dart:convert';

MemberLessonResponse memberLessonResponseFromJson(String str) =>
    MemberLessonResponse.fromJson(json.decode(str));

String memberLessonResponseToJson(MemberLessonResponse data) =>
    json.encode(data.toJson());

class MemberLessonResponse {
  MemberLessonResponse({
    this.isEnrolled,
    this.enrollCount,
    this.isCheckin,
    this.isCompleted,
    this.memberId,
    this.member,
    this.lessonId,
    this.lesson,
    this.id,
  });

  bool? isEnrolled;
  dynamic enrollCount;
  dynamic isCheckin;
  bool? isCompleted;
  int? memberId;
  dynamic member;
  int? lessonId;
  Lesson? lesson;
  int? id;

  factory MemberLessonResponse.fromJson(Map<String, dynamic> json) =>
      MemberLessonResponse(
        isEnrolled: json["isEnrolled"],
        enrollCount: json["enrollCount"],
        isCheckin: json["isCheckin"],
        isCompleted: json["isCompleted"],
        memberId: json["memberId"],
        member: json["member"],
        lessonId: json["lessonId"],
        lesson: Lesson.fromJson(json["lesson"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "isEnrolled": isEnrolled,
        "enrollCount": enrollCount,
        "isCheckin": isCheckin,
        "isCompleted": isCompleted,
        "memberId": memberId,
        "member": member,
        "lessonId": lessonId,
        "lesson": lesson?.toJson(),
        "id": id,
      };
}

class Lesson {
  Lesson({
    this.id,
    this.name,
    this.lessonType,
    this.lessonLevel,
    this.description,
    this.quota,
    this.startDate,
    this.estimatedTime,
    this.trainerId,
    this.trainer,
    this.classesId,
    this.classes,
  });

  int? id;
  String? name;
  int? lessonType;
  int? lessonLevel;
  dynamic description;
  int? quota;
  DateTime? startDate;
  DateTime? estimatedTime;
  int? trainerId;
  dynamic trainer;
  int? classesId;
  dynamic classes;

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json["id"],
        name: json["name"],
        lessonType: json["lessonType"],
        lessonLevel: json["lessonLevel"],
        description: json["description"],
        quota: json["quota"],
        startDate: DateTime.parse(json["startDate"]),
        estimatedTime: DateTime.parse(json["estimatedTime"]),
        trainerId: json["trainerId"],
        trainer: json["trainer"],
        classesId: json["classesId"],
        classes: json["classes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lessonType": lessonType,
        "lessonLevel": lessonLevel,
        "description": description,
        "quota": quota,
        "startDate": startDate?.toIso8601String(),
        "estimatedTime": estimatedTime?.toIso8601String(),
        "trainerId": trainerId,
        "trainer": trainer,
        "classesId": classesId,
        "classes": classes,
      };
}
