class Lesson {
  int? id;
  String? name;
  int? lessonType;
  int? lessonLevel;
  String? description;
  int? quota;
  DateTime? startDate;
  String? estimatedTime;
  int? trainerId;
  int? classesId;

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
    this.classesId,
  });

  Lesson.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['lessonType'] = lessonType;
    data['lessonLevel'] = lessonLevel;
    data['description'] = description;
    data['quota'] = quota;
    data['startDate'] = startDate;
    data['estimatedTime'] = estimatedTime;
    data['trainerId'] = trainerId;
    data['classesId'] = classesId;
    return data;
  }
}
