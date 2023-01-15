import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/social_layout.dart';
import 'package:social/modules/login/social_login.dart';
import 'package:social/shared/block_of_server.dart';
import 'package:social/shared/cache_helper.dart';

import 'package:social/shared/stayle/constans.dart';
import 'package:social/shared/stayle/themes.dart';
import 'package:social/social_cubit_global/socialcubit_global.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // // If you're going to use other Firebase services in the background, such as Firestore,
  // // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();

  // print("Handling a background message: ${message.messageId}");
}

void main() {
  BlocOverrides.runZoned(
    //i need know it how to worke
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      var token = await FirebaseMessaging.instance.getToken();
      FirebaseMessaging.onMessage.listen((event) {
        print(event.data.toString());
      });
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        print(event.data.toString());
      });
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      await CacheHelper.init();
      Widget widget;
      // bool? onBording = CacheHelper.getBoolean(key: 'onBording');
      uId = CacheHelper.getBoolean(key: 'uId');

      if (uId != null) {
        widget = const SocialLayout_Screen();
      } else {
        widget = SocialLoginScreen();
      }

      runApp(MyApp(widget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget StartWidget;
  const MyApp(this.StartWidget) : super();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => SocialCubit()
              ..getUser()
              ..getPosts()
              ..getAllUser())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: StartWidget,
      ),
    );
  }
}
