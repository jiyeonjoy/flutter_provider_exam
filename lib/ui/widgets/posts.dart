import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_arc/core/constants/app_contstants.dart';
import 'package:provider_arc/core/models/user.dart';
import 'package:provider_arc/core/viewmodels/widgets/posts_model.dart';
import 'package:provider_arc/ui/views/base_widget.dart';
import 'package:provider_arc/ui/widgets/postlist_item.dart';

class Posts extends StatelessWidget {
  const Posts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<PostsModel>(
        model: PostsModel(api: Provider.of(context)),
        // 역시 유저 정보 가져옴.
        // BaseWidget 생성자에 onModelReady 파라미터 넣어주면
        // BaseWidget 생성할때 init 에서 모델을 Function 에 넘겨준다.
        // 따라서 PostsModel 의 getPosts 가 호출되는 것임.
        onModelReady: (model) => model.getPosts(Provider.of<User>(context).id),
        builder: (context, model, child) =>
        // 모델이 아직 일하는 중이면 역시 프로그레스바 가동
        model.busy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
          // onModelReady 메서드에서 실행하여 받아온 포스트들이 리스트 뷰에 뿌려진다.
                itemCount: model.posts.length,
                itemBuilder: (context, index) => PostListItem(
                      post: model.posts[index],
                      onTap: () {
                        Navigator.pushNamed(context, RoutePaths.Post,
                            arguments: model.posts[index]);
                      },
                    )));
  }
}
