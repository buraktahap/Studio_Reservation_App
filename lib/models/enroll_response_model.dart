class EnrollResponseModel {
  int? memberId;
  int? lessonId;

  EnrollResponseModel({
    this.memberId,
    this.lessonId,
  });

  EnrollResponseModel.fromJson(Map<String, dynamic> json) {
    memberId = json['memberId'];
    lessonId = json['lessonId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['memberId'] = memberId;
    data['lessonId'] = lessonId;
    return data;
  }
}
