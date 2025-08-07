import 'package:flutter/foundation.dart';
import 'package:story_app/static_constant.dart';

Exception handleError(int statusCode) {
  switch (statusCode) {
    case 400:
      return Exception('Bad Request${StaticConstant.suffixMessageToUser}');
    case 401:
      return Exception('Unauthorized${StaticConstant.suffixMessageToUser}');
    case 403:
      return Exception('Forbidden${StaticConstant.suffixMessageToUser}');
    case 404:
      return Exception('Not Found${StaticConstant.suffixMessageToUser}');
    case 500:
      return Exception(
        'Internal Server Error${StaticConstant.suffixMessageToUser}',
      );
    default:
      return Exception(
        'Request failed with status: $statusCode${StaticConstant.suffixMessageToUser}',
      );
  }
}

Exception handleException(dynamic error) {
  if (error is Exception) {
    debugPrint(error.toString());
    return Exception(StaticConstant.messageToUser);
  }
  return Exception(
    'Network error: $error${StaticConstant.suffixMessageToUser}',
  );
}
