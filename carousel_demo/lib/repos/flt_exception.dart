import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

/// A class defines exception type
enum ExceptionType {
  /// Response type
  Response,

  /// Network type
  Network,

  /// Token expire type
  TokenExpire,

  /// Login error: subCode = 0: Invalid username or password
  LoginInvalidUsernameOrPassword,

  /// Login error: subCode = 1: This organization not active
  LoginOrganizationNotActive,

  /// Login error: subCode = 2: This account not active
  LoginAccountNotActive,

  /// Login error: subCode = -1: user is requesting to change password
  LoginUserIsChangingPassword,

  /// Login error: subCode = -2: user is being suspended
  LoginUserIsSuspended,

  /// Login error: subCode = -3: user is requesting to change email
  LoginUserIsChangingEmail,

  /// Login error: subCode = 1: Organization not found
  LoginOrganizationNotFound,

  /// Login error: subCode = 2: User not found
  LoginUserNotFound,
}

/// Utility class help handle data exception
class ExceptionHelper {
  /// Create new instance of FltException from any kind from error
  static FltException newInstance(dynamic e, {String endpoint}) {
    if (e is InvalidUserException) return e;

    print('DioError: endpoint=$endpoint: $e');
    if (e is DioError) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT ||
          e.type == DioErrorType.SEND_TIMEOUT) {
        return ConnectionTimeoutException(
            message: 'Timeout when connect to server. Please try again',
            detail: e.toString());
      } else if (e.type == DioErrorType.DEFAULT && e.error is SocketException) {
        return FltException(type: ExceptionType.Network);
      } else {
        return FltException(
            type: ExceptionType.Response,
            message: e.message,
            endpoint: endpoint);
      }
    }

//    if (e is DatabaseException) FltException(message: e.toString());

    if (e is FltException) return e;

    if (e is String) return FltException(message: e);

    if (e is PlatformException) {
      return FltException(code: e.code, message: e.message);
    }

    if (e is Map<String, dynamic>) {
      // http success (200/201) but error data
      return FltException(
          code: e['code'], message: e['errors']['message'], info: e);
    }

    return FltException(message: e.toString());
  }
}

/// A common exception for app
class FltException implements Exception {
  /// code error
  final dynamic code;

  /// message error
  final dynamic message;

  /// endpoint
  final String endpoint;

  /// info
  final dynamic info;

  /// exception type
  final ExceptionType type;

  /// Constructor flt exception
  FltException({this.code, this.type, this.message, this.endpoint, this.info});

  @override
  String toString() {
    return 'FlException{code: $code, $type: message: $message, info: $info}';
  }

  /// Localization language
  String get localizeMessage {
    var _localMessage = message;
    switch (type) {
      case ExceptionType.LoginInvalidUsernameOrPassword:
        return _localMessage = 'Invalid username or password';
        break;
      case ExceptionType.Network:
        _localMessage = 'Please check your internet';
        break;
      default:
        break;
    }
    return _localMessage;
  }
}

/// Class contain user exception info
class InvalidUserException extends FltException {
  /// detail exception
  final String detail;

  /// message exception
  final String message;

  /// Constructor InvalidUserException
  InvalidUserException({
    this.message = 'Invalid user',
    this.detail,
  });

  String toString() {
    return "InvalidTokenException{message: $message, detail: $detail}";
  }
}

/// Class contain timeout info
class ConnectionTimeoutException extends FltException {
  /// message exception
  final String message;

  /// detail exception
  final String detail;

  /// Constructor ConnectionTimeoutException
  ConnectionTimeoutException({
    this.message = 'Cannot connect to server',
    this.detail,
  });

  @override
  String toString() {
    return 'ConnectionTimeoutException{message: $message, detail: $detail}';
  }
}
