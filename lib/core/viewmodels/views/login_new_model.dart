import 'package:flutter/cupertino.dart';
import 'package:provider_arc/core/services/authentication_service.dart';
import 'package:provider_arc/core/viewmodels/base_model.dart';

// 로그인 로직 작성.
// AuthenticationService 의존
// 이 모델이 수행하는 유일한 작업은 userId 를 받아와 구문 분석 한 다음에
// 로그인 호출하여 응답을 리턴하는 것이다.
class LoginViewModel extends BaseModel {
  AuthenticationService _authenticationService;

  LoginViewModel({
    @required AuthenticationService authenticationService,
}) : _authenticationService = authenticationService;


  Future<bool> login(String userIdText) async {
    // setBusy(true) 하는 이유는 프로그레스바 돌리기 위한 것임.
    setBusy(true);
    var userId = int.tryParse(userIdText);
    var success = await _authenticationService.login(userId);
    setBusy(false);
    return success;
  }
}