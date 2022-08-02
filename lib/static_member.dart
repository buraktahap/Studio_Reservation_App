import 'package:dio/dio.dart';
import 'package:studio_reservation_app/classes/Member.dart';
import 'package:studio_reservation_app/models/sign_in_response.dart';

class StaticMember {
  static Member member = Member(
    id: null,
    email: null,
    password: null,
    location: null,
    memberType: null,
    name: null,
    surname: null,
    picture: null,
  );
}
