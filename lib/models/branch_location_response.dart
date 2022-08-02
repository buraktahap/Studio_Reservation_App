class BranchLocationResponseModel {
  String? name;
  String? location;
  int? id;

  BranchLocationResponseModel(
      {this.name,
      this.location,
      this.id});

  BranchLocationResponseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    location = json['location'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['location'] = this.location;
    data['id'] = this.id;
    return data;
  }
}
