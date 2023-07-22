// ignore_for_file: unnecessary_late, avoid_print

import 'package:shop_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

void logout(context)
 {
  CacheHelper.removeData(key:'t').then((value) {
   if(value) {
    navigateAndFinish(context, ShopLoginScreen());
    ShopCubit.get(context).currentIndex = 0;
   }
  });
 }


 void printFullText(String text)
 {
  final pattern = RegExp('.{1,800}');    // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
 }

 String? token;