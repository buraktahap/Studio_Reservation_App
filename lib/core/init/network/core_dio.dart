// import 'dart:io';

// import 'package:dio/adapter.dart';
// import 'package:dio/dio.dart';

// import '../../base/model/base_error.dart';
// import '../../base/model/base_model.dart';
// import '../../constants/enums/http_request_enum.dart';
// import '../../extensions/network_extension.dart';
// import 'ICoreDio.dart';
// import 'IResponseModel.dart';

// part './network_core/core_operations.dart';

// class CoreDio with DioMixin implements Dio, ICoreDio {
//   final BaseOptions options;

//   CoreDio(this.options) {
//     this.options = options;
//     this.interceptors.add(InterceptorsWrapper());

//     this.httpClientAdapter = DefaultHttpClientAdapter();
//   }

//   Future<IResponseModel<R>> fetchData<R, T extends BaseModel>(String path,
//       {required HttpTypes type,
//       required T parseModel,
//       dynamic data,
//       Map<String, dynamic>? queryParameters,
//       void Function(int, int)? onReceiveProgress}) async {
//     final response = await request(path,
//         data: data, options: Options(method: type.rawValue));

//     switch (response.statusCode) {
//       case HttpStatus.ok:
//       case HttpStatus.accepted:
//         final model = _responseParser<R>(parseModel, _responseParser);
//         return ResponseModel<R>(data: model);

//       default:
//         return ResponseModel(error: BaseError("message"));
//     }
//   }
// }
