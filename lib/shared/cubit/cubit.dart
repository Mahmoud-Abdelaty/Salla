// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/categories_model.dart';
import 'package:shop_app/models/shop_app/change_favorites_model.dart';
import 'package:shop_app/models/shop_app/fvorites_model.dart';
import 'package:shop_app/models/shop_app/home_model.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/modules/shop_app/categories/categories_screen.dart';
import 'package:shop_app/modules/shop_app/favorites/favorites_screen.dart';
import 'package:shop_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop_app/modules/shop_app/product/products_screen.dart';
import 'package:shop_app/modules/shop_app/settings/settings_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  bool isDark = true;

  Map<int?, bool> favorites = {} ;

  // void changeMode({bool? fromShared})
  // {
  //   if(fromShared != null)
  //   {
  //     isDark = fromShared;
  //     emit(NewsChangeModeState());
  //   }else
  //   {
  //     isDark= !isDark;
  //     CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value)
  //     {
  //       emit(NewsChangeModeState());
  //     });
  //   }
  // }

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: Home,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      //print(homeModel.data.banners[0].image);
      //print(homeModel.status);
      //print(favorites.toString());

      homeModel!.data.products.forEach((element)
          {
           favorites.addAll({
             element.id: element.inFavorites
           });
          });

      //print(favorites.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: Get_Categories,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      //print(error.toString());
      emit(ShopErrorCategoriesState(error.toString()));
    });
  }


  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId){

    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());
    //print(favorites[productId]);

    DioHelper.postData(
        url: Favorites,
        data: {
          'product_id':productId
        },
      token: token,
    ).then((value){
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      //print(value.data);

      if(!changeFavoritesModel!.status!){
        favorites[productId] = !favorites[productId]!;
      }else{
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error)
    {
      if(!changeFavoritesModel!.status!){
        favorites[productId] = !favorites[productId]!;
      }
      ShopErrorChangeFavoritesState(error);
    });
  }


  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: Favorites,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      //printFullText(value.data.toString());

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState(error.toString()));
    });
  }


  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(
      url: Profile,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print('Name : ${userModel!.data!.name}');
      //printFullText('name : ${userModel.data!.name}');
      emit(ShopSuccessGetUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetUserDataState(error.toString()));
    });
  }

  void updateUserData({

    required dynamic name,
    required dynamic email,
    required dynamic phone,
}){
    emit(ShopLoadingUpdateUserDataState());

    DioHelper.putData(
      url: updateProfile,
      token: token,
      data:
      {
        'name':name,
        'email':email,
        'phone':phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print('Name : ${userModel?.data?.name}');
      //printFullText('name : ${userModel.data!.name}');
      emit(ShopSuccessUpdateUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserDataState(error.toString()));
    });
  }



  // void logout_(context)
  // {
  //   CacheHelper.removeData(key:'t').then((value) {
  //     if(value) {
  //       navigateAndFinish(context, ShopLoginScreen());
  //       ShopCubit.get(context).currentIndex = 0;
  //       emit(ShopLogoutSuccessState2());
  //     }else{
  //       emit(ShopLogoutErrorState2());
  //     }
  //   });
  //
  // }


  // late ShopLoginModel loginModel;

  // void logout_({
  //   required String token,
  //   context,
  // })
  // {
  //   emit(ShopLogoutLoadingState());
  //
  //   DioHelper.postData(
  //       url: logout,
  //       data: {
  //         'token' : token,
  //       }).then((value)
  //   {
  //     print(value.data);
  //     loginModel = ShopLoginModel.fromJson(value.data);
  //     navigateAndFinish(context, ShopLoginScreen());
  //     ShopCubit.get(context).currentIndex = 0;
  //     emit(ShopLogoutSuccessState(loginModel));
  //   }).catchError((error)
  //   {
  //     print(error.toString());
  //     emit(ShopLogoutErrorState(error.toString()));
  //   });
  // }


}
