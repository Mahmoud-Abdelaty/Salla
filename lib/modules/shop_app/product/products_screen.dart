// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unnecessary_null_comparison, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, avoid_unnecessary_containers, avoid_print, sized_box_for_whitespace

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/shop_app/categories_model.dart';
import 'package:shop_app/models/shop_app/home_model.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/cubit_login.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/style/colors.dart';


class ProductsScreen extends StatefulWidget {
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override

  initState() {
    super.initState();
    ShopCubit.get(context).getHomeData();
    ShopCubit.get(context).getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if(state is ShopSuccessChangeFavoritesState)
          {
            if(!state.model.status!)
            {
              Fluttertoast.showToast(
                  msg: state.model.message!,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.black,
                  fontSize: 16.0
              );
            }
          }
        },
        builder: (context, state)
        {
          return ConditionalBuilder(
              condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
              builder: (context) => productsBuilder(ShopCubit.get(context).homeModel! , ShopCubit.get(context).categoriesModel!, context),
              fallback: (context) => Center(child: CircularProgressIndicator()));
        },
    );
  }

  Widget productsBuilder(HomeModel model, CategoriesModel categoriesModel, context) => SingleChildScrollView (
    physics: BouncingScrollPhysics(),
       child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children:
       [
         CarouselSlider(
        items: model.data.banners.map((e) => Image(
          image: NetworkImage('${e.image}'),
          width: double.infinity,
          fit: BoxFit.fill,
        ),).toList(),
        options: CarouselOptions(
          initialPage: 0,
          viewportFraction: 1,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(seconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        ),
      ),
         SizedBox(
           height: 10,
         ),
         Padding(
           padding: const EdgeInsets.symmetric(
             horizontal: 10
           ),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Center(
                 child: Text(
                   'Categories',
                   style: TextStyle(
                     fontSize: 30,
                   ),
                 ),
               ),
               Container(
                 width: double.infinity,
                 height: 100,
                 child: ListView.separated(
                   physics: BouncingScrollPhysics(),
                   scrollDirection: Axis.horizontal,
                     itemBuilder: (context, index) => buildCategories(categoriesModel.data.data[index]),
                     separatorBuilder: (context, index) => SizedBox(width: 8),
                     itemCount: categoriesModel.data.data.length,
                 ),
               ),
               Center(
                 child: Text(
                   'New Products',
                   style: TextStyle(
                     fontSize: 30,
                   ),
                 ),
               ),
             ],
           ),
         ),
         Container(
           color: Colors.grey[300],
           child: GridView.count(
             shrinkWrap: true,
             physics: NeverScrollableScrollPhysics(),
             crossAxisCount: 2,
             mainAxisSpacing: 1,
             crossAxisSpacing: 1,
             childAspectRatio: 1 / 1.58,   //width / height
             children: List.generate(
               model.data.products.length,
                   (index) => buildGridProduct(model.data.products[index], context)),
           ),
         ),
       ],
  ),
  );

  Widget buildGridProduct(ProductsModel model, context) => Container(
    color : Colors.white,
      child :Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
       [
         Stack(
           alignment: AlignmentDirectional.bottomStart,
           children:
           [
             Image(image: NetworkImage(model.image),
               width: double.infinity,
               height: 200,
             ),
             if(model.discount != 0)
             Container(
               color: Colors.red,
               padding: EdgeInsets.symmetric(
                 horizontal: 5
               ),
               child: Text(
                 'Discount  ${model.discount} %',
                 style: TextStyle(
                   fontSize: 10,
                   color: Colors.white
                 ),
               ),
             ),
           ],
         ),
         Padding(
             padding: const EdgeInsets.all(12),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children:
             [
               Text(
                 model.name,
                 maxLines: 2,
                 overflow: TextOverflow.ellipsis,
                 style: TextStyle(
                     fontSize: 14,
                     height: 1.3
                 ),
               ),
               Row(
                 children :
                 [
                   Text(
                     '${model.price}',
                     style: TextStyle(
                       fontSize: 12,
                       color: defaultColor,
                     ),
                   ),
                   SizedBox(
                         width: 20,
                       ),
                   if(model.discount != 0)
                   Text(
                         '${model.oldPrice}',
                         style: TextStyle(
                           fontSize: 10,
                           color: Colors.grey,
                           decoration: TextDecoration.lineThrough,
                         ),
                       ),
                   Spacer(),
                   IconButton(
                       onPressed: ()
                       {
                         ShopCubit.get(context).changeFavorites(model.id);
                       },
                       icon: CircleAvatar(
                         radius: 15,
                         backgroundColor: defaultColor,
                         child: Icon(
                           ShopCubit.get(context).favorites[model.id]! ? Icons.favorite_rounded : Icons.heart_broken_rounded,
                           color: ShopCubit.get(context).favorites[model.id]! ? Colors.red : Colors.white,
                           size: 20,
                         ),
                       )),
                 ],
               ),
             ],
           ),
         ),
    ],
  ),);

  Widget buildCategories(DataModel model) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children:
    [
      Image(
        image: NetworkImage(model.image),
        width: 100,
        height: 100,
        fit: BoxFit.fill,
      ),
      Container(
        width: 100,
        height: 25,
        color: Colors.black.withOpacity(.8),
        child: Text(
          capitalize(model.name),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );

  String capitalize(String string) {
    if (string.isEmpty) {
      return string;
    }
    return string[0].toUpperCase() + string.substring(1);
  }
}
