// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_be_immutable, unnecessary_string_interpolations, use_key_in_widget_constructors, prefer_const_constructors, avoid_print, unused_local_variable, prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables, unnecessary_null_comparison, curly_braces_in_flow_control_structures
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop_app/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/modules/shop_app/shop_layout/shop_layout.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/cubit_login.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/style/themes.dart';
import 'shared/cubit/bloc_observer.dart';
import 'shared/components/constants.dart';
import 'shared/network/remote/dio_helper.dart';

void main() async
{
  // يتأكد ان كل حاجة هنا خلصت في الميثود و بعدين يفتح الابلكيشن 👍

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');

  Widget? widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

  token = CacheHelper.getData(key:'t');
  print(token);

  if(onBoarding != null)
    {
      if(token != null) widget = ShopLayout();
      else widget = ShopLoginScreen();
    }else
    {
      widget = OnBoardingScreen();
    }

  print(onBoarding);

  runApp(MyApp(
      isDark : isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {

  late final isDark;
  late final startWidget;

  MyApp({this.isDark,
  this.startWidget});

  @override
  Widget build(BuildContext context) {
          return MultiBlocProvider(
              providers:
              [
                BlocProvider(
                    create: (context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData()
                ),
              ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: startWidget,
              themeMode: ThemeMode.light,
              theme: lightTheme,
              darkTheme: darkTheme,
            ),
          );
  }
}
