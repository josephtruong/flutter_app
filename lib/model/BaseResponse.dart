class BaseResponse<T> {
  var message;
  T data;

  BaseResponse.fromJson(Map<dynamic, dynamic> json) {
    message = json['message'];
    data = json['data'];
  }
}
