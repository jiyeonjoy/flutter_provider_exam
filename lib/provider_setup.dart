import 'package:provider/provider.dart';
import 'package:provider_arc/core/models/user.dart';
import 'package:provider_arc/core/services/api.dart';
import 'package:provider_arc/core/services/authentication_service.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
];

// 논리를 실행하기 위해 다른 서비스에 의존하지 않는 클래스/객체
List<SingleChildCloneableWidget> independentServices = [
  Provider.value(value: Api())
];

// 이전에 등록 된 서비스에 의존하는 클래스/객체
List<SingleChildCloneableWidget> dependentServices = [
  ProxyProvider<Api, AuthenticationService>(
    builder: (context, api, authenticationService) =>
      AuthenticationService(api: api),
  )
];

// UI 에서 직접 소비하려는 값. 모든 모델이 데이터를 가져 오기 위해 필요한 것은 아니지만
// 대부분의 경우 속성을 도입해야 하는 경우 여기에 값을 추가 할 수 있다.
// 이 앱의 경우 사용자 정보.
// 모든 모델에 사용자 속성이 필요하므로 여기서 user 의 값을 가져온다.
List<SingleChildCloneableWidget> uiConsumableProviders = [
  StreamProvider<User>(
    builder: (context) => Provider.of<AuthenticationService>(context, listen: false).user,
  )
];