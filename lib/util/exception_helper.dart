import 'package:flutter/foundation.dart';
import 'package:story_app/models/response.dart';
import 'package:story_app/static_constant.dart';

Exception handleError(int statusCode, BaseResponse response) {
  debugPrint('Error: ${response.message} (Status code: $statusCode)');
  switch (statusCode) {
    case 400:
      // return Exception('Bad Request${StaticConstant.suffixMessageToUser}');
      return Exception('Bad Request: ${response.message}');
    case 401:
      // return Exception('Unauthorized${StaticConstant.suffixMessageToUser}');
      return Exception('Unauthorized: ${response.message}');
    case 403:
      // return Exception('Forbidden${StaticConstant.suffixMessageToUser}');
      return Exception('Forbidden: ${response.message}');
    case 404:
      // return Exception('Not Found${StaticConstant.suffixMessageToUser}');
      return Exception('Not Found: ${response.message}');
    case 500:
      // return Exception(
      //   'Internal Server Error${StaticConstant.suffixMessageToUser}',
      // );
      return Exception('Internal Server Error: ${response.message}');
    default:
      // return Exception(
      //   'Request failed with status: $statusCode${StaticConstant.suffixMessageToUser}',
      // );
      return Exception(
        'Request failed with status $statusCode: ${response.message}',
      );
  }
}

Exception handleException(dynamic error) {
  if (error is Exception) {
    debugPrint('handleException: ${error.toString()}');
    // return Exception(StaticConstant.messageToUser);
    return Exception(error.toString());
  }
  return Exception(
    'Network error: $error${StaticConstant.suffixMessageToUser}',
  );
}
