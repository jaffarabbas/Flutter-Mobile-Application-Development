class AppExceptions implements Exception {
  final _message;
  final _prefix;
  AppExceptions(this._message, this._prefix);

  @override
  String toString() {
    // TODO: implement toString
    return '${_message}${_prefix}';
  }
}

class NoInternetException extends AppExceptions {
  NoInternetException([String? message])
      : super(message, 'No Internet connection');
}

class UnAuthorizedException extends AppExceptions {
  UnAuthorizedException([String? message]) : super(message, 'Un Authorized');
}

class RequestTimeOutException extends AppExceptions {
  RequestTimeOutException([String? message])
      : super(message, 'Request Timeout');
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message]) : super(message, 'Cannot fetch data');
}
