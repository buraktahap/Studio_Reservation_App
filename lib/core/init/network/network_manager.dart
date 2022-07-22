// import 'package:dio/dio.dart';
// import 'core_dio.dart';
// import '../../constants/enums/preferences_keys_enum.dart';
// import '../cache/locale_manager.dart';
// import 'ICoreDio.dart';

// class NetworkManager {
//   static NetworkManager? _instance;

//   static NetworkManager? get instance {
//     if (_instance == null) {
//       _instance = NetworkManager._init();
//     }
//     return _instance;
//   }

//   late ICoreDio coreDio;

//   NetworkManager._init() {
//     final baseOptions = BaseOptions(
//       baseUrl: "https://jsonplaceholder.typicode.com/",
//       headers: {
//         "val": LocaleManager.instance.getStringValue(PreferencesKeys.TOKEN)
//       },
//     );
//     // _dio = Dio(baseOptions);

//     coreDio = CoreDio(baseOptions);

//     // _dio.interceptors.add(InterceptorsWrapper(
//     //   onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
//     //     // options.

//     //     options.path += "oguz";
//     //   },
//     //   onResponse: (
//     //     Response response,
//     //     ResponseInterceptorHandler handler,
//     //   ) {
//     //     // baseOptions
//     //     // return response.data;
//     //   },
//     //   onError: (DioError e, ErrorInterceptorHandler handler) {
//     //     // return BaseError(e.message);
//     //   },
//     // ));
//   }
// }
