// To parse this JSON data, do
//
//     final enrollCancelMemberLessonPost = enrollCancelMemberLessonPostFromJson(jsonString);

import 'dart:convert';

EnrollCancelMemberLessonPost enrollCancelMemberLessonPostFromJson(String str) =>
    EnrollCancelMemberLessonPost.fromJson(json.decode(str));

String enrollCancelMemberLessonPostToJson(EnrollCancelMemberLessonPost data) =>
    json.encode(data.toJson());

class EnrollCancelMemberLessonPost {
  EnrollCancelMemberLessonPost({
    required this.memberId,
    required this.lessonId,
  });

  int memberId;
  int lessonId;

  factory EnrollCancelMemberLessonPost.fromJson(Map<String, dynamic> json) =>
      EnrollCancelMemberLessonPost(
        memberId: json["memberId"],
        lessonId: json["lessonId"],
      );

  Map<String, dynamic> toJson() => {
        "memberId": memberId,
        "lessonId": lessonId,
      };
}
