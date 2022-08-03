// import 'package:dio/dio.dart';
// import 'package:mobx/mobx.dart';
// import 'package:studio_reservation_app/classes/lesson.dart';
// import 'package:studio_reservation_app/core/constants/network/network_constants.dart';
// import 'package:studio_reservation_app/core/enums/url_enum.dart';
// part 'booking_view_model.g.dart';

// class BookingViewModel = _BookingViewModelBase with _$BookingViewModel;

// abstract class _BookingViewModelBase with Store {
//   List<dynamic> lessons = [];

//   final dio = Dio(
//     BaseOptions(
//       baseUrl: NetworkConstants.BASE_URL,
//       headers: {"Content-Type": "application/json"},
//     ),
//   );

//   @observable
//   Future getAllLessons() async {
//     final response = await dio.get(Urls.GetAllLessons.rawValue);
//     if (response.statusCode == 200) {
//       final responseBody = await response.data;
//       if (lessons is List) {
//         return lessons = responseBody.map((e) => Lesson.fromJson(e)).toList();
//       }
//       return Future.error(responseBody);
//     }
//   }

//   @observable
//   ObservableFuture<List<Lesson>>? lessonListFuture;

//   @action
//   Future fetchLessons() => lessonListFuture = ObservableFuture(getAllLessons().then((lessons) => lessons));
  
  
// }
