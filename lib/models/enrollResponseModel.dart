class enrollResponseModel {
  int? memberId;
  int? lessonId;

  enrollResponseModel({
    this.memberId,
    this.lessonId,
  });

  enrollResponseModel.fromJson(Map<String, dynamic> json) {
    memberId = json['memberId'];
    lessonId = json['lessonId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['memberId'] = this.memberId;
    data['lessonId'] = this.lessonId;
    return data;
  }
}
