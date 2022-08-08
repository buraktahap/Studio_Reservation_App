class LessonResponseModel {
  int? id;
  String? name;
  int? lessonType;
  int? lessonLevel;
  String? description;
  int? quota;
  String? startDate;
  String? estimatedTime;
  int? trainerId;
  int? classesId;

  LessonResponseModel(
      {this.id,
      this.name,
      this.lessonType,
      this.lessonLevel,
      this.description,
      this.quota,
      this.startDate,
      this.estimatedTime,
      this.trainerId,
      this.classesId});

  LessonResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lessonType = json['lessonType'];
    lessonLevel = json['lessonLevel'];
    description = json['description'];
    quota = json['quota'];
    startDate = json['startDate'];
    estimatedTime = json['estimatedTime'];
    trainerId = json['trainerId'];
    classesId = json['classesId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lessonType'] = this.lessonType;
    data['lessonLevel'] = this.lessonLevel;
    data['description'] = this.description;
    data['quota'] = this.quota;
    data['startDate'] = this.startDate;
    data['estimatedTime'] = this.estimatedTime;
    data['trainerId'] = this.trainerId;
    data['classesId'] = this.classesId;
    return data;
  }
}
