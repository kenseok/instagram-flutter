import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_kenseok_app/data/comment.dart';
import 'package:instagram_kenseok_app/data/user.dart';
import 'package:instagram_kenseok_app/data/post.dart';

class Transformer {
  final toUser = StreamTransformer<DocumentSnapshot, User>.fromHandlers(
      handleData: (snapshot, sink) async {
        sink.add(User.fromSnapshot(snapshot));
      });

  final toUsers = StreamTransformer<QuerySnapshot, List<User>>.fromHandlers(
      handleData: (snapshot, sink) {
        List<User> users = [];
        snapshot.documents.forEach((doc) {
          users.add(User.fromSnapshot(doc));
        });
        sink.add(users);
      });

  final toPosts = StreamTransformer<QuerySnapshot, List<Post>>.fromHandlers(
      handleData: (snapshot, sink) {
        List<Post> posts = [];
        snapshot.documents.forEach((doc) {
          posts.add(Post.fromSnapshot(doc));
        });
        sink.add(posts);
      });

  final toUsersExceptMine =
  StreamTransformer<QuerySnapshot, List<User>>.fromHandlers(
      handleData: (snapshot, sink) async {
        List<User> users = [];
        FirebaseUser user = await FirebaseAuth.instance.currentUser();
        snapshot.documents.forEach((doc) {
          if (doc.documentID != user.uid) users.add(User.fromSnapshot(doc));
        });
        sink.add(users);
      });

  final toComments =
  StreamTransformer<QuerySnapshot, List<CommentModel>>.fromHandlers(
      handleData: (snapshot, sink) {
        List<CommentModel> comments = [];
        snapshot.documents.forEach((doc) {
          comments.add(CommentModel.fromSnapshot(doc));
        });
        sink.add(comments);
      });
}