import 'package:shop_app/models/shop_app/change_favorites_model.dart';
import 'package:shop_app/models/shop_app/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates
{
  final String error;

  ShopErrorHomeDataState(this.error);
}

class ShopLoadingCategoriesState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates
{
  final String error;

  ShopErrorCategoriesState(this.error);
}

class NewsChangeModeState extends ShopStates  {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates
{
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates
{
  final String error;

  ShopErrorChangeFavoritesState(this.error);
}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates
{
  final String error;

  ShopErrorGetFavoritesState(this.error);
}


class ShopSuccessGetUserDataState extends ShopStates
{
  final ShopLoginModel model;

  ShopSuccessGetUserDataState(this.model);
}

class ShopLoadingGetUserDataState extends ShopStates {}

class ShopErrorGetUserDataState extends ShopStates
{
  final String error;

  ShopErrorGetUserDataState(this.error);
}


class ShopSuccessUpdateUserDataState extends ShopStates
{
  final ShopLoginModel model;

  ShopSuccessUpdateUserDataState(this.model);
}

class ShopLoadingUpdateUserDataState extends ShopStates {}

class ShopErrorUpdateUserDataState extends ShopStates
{
  final String error;

  ShopErrorUpdateUserDataState(this.error);
}

class ShopLogoutLoadingState extends ShopStates{}

class ShopLogoutSuccessState extends ShopStates
{
  final ShopLoginModel model;

  ShopLogoutSuccessState(this.model);
}

class ShopLogoutErrorState extends ShopStates
{
  final String error;

  ShopLogoutErrorState(this.error);
}

class ShopLogoutLoadingState2 extends ShopStates{}

class ShopLogoutSuccessState2 extends ShopStates {}

class ShopLogoutErrorState2 extends ShopStates {}