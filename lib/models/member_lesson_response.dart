
class memberLessonResponse {
  bool? isEnrolled;
  int? enrollCount;
  bool? isCheckin;
  bool? isCompleted;
  int? memberId;
  int? lessonId;

  memberLessonResponse(
      {this.isEnrolled,
      this.enrollCount,
      this.isCheckin,
      this.isCompleted,
      this.memberId,
      this.lessonId});

  memberLessonResponse.fromJson(Map<String, dynamic> json) {
    isEnrolled = json['isEnrolled'];
    enrollCount = json['enrollCount'];
    isCheckin = json['isCheckin'];
    isCompleted = json['isCompleted'];
    memberId = json['memberId'];
    lessonId = json['lessonId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isEnrolled'] = this.isEnrolled;
    data['enrollCount'] = this.enrollCount;
    data['isCheckin'] = this.isCheckin;
    data['isCompleted'] = this.isCompleted;
    data['memberId'] = this.memberId;
    data['lessonId'] = this.lessonId;
    return data;
  }
}
