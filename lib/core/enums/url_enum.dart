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
  GetMemberLessonsByMemberIdByLessonId,
  AddToWaitingQueue,
  GetWaitingQueueIndexByMemberAndLessonId,
  GetCompletedLesson,
  GetCompletedLessonCount,
  GetUngradedMemberLessons,
  PostLessonRate,
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
        return "/Lessons/GetLessonsByBranchName";
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
      case Urls.GetMemberLessonsByMemberIdByLessonId:
        return "/MemberLessons/GetMemberLessonsByMemberIdByLessonId";
      case Urls.AddToWaitingQueue:
        return "/MemberLessons/AddToWaitingQueue";
      case Urls.GetWaitingQueueIndexByMemberAndLessonId:
        return "/MemberLessons/GetWaitingQueueIndexByMemberAndLessonId";
      case Urls.GetCompletedLesson:
        return "/MemberLessons/GetCompletedLesson";
      case Urls.GetCompletedLessonCount:
        return "/MemberLessons/GetCompletedLessonCount";
      case Urls.GetUngradedMemberLessons:
        return "/MemberLessons/GetUngradedMemberLessons";
      case Urls.PostLessonRate:
        return "/MemberLessons/PostLessonRate";
    }
  }
}
