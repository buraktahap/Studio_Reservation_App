enum Urls {
  SignIn,
  GetAllLocations,
  MemberLocationUpdate,
  GetAllLessons,
  LessonsByBranchName,
  Enroll,
  GetMemberById,
  CheckInLessonDetails,
  GetLessonById,
  CheckIn,
  EnrollCancel,
  ReservationList,
}

extension UrlsExtension on Urls {
  String get rawValue {
    switch (this) {
      case Urls.SignIn:
        return "/Auth/SignIn";
      case Urls.GetAllLocations:
        return "/Branchs/GetAllBranches";
      case Urls.MemberLocationUpdate:
        return "/Members/locationUpdate";
      case Urls.GetAllLessons:
        return "/Lessons/GetAllLessons";
      case Urls.LessonsByBranchName:
        return "/Lessons/LessonsByBranchName";
      case Urls.Enroll:
        return "/MemberLessons/Enroll";
      case Urls.GetMemberById:
        return "/Members/getById";
      case Urls.CheckInLessonDetails:
        return "/MemberLessons/CheckInLessonDetails";
      case Urls.GetLessonById:
        return "/Lessons/GetLessonById";
      case Urls.CheckIn:
        return "/MemberLessons/CheckIn";
      case Urls.EnrollCancel:
        return "/MemberLessons/EnrollCancel";
      case Urls.ReservationList:
        return "/MemberLessons/ReservationList";
    }
  }
}
