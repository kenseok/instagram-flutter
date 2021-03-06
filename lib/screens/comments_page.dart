import 'package:flutter/material.dart';
import 'package:instagram_kenseok_app/constants/size.dart';
import 'package:instagram_kenseok_app/data/comment.dart';
import 'package:instagram_kenseok_app/data/user.dart';
import 'package:instagram_kenseok_app/firebase/firestore_provider.dart';
import 'package:instagram_kenseok_app/utils/profile_img_path.dart';
import 'package:instagram_kenseok_app/widgets/comment.dart';
import 'package:provider/provider.dart';

class CommentsPage extends StatefulWidget {
  final User user;
  final String postKey;

  const CommentsPage(
      this.user,
      this.postKey, {
        Key key,
      }) : super(key: key);

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  TextEditingController _commentsController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    _commentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Expanded(
              child: StreamProvider.value(
                value: firestoreProvider.fetchAllComments(widget.postKey),
                child: Consumer<List<CommentModel>>(
                  builder: (context, commentList, child) {
                    return ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: common_gap),
                        itemBuilder: (context, index) {
                          CommentModel comment = commentList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: common_gap),
                            child: Comment(
                              username: comment.username,
                              showProfile: true,
                              dateTime: comment.commenttime,
                              caption: comment.comment,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: common_gap,
                            color: Colors.transparent,
                          );
                        },
                        itemCount:
                        commentList == null ? 0 : commentList.length);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(common_gap),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      getProfileImgPath(widget.user.username),
                    ),
                    radius: profile_radius,
                  ),
                  SizedBox(
                    width: common_gap,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _commentsController,
                      showCursor: true,
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        border: InputBorder.none,
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Input something!!';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: common_gap,
                  ),
                  FlatButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await firestoreProvider.createNewComment(
                              widget.postKey,
                              CommentModel.getMapForNewComment(
                                  widget.user.userKey,
                                  widget.user.username,
                                  _commentsController.text));
                          _commentsController.clear();
                        }
                      },
                      child: Text(
                        'Post',
                        style: Theme.of(context).textTheme.button,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
