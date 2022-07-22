class SignInResponse {
  int? userId;
  SignInResponse({this.userId});
  SignInResponse.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    return data;
  }
}
