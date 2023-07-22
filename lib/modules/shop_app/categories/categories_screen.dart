// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/categories_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).categoriesModel != null,
            builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildCatItem(
                  ShopCubit.get(context).categoriesModel!.data.data[index]),
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemCount: ShopCubit.get(context).categoriesModel!.data.data.length,
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()));

      },
    );
  }
}

Widget buildCatItem(DataModel model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.image),
            width: 100,
            height: 100,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            capitalize(model.name),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_forward_ios,
              ))
        ],
      ),
    );

String capitalize(String string) {
  if (string.isEmpty) {
    return string;
  }
  return string[0].toUpperCase() + string.substring(1);
}
