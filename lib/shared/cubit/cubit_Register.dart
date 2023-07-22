// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_be_immutable, unnecessary_string_interpolations, use_key_in_widget_constructors, prefer_const_constructors, avoid_print, unused_local_variable
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/states_Register.dart';
import 'package:shop_app/shared/cubit/states_login.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel loginModel;

  bool isSecure = true;
  void securePassword()
  {
    isSecure=!isSecure;
    emit(ShopSecurePasswordRegister());
  }

  void userRegister({
    required dynamic name,
    required dynamic email,
    required dynamic password,
    required dynamic phone,
  })
  {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(
        url: Register,
        data: {
          'name' : name,
          'email' : email,
          'password' : password,
          'phone' : phone,
        }).then((value)
    {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }


}



//https://newsapi.org/v2/top-headlines?country=eg&category=sports&apiKey=500f21c485414a82a58ea786dd68d504
// https://newsapi.org/v2/top-headlines?country=eg&category=science&apiKey=500f21c485414a82a58ea786dd68d504