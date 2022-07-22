// import 'dart:io';

// import 'package:vexana/vexana.dart';

// class VexanaManager {
//   static VexanaManager? _instance;
//   static VexanaManager? get instance {
//     if (_instance == null) _instance = VexanaManager._init();
//     return _instance;
//   }

//   String get iosBaseUrl => "http://localhost:3000/";
//   String get androidBaseUrl => "http://10.0.2.2:300/";
//   VexanaManager._init();

//   INetworkManager networkManager = NetworkManager(
//       isEnableLogger: true,
//       options: BaseOptions(
//         baseUrl: Platform.isAndroid
//             ? _instance?.androidBaseUrl as String
//             : _instance?.iosBaseUrl as String,
//       ));
// }
