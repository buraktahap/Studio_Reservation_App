class MemberLocationUpdate {
  int? id;
  String? location;

  MemberLocationUpdate({this.id, this.location});

  MemberLocationUpdate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['location'] = this.location;
    return data;
  }
}
