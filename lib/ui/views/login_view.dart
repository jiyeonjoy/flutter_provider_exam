import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_arc/core/constants/app_contstants.dart';
import 'package:provider_arc/core/viewmodels/views/login_new_model.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/views/base_widget.dart';
import 'package:provider_arc/ui/widgets/login_header.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
//    return ChangeNotifierProvider<LoginViewModel>.value(
//      value: LoginViewModel(
//          authenticationService: Provider.of(context)
//      ),
//      child: Consumer<LoginViewModel>(
//        child: LoginHeader(controller: _controller),
//        builder: (context, model, child) =>
    return BaseWidget<LoginViewModel>(
      model: LoginViewModel(authenticationService: Provider.of(context)),
      child: LoginHeader(controller: _controller),
      builder: (context, model, child) =>
          Scaffold(
              backgroundColor: backgroundColor,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // 위에서 선언한 LoginHeader 를 가져온다.
                  child,
                  // 모델이 아직 정보를 가지고 오는 중이면 프로그레스바 가동
                  model.busy ?
                  CircularProgressIndicator() : FlatButton(
                    color: Colors.white,
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      var loginSuccess =
                      await model.login(_controller.text);
                      if (loginSuccess) {
                        Navigator.pushNamed(context, RoutePaths.Home);
                      }
                    },
                  )
                ],
              )
          ),
    );
  }
}

