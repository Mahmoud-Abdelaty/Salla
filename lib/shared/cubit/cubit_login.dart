// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_be_immutable, unnecessary_string_interpolations, use_key_in_widget_constructors, prefer_const_constructors, avoid_print, unused_local_variable
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states_login.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel loginModel;

  bool isSecure = true;
  void securePassword()
  {
    isSecure=!isSecure;
    emit(ShopSecurePassword());
  }

  void userLogin({
    required String email,
    required String password,
})
  {
    emit(ShopLoginLoadingState());

    DioHelper.postData(
        url: Login,
        data: {
          'email' : email,
          'password' : password,
        }).then((value)
    {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }




}



//https://newsapi.org/v2/top-headlines?country=eg&category=sports&apiKey=500f21c485414a82a58ea786dd68d504
// https://newsapi.org/v2/top-headlines?country=eg&category=science&apiKey=500f21c485414a82a58ea786dd68d504