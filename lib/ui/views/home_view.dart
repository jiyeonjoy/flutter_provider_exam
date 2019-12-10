import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_arc/core/models/user.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/text_styles.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/widgets/posts.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UIHelper.verticalSpaceLarge,
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                // 멀티 프로바이더에서 지정해줬던 유저 정보를 받아옴.
                'Welcome ${Provider.of<User>(context).name}',
                style: headerStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text('Here are all your posts', style: subHeaderStyle),
            ),
            UIHelper.verticalSpaceSmall,
            // child 가 사용 가능한 공간을 채우도록 확장하는 위젯
            Expanded(child: Posts(),)
          ],
      ),
    );
  }
}
