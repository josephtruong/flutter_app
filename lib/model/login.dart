import 'dart:async';

import 'package:flutter_app/model/BaseResponse.dart';
import 'package:flutter_app/model/request_login.dart';

class LoginBloc {
  StreamController _streamController;

  StreamSink<String> get requestLoginStreamSink => _streamController.sink;

  Stream<String> get requestLoginStream => _streamController.stream;

  login(RequestLogin requestLogin){
      requestLoginStreamSink.add("Ok");
  }
}
