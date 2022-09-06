// To parse this JSON data, do
//
//     final memberLessonWithLessonIncluded = memberLessonWithLessonIncludedFromJson(jsonString);

import 'dart:convert';

List<MemberLessonWithLessonIncluded> memberLessonWithLessonIncludedFromJson(
        String str) =>
    List<MemberLessonWithLessonIncluded>.from(json
        .decode(str)
        .map((x) => MemberLessonWithLessonIncluded.fromJson(x)));

String memberLessonWithLessonIncludedToJson(
        List<MemberLessonWithLessonIncluded> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemberLessonWithLessonIncluded {
  MemberLessonWithLessonIncluded({
    this.isEnrolled,
    this.isCheckin,
    this.isCompleted,
    this.rate,
    this.memberId,
    this.member,
    this.lessonId,
    this.lesson,
    this.id,
  });

  bool? isEnrolled;
  bool? isCheckin;
  bool? isCompleted;
  double? rate;
  int? memberId;
  dynamic member;
  int? lessonId;
  Lesson? lesson;
  int? id;

  factory MemberLessonWithLessonIncluded.fromJson(Map<String, dynamic> json) =>
      MemberLessonWithLessonIncluded(
        isEnrolled: json["isEnrolled"],
        isCheckin: json["isCheckin"],
        isCompleted: json["isCompleted"],
        rate: json["rate"]?.toDouble(),
        memberId: json["memberId"],
        member: json["member"],
        lessonId: json["lessonId"],
        lesson: Lesson.fromJson(json["lesson"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "isEnrolled": isEnrolled,
        "isCheckin": isCheckin,
        "isCompleted": isCompleted,
        "rate": rate,
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
    this.rate,
    this.enrollQuota,
    this.waitingQueueQuota,
    this.startDate,
    this.estimatedTime,
    this.trainerId,
    this.trainer,
    this.classesId,
    this.classes,
    this.enrollCount,
    this.waitingQueueCount,
    this.waitingQueues,
  });

  int? id;
  String? name;
  int? lessonType;
  int? lessonLevel;
  dynamic description;
  double? rate;
  int? enrollQuota;
  int? waitingQueueQuota;
  DateTime? startDate;
  DateTime? estimatedTime;
  int? trainerId;
  dynamic trainer;
  int? classesId;
  dynamic classes;
  int? enrollCount;
  int? waitingQueueCount;
  dynamic waitingQueues;

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json["id"],
        name: json["name"],
        lessonType: json["lessonType"],
        lessonLevel: json["lessonLevel"],
        description: json["description"],
        rate: json["rate"]?.toDouble(),
        enrollQuota: json["enrollQuota"],
        waitingQueueQuota: json["waitingQueueQuota"],
        startDate: DateTime.parse(json["startDate"]),
        estimatedTime: DateTime.parse(json["estimatedTime"]),
        trainerId: json["trainerId"],
        trainer: json["trainer"],
        classesId: json["classesId"],
        classes: json["classes"],
        enrollCount: json["enrollCount"],
        waitingQueueCount: json["waitingQueueCount"],
        waitingQueues: json["waitingQueues"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lessonType": lessonType,
        "lessonLevel": lessonLevel,
        "description": description,
        "rate": rate,
        "enrollQuota": enrollQuota,
        "waitingQueueQuota": waitingQueueQuota,
        "startDate": startDate?.toIso8601String(),
        "estimatedTime": estimatedTime?.toIso8601String(),
        "trainerId": trainerId,
        "trainer": trainer,
        "classesId": classesId,
        "classes": classes,
        "enrollCount": enrollCount,
        "waitingQueueCount": waitingQueueCount,
        "waitingQueues": waitingQueues,
      };
}
