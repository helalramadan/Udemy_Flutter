import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout.dart';
import 'package:shopapp/login/shop_login.dart';
import 'package:shopapp/onboard_screen/onbording_screen.dart';
import 'package:shopapp/shared/block_of_server.dart';
import 'package:shopapp/shared/cache_helper.dart';
import 'package:shopapp/shared/dio_helper.dart';
import 'package:shopapp/shared/stayle/constans.dart';
import 'package:shopapp/shared/stayle/themes.dart';
import 'package:shopapp/shop_cubit/shopcubit.dart';

void main() {
  BlocOverrides.runZoned(
    //i need know it how to worke
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      DioHelper.init();
      await CacheHelper.init();
      Widget widget;
      bool? onBording = CacheHelper.getBoolean(key: 'onBording');
      token = CacheHelper.getBoolean(key: 'token');
      if (onBording != null) {
        if (token != null) {
          widget = ShopLayout_Screen();
        } else
          widget = ShopLoginScreen();
      } else
        widget = OnBoard_Screen();
      runApp(MyApp(widget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget StartWidget;
  MyApp(
    this.StartWidget,
  ) : super();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeModel()
              ..getcategoresModel()
              ..favoritesGetModel()
              ..GetUserModels())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: StartWidget,
      ),
    );
  }
}
