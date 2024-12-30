//! creating an object for the response body
class ResponseModel {
  bool _isSuccess;
  String _message;

  //! if you have private variables you cant use {}
  ResponseModel(
    this._isSuccess,
    this._message,
  );
  //! we want to get the message as a property
  //! because we want to make a public field we need to have a privaate variable
  String get message => _message;
  bool get isSuccess => _isSuccess;
}
