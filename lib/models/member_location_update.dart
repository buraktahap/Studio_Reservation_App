class MemberLocationUpdate {
  int? id;
  String? location;

  MemberLocationUpdate({this.id, this.location});

  MemberLocationUpdate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['location'] = location;
    return data;
  }
}
