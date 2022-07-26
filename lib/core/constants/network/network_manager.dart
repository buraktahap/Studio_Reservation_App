// import 'package:dio/dio.dart';
// import 'package:studio_reservation_app/core/constants/enums/preferences_keys_enum.dart';
// import 'package:studio_reservation_app/core/init/cache/locale_manager.dart';

// class NetworkManager {
//   static NetworkManager _instance;
//   static NetworkManager get instance {
//     if (_instance == null) {
//       _instance = NetworkManager._();
//     }
//     return _instance;
//   }

//   NetworkManager._init() {
//     final baseOptions = BaseOptions(
//       baseUrl: 'https://localhost:7240/api/',
//       headers: {
//         "val": LocaleManager.instance.getStringValue(PreferencesKeys.TOKEN)
//       },
//     );
//     dio = Dio(baseOptions);
//     dio.inter
//   }
  
// }
