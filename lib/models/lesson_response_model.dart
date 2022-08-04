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
  Null? trainer;
  Null? memberLessons;
  int? classesId;
  Null? classes;

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
      this.trainer,
      this.memberLessons,
      this.classesId,
      this.classes});

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
    trainer = json['trainer'];
    memberLessons = json['memberLessons'];
    classesId = json['classesId'];
    classes = json['classes'];
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
    data['trainer'] = this.trainer;
    data['memberLessons'] = this.memberLessons;
    data['classesId'] = this.classesId;
    data['classes'] = this.classes;
    return data;
  }
}
