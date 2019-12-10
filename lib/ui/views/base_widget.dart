import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 자신의 모델을 필요로 하는 다른 위젯은 특정 유형으로 컨슈머를 설정해야 한다.
// BaseWidget 이라는 상태 저장 위젯을 만들고 확장하는 일반 클래스가 된다.
class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {

  final Widget Function(BuildContext context, T model, Widget child) builder;
  final T model;
  final Widget child;
  final Function(T) onModelReady;

  // 모든 파라미터 옵셔널임
  BaseWidget({Key key, this.builder, this.model, this.child, this.onModelReady}) : super(key: key);

  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends ChangeNotifier> extends State<BaseWidget<T>> {

  T model;

  @override
  void initState() {
    model = widget.model;

    // 생성자에서 onModelReady 가 파라미터로 들어왔으면 onModelReady 안에 모델을 파라미터로 넣어준다.
    if(widget.onModelReady != null) {
      widget.onModelReady(model);
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
        builder: (context) => model,
        child: Consumer<T>(
          builder: widget.builder,
          child: widget.child,
        ),
    );
  }
}

//      child: Consumer<LoginViewModel>(
//        child: LoginHeader(controller: _controller),
//        builder: (context, model, child) =>