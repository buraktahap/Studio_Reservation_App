enum Urls {
  SignIn,
  GetAllLocations,
  MemberLocationUpdate,
  GetAllLessons,
  LessonsByBranchName
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
    }
  }
}
