import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_kenseok_app/constants/material_white_color.dart';
import 'package:instagram_kenseok_app/data/provider/my_user_data.dart';
import 'package:instagram_kenseok_app/firebase/firestore_provider.dart';
import 'package:instagram_kenseok_app/main_page.dart';
import 'package:instagram_kenseok_app/screens/auth_page.dart';
import 'package:instagram_kenseok_app/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';

void main() {
  return runApp(ChangeNotifierProvider<MyUserData>(
      create: (context) => MyUserData(),child: MyApp()));
}

bool isItFirstData = true;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Consumer<MyUserData>(
        builder: (context, myUserData, child){
          switch (myUserData.status) {
            case MyUserDataStatus.progress:
              FirebaseAuth.instance.currentUser().then((firebaseUser) {
                if (firebaseUser == null)
                  myUserData
                    .setNewStatus(MyUserDataStatus.none);
                else
                  firestoreProvider
                    .connectMyUserData(firebaseUser.uid)
                    .listen((user){
                    myUserData.setUserData(user);
                  });
              });
                  return MyProgressIndicator();
            case MyUserDataStatus.exist:
              return MainPage();
            default:
              return AuthPage();
          }
        }
      ),
      theme: ThemeData(primarySwatch: white),
    );
  }
}
