enum Urls {
  SignIn,
}

extension UrlsExtension on Urls {
  String get rawValue {
    switch (this) {
      case Urls.SignIn:
        return "/Member/LoginRequest";
    }
  }
}
