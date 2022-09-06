enum Urls {
  signIn,
  getAllLocations,
  memberLocationUpdate,
  getAllLessons,
  lessonsByBranchName,
  enroll,
  getMemberById,
  checkInLessonDetails,
  getLessonById,
  checkIn,
  enrollCancel,
  reservationList,
  getMemberLessonsByMemberIdByLessonId,
  addToWaitingQueue,
  getWaitingQueueIndexByMemberAndLessonId,
  getCompletedLesson,
  getCompletedLessonCount,
  getUngradedMemberLessons,
  postLessonRate,
}

extension UrlsExtension on Urls {
  String get rawValue {
    switch (this) {
      case Urls.signIn:
        return "/Auth/SignIn";
      case Urls.getAllLocations:
        return "/Branchs/GetAllBranches";
      case Urls.memberLocationUpdate:
        return "/Members/locationUpdate";
      case Urls.getAllLessons:
        return "/Lessons/GetAllLessons";
      case Urls.lessonsByBranchName:
        return "/Lessons/GetLessonsByBranchName";
      case Urls.enroll:
        return "/MemberLessons/Enroll";
      case Urls.getMemberById:
        return "/Members/getById";
      case Urls.checkInLessonDetails:
        return "/MemberLessons/CheckInLessonDetails";
      case Urls.getLessonById:
        return "/Lessons/GetLessonById";
      case Urls.checkIn:
        return "/MemberLessons/CheckIn";
      case Urls.enrollCancel:
        return "/MemberLessons/EnrollCancel";
      case Urls.reservationList:
        return "/MemberLessons/ReservationList";
      case Urls.getMemberLessonsByMemberIdByLessonId:
        return "/MemberLessons/GetMemberLessonsByMemberIdByLessonId";
      case Urls.addToWaitingQueue:
        return "/MemberLessons/AddToWaitingQueue";
      case Urls.getWaitingQueueIndexByMemberAndLessonId:
        return "/MemberLessons/GetWaitingQueueIndexByMemberAndLessonId";
      case Urls.getCompletedLesson:
        return "/MemberLessons/GetCompletedLesson";
      case Urls.getCompletedLessonCount:
        return "/MemberLessons/GetCompletedLessonCount";
      case Urls.getUngradedMemberLessons:
        return "/MemberLessons/GetUngradedMemberLessons";
      case Urls.postLessonRate:
        return "/MemberLessons/PostLessonRate";
    }
  }
}
