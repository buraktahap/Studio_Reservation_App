class BranchLocationResponseModel {
  String? name;
  String? location;
  int? id;

  BranchLocationResponseModel({this.name, this.location, this.id});

  BranchLocationResponseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    location = json['location'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['location'] = location;
    data['id'] = id;
    return data;
  }
}
